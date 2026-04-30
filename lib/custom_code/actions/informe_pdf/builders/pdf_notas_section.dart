// Placeholder section for a free-form "Notas" block.
//
// The original implementation of `generarInformeIndividualPDF` does not emit
// a notes section. This file exists so the individual-report feature is
// split along the blocks enumerated in the product brief and so future work
// adding clinician notes has an obvious home.

import 'package:pdf/widgets.dart' as pw;

/// Builds the notes section. Returns `null` when there is nothing to show
/// (the default today). Callers should skip adding the widget when `null`.
pw.Widget? buildSeccionNotas() {
  return null;
}
