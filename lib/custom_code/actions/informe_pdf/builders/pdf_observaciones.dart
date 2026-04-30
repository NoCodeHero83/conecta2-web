// "Observaciones médicas" light-blue card.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '/components/rich_text_notas/rich_text_notas_widget.dart'
    show quillDeltaToPlainText;
import '../helpers/pdf_styles.dart';

pw.Widget buildObservacionesSection(String observaciones) {
  // Observaciones may come as a Quill Delta JSON string (rich editor) or
  // as legacy plain text; normalise to plain text for PDF rendering.
  final plain = quillDeltaToPlainText(observaciones);
  final texto = plain.trim().isEmpty
      ? 'No hay observaciones registradas'
      : plain.trim();

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'OBSERVACIONES MEDICAS',
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.black,
        ),
      ),
      pw.SizedBox(height: 8),
      pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(18),
        decoration: pw.BoxDecoration(
          color: PdfBrand.obsBlueBg,
          border: pw.Border.all(
            color: PdfColor.fromInt(0x801D3F8C),
            width: 0.8,
          ),
          borderRadius: pw.BorderRadius.circular(12),
        ),
        child: pw.Text(
          texto,
          style: pw.TextStyle(
            fontSize: 9,
            color: PdfBrand.darkGrey,
          ),
          textAlign: pw.TextAlign.left,
        ),
      ),
    ],
  );
}
