import '/backend/backend.dart';
import 'package:flutter/material.dart';

/// Canonical question-type kinds, decoupled from the raw DB string.
///
/// DB strings can include accented/non-accented variants, plural typos, and
/// case differences (e.g. 'Selección' vs 'seleccion'). Use [PreguntaTipo.from]
/// to resolve any raw value to a known kind.
enum PreguntaTipo {
  descriptiva,
  abiertas,
  seleccionMultiple,
  seleccionUnica,
  verdaderoFalso,
  tamizajeRadio,
  tamizajeSustancias,
  condicionante,
  desconocido,
}

/// Normalise a raw string: lowercase, trim, strip accents.
String _normalizeTipo(String? raw) {
  if (raw == null) return '';
  const withAccents = 'áéíóúüñÁÉÍÓÚÜÑ';
  const withoutAccents = 'aeiouunAEIOUUN';
  var s = raw.trim().toLowerCase();
  final buffer = StringBuffer();
  for (final ch in s.split('')) {
    final idx = withAccents.indexOf(ch);
    buffer.write(idx >= 0 ? withoutAccents[idx] : ch);
  }
  return buffer.toString();
}

PreguntaTipo resolvePreguntaTipo(String? raw) {
  final n = _normalizeTipo(raw);
  if (n.isEmpty) return PreguntaTipo.desconocido;
  if (n == 'descriptiva') return PreguntaTipo.descriptiva;
  if (n == 'abiertas' || n == 'abierta') return PreguntaTipo.abiertas;
  if (n == 'seleccion') return PreguntaTipo.seleccionMultiple;
  if (n == 'seleccion unica' ||
      n == 'seleccion_unica' ||
      n == 'selecciónunica' ||
      n == 'seleccionunica') {
    return PreguntaTipo.seleccionUnica;
  }
  if (n == 'verdadero o falso' || n == 'v/f' || n == 'vf') {
    return PreguntaTipo.verdaderoFalso;
  }
  if (n == 'tamizaje (sustancias)' || n == 'tamizaje sustancias') {
    return PreguntaTipo.tamizajeSustancias;
  }
  if (n == 'condicionante') return PreguntaTipo.condicionante;
  // Any tamizaje-family type that isn't Sustancias behaves as a radio choice
  // over `respuestaTamizaje` attributes.
  if (n.startsWith('tamizaje') || n.startsWith('tamizajes')) {
    return PreguntaTipo.tamizajeRadio;
  }
  return PreguntaTipo.desconocido;
}

/// Per-question answer state for the tamizaje wizard.
class RespuestaState {
  RespuestaState(this.pregunta) {
    textController = TextEditingController();
  }

  final PreguntasEncuestaStruct pregunta;
  late final TextEditingController textController;

  /// Selected attribute (for tamizaje-type radio questions).
  AtributosStruct? atributoSeleccionado;

  /// Multiple selection ('seleccion').
  final Set<String> seleccionMultiple = {};

  /// Single selection ('Selección única').
  String? seleccionUnica;

  /// True/false (1 = true, 0 = false).
  int? trueAndFalseSeleccion;

  /// Per-substance selection for 'Tamizaje (Sustancias)'.
  final Map<String, AtributosStruct> sustanciaSelecciones = {};

  /// Selected value for 'Condicionante' questions.
  String? condicionanteSeleccion;

  PreguntaTipo get tipoKind => resolvePreguntaTipo(pregunta.tipo);

  bool esTamizajeRadio() => tipoKind == PreguntaTipo.tamizajeRadio;

  static const sustancias = [
    'Tabaco',
    'Bebidas alcohólicas',
    'Cannabis',
    'Cocaína',
    'Anfetaminas',
    'Inhalantes',
    'Tranquilizantes',
    'Alucinógenos',
    'Opiáceos',
    'Otros',
  ];

  bool estaCompleto() {
    switch (tipoKind) {
      case PreguntaTipo.descriptiva:
        return true;
      case PreguntaTipo.abiertas:
        return textController.text.trim().isNotEmpty;
      case PreguntaTipo.seleccionMultiple:
        return seleccionMultiple.isNotEmpty;
      case PreguntaTipo.seleccionUnica:
        return seleccionUnica != null && seleccionUnica!.isNotEmpty;
      case PreguntaTipo.verdaderoFalso:
        return trueAndFalseSeleccion != null;
      case PreguntaTipo.tamizajeRadio:
        return atributoSeleccionado != null;
      case PreguntaTipo.tamizajeSustancias:
        return sustanciaSelecciones.isNotEmpty;
      case PreguntaTipo.condicionante:
        return condicionanteSeleccion != null;
      case PreguntaTipo.desconocido:
        // Unknown types cannot block the form; treat as completed.
        return true;
    }
  }

  RespuestaTestStruct toStruct(int numero) {
    final kind = tipoKind;
    final rawTipo = pregunta.tipo;

    // Collect tamizaje attributes.
    List<AtributosStruct> tamizajeList = [];
    if (kind == PreguntaTipo.tamizajeRadio && atributoSeleccionado != null) {
      tamizajeList = [atributoSeleccionado!];
    } else if (kind == PreguntaTipo.tamizajeSustancias) {
      tamizajeList = sustanciaSelecciones.values.toList();
    } else if (kind == PreguntaTipo.condicionante &&
        condicionanteSeleccion != null) {
      final match = pregunta.respuestaCondicionante
          .where((c) => c.etiqueta == condicionanteSeleccion)
          .toList();
      if (match.isNotEmpty) {
        tamizajeList = [
          AtributosStruct(
            etiqueta: match.first.etiqueta,
            valor: 0,
          ),
        ];
      }
    }

    String respuestaSU = '';
    if (kind == PreguntaTipo.tamizajeRadio && atributoSeleccionado != null) {
      respuestaSU = atributoSeleccionado!.etiqueta;
    } else if (kind == PreguntaTipo.condicionante) {
      respuestaSU = condicionanteSeleccion ?? '';
    } else if (kind == PreguntaTipo.seleccionUnica) {
      respuestaSU = seleccionUnica ?? '';
    }

    return RespuestaTestStruct(
      pregunta: pregunta.pregunta,
      tipo: rawTipo,
      nPregunta: numero,
      respuesta:
          kind == PreguntaTipo.abiertas ? textController.text.trim() : '',
      respuestaSeleccionUnica: respuestaSU,
      respuestasSeleccionadas: kind == PreguntaTipo.seleccionMultiple
          ? seleccionMultiple.toList()
          : <String>[],
      trueAndFalse: trueAndFalseSeleccion,
      respuestaTamizaje: tamizajeList,
    );
  }
}
