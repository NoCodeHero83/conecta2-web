// Helpers for alert-level configuration and evaluation by test category.
//
// Each published tamizaje (Autoestima, CDI, Depresión Beck, CRQ/SRQ, Consumo
// de SPA) has a set of predefined alert levels. This file centralises:
//   * `nivelesPorCategoria` -> labels shown in the editor's "Alertas" panel.
//   * `calcularNivelAlerta` -> given a score + saved AlertaStruct list,
//     returns the matching level label for display in the results screen.
//
// It is pure Dart (no Flutter widgets) so it can be reused by the wizard
// results views (web + mobile) and the PDF builder without pulling in
// Material dependencies.

import '/backend/schema/structs/index.dart';

/// Alert level names per tamizaje category (from the requirements doc).
/// The keys match the `categoria` field used in [EncuestasRecord].
const Map<String, List<String>> kNivelesPorCategoria = {
  'Escala autoestima': [
    'Autoestima Baja',
    'Autoestima Media',
    'Autoestima Elevada',
  ],
  'CDI': [
    'Sin sintomatología',
    'Leve',
    'Severo',
  ],
  'Depresión Beck': [
    'Mínima',
    'Leve',
    'Moderada',
    'Grave',
  ],
  'CRQ / SRQ': [
    'Sin alerta',
    'Moderada',
    'Severo',
  ],
  // Consumo de SPA uses per-substance levels (Bajo/Moderado/Alto) handled
  // separately in the sustancias panel.
  'Consumo de SPA': [
    'Bajo',
    'Moderado',
    'Alto',
  ],
};

/// Returns the list of level labels configured for [categoria]. Empty list
/// for unknown categories.
List<String> nivelesPorCategoria(String? categoria) {
  if (categoria == null || categoria.isEmpty) return const [];
  return kNivelesPorCategoria[categoria] ?? const [];
}

/// Returns true when this category uses the "niveles globales" model
/// (single score compared against min/max ranges) instead of per-substance
/// or special condition-based alerts.
bool usaNivelesGlobales(String? categoria) {
  switch (categoria) {
    case 'Escala autoestima':
    case 'CDI':
    case 'Depresión Beck':
      return true;
    default:
      return false;
  }
}

/// Given a [puntaje] and the saved [alertas] list from the encuesta,
/// returns the label of the matching level for [categoria].
///
/// The match uses the `nivel` field on each [AlertaStruct] and checks
/// `min <= puntaje <= max`. When no range matches, the level whose
/// `min` is the highest `<= puntaje` is returned as a fallback.
/// Returns an empty string when nothing can be determined.
String calcularNivelAlerta({
  required String? categoria,
  required int puntaje,
  required List<AlertaStruct> alertas,
}) {
  final niveles = nivelesPorCategoria(categoria);
  if (niveles.isEmpty) return '';

  // Filter alerts that belong to this category (sustancia left empty for
  // global-level tamizajes).
  final relevantes = alertas
      .where((a) => niveles.contains(a.nivel))
      .toList(growable: false);

  if (relevantes.isEmpty) {
    // No persisted ranges -> cannot classify.
    return '';
  }

  // Exact range match.
  for (final a in relevantes) {
    if (puntaje >= a.min && puntaje <= a.max && a.max > 0) {
      return a.nivel;
    }
  }

  // Fallback: highest "min" that the puntaje reaches.
  AlertaStruct? best;
  for (final a in relevantes) {
    if (puntaje >= a.min) {
      if (best == null || a.min > best.min) best = a;
    }
  }
  return best?.nivel ?? relevantes.first.nivel;
}
