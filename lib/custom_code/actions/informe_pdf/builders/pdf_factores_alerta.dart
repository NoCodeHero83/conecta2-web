// "Factores de Alerta" checkbox grid section.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../helpers/pdf_styles.dart';

class FactorAlerta {
  final String label;
  final bool checked;
  const FactorAlerta(this.label, this.checked);
}

/// Default fixed list of alert factors matching the reference. All unchecked
/// by default since this data is not yet stored in Firestore.
// TODO: map to tamizaje factors when model is defined
List<FactorAlerta> factoresAlertaPorDefecto() {
  return const [
    // Column 1
    FactorAlerta('CONSUMO DE SUSTANCIAS', false),
    FactorAlerta('IDEACIÓN SUICIDA', false),
    FactorAlerta('INTENTO SUICIDA', false),
    FactorAlerta('VIOLENCIA ECONÓMICA', false),
    FactorAlerta('ALTERACIÓN DE PROCESOS COGNITIVOS', false),
    // Column 2
    FactorAlerta('TRANSTORNOS MENTALES', false),
    FactorAlerta('AFECTACIÓN EMOCIONAL', false),
    FactorAlerta('VIOLENCIA INTRAFAMILIAR', false),
    FactorAlerta('ABANDONO FAMILIAR', false),
    FactorAlerta('ALTERACIÓN DE CONDUCTA MOTORA', false),
    // Column 3
    FactorAlerta('TRANSTORNOS MENTALES', false),
    FactorAlerta('CONFLICTO ARMADO', false),
    FactorAlerta('VIOLENCIA SEXUAL', false),
    FactorAlerta('VIOLENCIA INFANTIL', false),
  ];
}

pw.Widget _checkboxItem(FactorAlerta f) {
  final red = PdfBrand.redAlert;
  final bool checked = f.checked;
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 10),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        checked
            ? pw.Container(
                width: 10,
                height: 10,
                alignment: pw.Alignment.center,
                child: pw.Text(
                  '\u2713',
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: red,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              )
            : pw.Container(
                width: 10,
                height: 10,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.grey500,
                    width: 1,
                  ),
                  borderRadius: pw.BorderRadius.circular(1),
                ),
              ),
        pw.SizedBox(width: 6),
        pw.Expanded(
          child: pw.Text(
            f.label,
            style: pw.TextStyle(
              fontSize: 9,
              color: checked ? red : PdfBrand.darkGrey,
              fontWeight:
                  checked ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Widget buildFactoresAlertaSection({List<FactorAlerta>? factores}) {
  final list = factores ?? factoresAlertaPorDefecto();
  // Split into 3 columns, preserving the reference ordering.
  final col1 = <FactorAlerta>[];
  final col2 = <FactorAlerta>[];
  final col3 = <FactorAlerta>[];
  const col1Count = 5;
  const col2Count = 5;
  for (int i = 0; i < list.length; i++) {
    if (i < col1Count) {
      col1.add(list[i]);
    } else if (i < col1Count + col2Count) {
      col2.add(list[i]);
    } else {
      col3.add(list[i]);
    }
  }

  pw.Widget column(List<FactorAlerta> items) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: items.map(_checkboxItem).toList(),
      );

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      pw.Center(
        child: pw.Text(
          'FACTORES DE ALERTA',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
      ),
      pw.SizedBox(height: 12),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(child: column(col1)),
          pw.Container(
            width: 1,
            height: 120,
            color: PdfColors.grey300,
          ),
          pw.SizedBox(width: 12),
          pw.Expanded(child: column(col2)),
          pw.Container(
            width: 1,
            height: 120,
            color: PdfColors.grey300,
          ),
          pw.SizedBox(width: 12),
          pw.Expanded(child: column(col3)),
        ],
      ),
    ],
  );
}
