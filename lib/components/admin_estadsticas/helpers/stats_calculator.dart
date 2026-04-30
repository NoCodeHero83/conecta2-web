// Aggregates tamizaje Respuestas into per-type stats for the admin dashboard.
//
// Pure domain logic (nivel classification, gender/age normalization, bucket
// mapping) lives in `classification.dart` so it can be unit-tested without
// Firebase. This file keeps the impure parts: fetching documents and
// aggregating the classified responses.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show DateTimeRange;

import 'classification.dart';

// Re-export pure helpers so widgets can keep importing a single file.
export 'classification.dart';

/// Canonical tamizaje types handled by the statistics screen.
enum TamizajeTipo {
  todas,
  autoestima,
  cdi,
  beck,
  crqSrq,
  sustancias,
}

extension TamizajeTipoX on TamizajeTipo {
  String get label {
    switch (this) {
      case TamizajeTipo.todas:
        return 'Todas';
      case TamizajeTipo.autoestima:
        return 'Autoestima';
      case TamizajeTipo.cdi:
        return 'CDI';
      case TamizajeTipo.beck:
        return 'Beck';
      case TamizajeTipo.crqSrq:
        return 'CRQ/SRQ';
      case TamizajeTipo.sustancias:
        return 'Sustancias';
    }
  }

  /// Labels for the level distribution axis (ordered low -> critical).
  List<String> get niveles {
    switch (this) {
      case TamizajeTipo.autoestima:
        return const ['Baja', 'Media', 'Elevada'];
      case TamizajeTipo.cdi:
        return const ['Sin sintomatología', 'Leve', 'Severo'];
      case TamizajeTipo.beck:
        return const ['Mínima', 'Leve', 'Moderada', 'Grave'];
      case TamizajeTipo.crqSrq:
        return const ['Sin alerta', 'Moderada', 'Severo'];
      case TamizajeTipo.sustancias:
        return const ['Sin alerta', 'Moderada', 'Severo'];
      case TamizajeTipo.todas:
        return const ['Sin alerta', 'Moderada', 'Severo', 'Grave'];
    }
  }
}

bool _matchesTipo(TamizajeTipo tipo, String titulo) {
  if (tipo == TamizajeTipo.todas) return true;
  final key = tipoKeyFromTitulo(titulo);
  switch (tipo) {
    case TamizajeTipo.autoestima:
      return key == 'autoestima';
    case TamizajeTipo.cdi:
      return key == 'cdi';
    case TamizajeTipo.beck:
      return key == 'bdi';
    case TamizajeTipo.crqSrq:
      return key == 'srq';
    case TamizajeTipo.sustancias:
      return key == 'sustancias';
    case TamizajeTipo.todas:
      return true;
  }
}

TamizajeTipo _resolveTipoForTitulo(String titulo) {
  switch (tipoKeyFromTitulo(titulo)) {
    case 'autoestima':
      return TamizajeTipo.autoestima;
    case 'cdi':
      return TamizajeTipo.cdi;
    case 'bdi':
      return TamizajeTipo.beck;
    case 'srq':
      return TamizajeTipo.crqSrq;
    case 'sustancias':
      return TamizajeTipo.sustancias;
    default:
      return TamizajeTipo.todas;
  }
}

/// A single classified response, ready to be aggregated.
class ClassifiedResponse {
  final String nivel; // maps to one of TamizajeTipo.niveles entries
  final String genero; // Masculino | Femenino | Otro
  final int? edad;
  final TamizajeTipo tipo;

  ClassifiedResponse({
    required this.nivel,
    required this.genero,
    required this.edad,
    required this.tipo,
  });

  String get rangoEdad => rangoEdadFromEdad(edad);
}

/// Aggregated counts returned to the chart widgets.
class StatsAggregates {
  final TamizajeTipo tipo;
  final int total;
  final List<String> niveles;
  final Map<String, Map<String, int>> porGenero; // genero -> nivel -> count
  final Map<String, Map<String, int>> porEdad; // rango -> nivel -> count
  final Map<String, int> distribucion; // nivel -> count

