// Placeholder section for an "Emociones" block.
//
// The original implementation of `generarInformeIndividualPDF` does not emit
// an emociones section. This file exists so the individual-report feature is
// split along the blocks enumerated in the product brief and so future work
// adding an emotions block has an obvious home.

import 'package:pdf/widgets.dart' as pw;

/// Builds the emociones section. Returns `null` when there is nothing to show
/// (the default today). Callers should skip adding the widget when `null`.
pw.Widget? buildSeccionEmociones() {
  return null;
}
