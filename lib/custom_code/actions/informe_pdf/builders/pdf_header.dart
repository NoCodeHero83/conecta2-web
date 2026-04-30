// Top brand header: yellow bar + logo + contact info row.

import 'package:pdf/widgets.dart' as pw;

import '../helpers/pdf_assets.dart';
import '../helpers/pdf_styles.dart';

/// Full-bleed yellow bar across the top of every page.
pw.Widget buildTopYellowBar() {
  return pw.Container(
    width: double.infinity,
    height: 7,
    color: PdfBrand.yellowBrand,
  );
}

/// Row below the yellow bar with the logo + NIT on the left and the
/// contact info (phone + email) on the right.
pw.Widget buildBrandHeader({PdfAssets? assets}) {
  return pw.Container(
    padding: const pw.EdgeInsets.only(top: 10, bottom: 6),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildLogoPlaceholder(size: 50, logo: assets?.logo),
            pw.SizedBox(height: 4),
            pw.Text(
              'NIT 0123456789',
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.normal,
                color: PdfBrand.cardGrey,
              ),
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.SizedBox(height: 18),
            pw.Text(
              '318 2106656',
              style: pw.TextStyle(
                fontSize: 9,
                color: PdfBrand.darkGrey,
              ),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              'atencionalusuario@ninosdepapel.org',
              style: pw.TextStyle(
                fontSize: 9,
                color: PdfBrand.darkGrey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Full branded top block (yellow bar + header row). Used as the MultiPage
/// header callback.
pw.Widget buildBrandedPageHeader({PdfAssets? assets}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      buildTopYellowBar(),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 32),
        child: buildBrandHeader(assets: assets),
      ),
    ],
  );
}
