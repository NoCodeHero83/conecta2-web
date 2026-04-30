// Footer (logo + IPS info) shown at the end of the report.

import 'package:pdf/widgets.dart' as pw;

import '../helpers/pdf_assets.dart';
import '../helpers/pdf_styles.dart';

pw.Widget buildSignatureFooter(String nombreProfesional, {PdfAssets? assets}) {
  // El footer ya no incluye bloque de firma ("Nombre" + "Profesional de la
  // Salud"). Solo queda el logo + datos de la IPS alineados a la izquierda.
  const double topBlockHeight = 60;

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        height: topBlockHeight,
        alignment: pw.Alignment.bottomLeft,
        child: buildLogoPlaceholder(
          size: topBlockHeight,
          logo: assets?.logo,
        ),
      ),
      pw.SizedBox(height: 6),
      pw.Text(
        'IPS ASOCIACIÓN NIN@S DE\nPAPEL COLOMBIA',
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
          color: PdfBrand.navyBrand,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        'NIT 0123456789',
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
          color: PdfBrand.navyBrand,
        ),
      ),
    ],
  );
}