  StatsAggregates({
    required this.tipo,
    required this.total,
    required this.niveles,
    required this.porGenero,
    required this.porEdad,
    required this.distribucion,
  });

  static StatsAggregates empty(TamizajeTipo tipo) => StatsAggregates(
        tipo: tipo,
        total: 0,
        niveles: tipo.niveles,
        porGenero: const {},
        porEdad: const {},
        distribucion: const {},
      );
}

/// Returns the encuesta categoria string for a given [TamizajeTipo].
/// Returns `null` for [TamizajeTipo.todas].
String? categoriaForTipo(TamizajeTipo tipo) {
  switch (tipo) {
    case TamizajeTipo.autoestima:
      return 'Escala autoestima';
    case TamizajeTipo.cdi:
      return 'CDI';
    case TamizajeTipo.beck:
      return 'Depresión Beck';
    case TamizajeTipo.crqSrq:
      return 'CRQ / SRQ';
    case TamizajeTipo.sustancias:
      return 'Consumo de SPA';
    case TamizajeTipo.todas:
      return null;
  }
}

/// Loads the list of published encuestas matching [tipo] for the drill-down
/// selector. Returns an empty list for [TamizajeTipo.todas].
Future<List<({String titulo, DocumentReference ref})>> loadEncuestasByTipo(
  TamizajeTipo tipo,
) async {
  if (tipo == TamizajeTipo.todas) return [];
  try {
    final snap = await FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .get()
        .timeout(const Duration(seconds: 10));
    return snap.docs
        .where((d) {
          final titulo = (d.data()['titulo'] ?? '').toString();
          return _matchesTipo(tipo, titulo);
        })
        .map((d) => (
              titulo: (d.data()['titulo'] ?? '').toString(),
              ref: d.reference,
            ))
        .toList();
  } catch (_) {
    return [];
  }
}

/// Fetches and classifies all Respuestas for a given tamizaje type.
Future<StatsAggregates> loadStats(
  TamizajeTipo tipo, {
  String? colegio,
  DateTimeRange? rango,
  DocumentReference? encuestaRef,
}) async {
  final responses = <ClassifiedResponse>[];
  final userCache = <String, Map<String, dynamic>>{};

  try {
    final snap = await FirebaseFirestore.instance
        .collectionGroup('Respuestas')
        .get()
        .timeout(const Duration(seconds: 20));

    for (final doc in snap.docs) {
      // Filter by specific encuesta when drill-down is active.
      if (encuestaRef != null) {
        final parentRef = doc.reference.parent.parent;
        if (parentRef == null || parentRef.id != encuestaRef.id) continue;
      }

      final data = doc.data();
      final titulo = (data['Titlo'] ?? data['titlo'] ?? '').toString();
      if (titulo.isEmpty) continue;
      if (!_matchesTipo(tipo, titulo)) continue;
      if ((data['invalidado'] as bool?) == true) continue;

      if (rango != null) {
        final fecha = _fechaFromDoc(data);
        if (fecha == null) continue;
        if (fecha.isBefore(rango.start)) continue;
        final endInclusive = rango.end.add(const Duration(days: 1));
        if (!fecha.isBefore(endInclusive)) continue;
      }

      final userRef = data['User_respuesta'];
      if (userRef is! DocumentReference) continue;

      final userData = await _fetchUser(userRef, userCache);
      if (userData == null) continue;

      if (colegio != null && colegio.isNotEmpty) {
        final uc = (userData['colegio'] ?? '').toString();
        if (uc != colegio) continue;
      }

      final items = <Map<String, dynamic>>[];
      final test = data['test'];
      if (test is List) {
        for (final e in test) {
          if (e is Map) items.add(Map<String, dynamic>.from(e));
        }
      }
      final respusta = data['Respusta'];
      if (respusta is List) {
        for (final e in respusta) {
          if (e is Map) items.add(Map<String, dynamic>.from(e));
        }
      }
      if (items.isEmpty) continue;

      responses.add(ClassifiedResponse(
        nivel: classifyNivel(titulo, items,
            puntajeTotal: data['puntajeTotal'] as num?),
        genero: normalizeGenero(userData['genero']?.toString()),
        edad: _edadFromUser(userData),
        tipo: _resolveTipoForTitulo(titulo),
      ));
    }
  } catch (e) {
    return StatsAggregates.empty(tipo);
  }

  return _aggregate(tipo, responses);
}

Future<Map<String, dynamic>?> _fetchUser(
  DocumentReference ref,
  Map<String, Map<String, dynamic>> cache,
) async {
  final key = ref.path;
  if (cache.containsKey(key)) return cache[key];
  try {
    final snap = await ref.get().timeout(const Duration(seconds: 6));
    final data = snap.data();
    if (data is Map<String, dynamic>) {
      cache[key] = data;
      return data;
    }
  } catch (_) {}
  cache[key] = {};
  return null;
}

DateTime? _fechaFromDoc(Map<String, dynamic> data) {
  final f = data['Fecha'] ?? data['fecha'];
  if (f is Timestamp) return f.toDate();
  if (f is DateTime) return f;
  return null;
}

int? _edadFromUser(Map<String, dynamic> user) {
  final fn = user['fecha_nacimiento'];
  DateTime? birth;
  if (fn is Timestamp) birth = fn.toDate();
  if (fn is DateTime) birth = fn;
  if (birth == null) return null;
  final now = DateTime.now();
  int age = now.year - birth.year;
  if (now.month < birth.month ||
      (now.month == birth.month && now.day < birth.day)) {
    age--;
  }
  if (age < 0 || age > 120) return null;
  return age;
}

StatsAggregates _aggregate(
  TamizajeTipo tipo,
  List<ClassifiedResponse> items,
) {
  final niveles = tipo.niveles;
  final rangos = [...kRangosEdad, kRangoEdadFallback];

  final porGenero = <String, Map<String, int>>{
    for (final g in kGeneros) g: {for (final n in niveles) n: 0},
  };
  final porEdad = <String, Map<String, int>>{
    for (final r in rangos) r: {for (final n in niveles) n: 0},
  };
  final distribucion = <String, int>{for (final n in niveles) n: 0};

  for (final r in items) {
    final nivel = mapNivelToBucket(r.nivel, niveles);
    porGenero[r.genero]![nivel] = (porGenero[r.genero]![nivel] ?? 0) + 1;
    final rango = r.rangoEdad;
    porEdad[rango]![nivel] = (porEdad[rango]![nivel] ?? 0) + 1;
    distribucion[nivel] = (distribucion[nivel] ?? 0) + 1;
  }

  return StatsAggregates(
    tipo: tipo,
    total: items.length,
    niveles: niveles,
    porGenero: porGenero,
    porEdad: porEdad,
    distribucion: distribucion,
  );
}

/// Palette for alert levels as defined in the UX spec.
class StatsColors {
  static const verde = 0xFF34A853; // low
  static const amarillo = 0xFFF2B01C; // moderate
  static const rojo = 0xFFE5343D; // severe
  static const rojoOscuro = 0xFFB42318; // grave
  static const gris = 0xFF9AA0A6; // fallback

  static int forNivel(String nivel) {
    final n = nivel.toLowerCase();
    if (n.contains('grave') || n.contains('crítica') || n.contains('critica')) {
      return rojoOscuro;
    }
    if (n.contains('severo') ||
        n.contains('severa') ||
        n.contains('alto') ||
        n.contains('alta')) {
      return rojo;
    }
    if (n.contains('moderada') ||
        n.contains('moderado') ||
        n.contains('media') ||
        n.contains('leve')) {
      return amarillo;
    }
    if (n.contains('baja') ||
        n.contains('mínima') ||
        n.contains('minima') ||
        n.contains('sin') ||
        n.contains('elevada')) {
      return verde;
    }
    return gris;
  }
}
