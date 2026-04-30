// Shared styling/utility helpers for the individual report PDF.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Brand colors from the Niños de Papel reference PDF.
class PdfBrand {
  static const yellowBrand = PdfColor.fromInt(0xFFF2B01C);
  static const redAlert = PdfColor.fromInt(0xFFE5343D);
  static const navyBrand = PdfColor.fromInt(0xFF1D3F8C);
  static const navyDark = PdfColor.fromInt(0xFF0F2259);
  static const obsBlueBg = PdfColor.fromInt(0xFFEEF2FA);
  static const lightGrey = PdfColor.fromInt(0xFFA7A7A7);
  static const darkGrey = PdfColor.fromInt(0xFF4F4F4F);
  static const decorPink = PdfColor.fromInt(0xFFF9D5D4);
  static const decorYellowSoft = PdfColor.fromInt(0xFFFBEEC3);
  static const cardGrey = PdfColor.fromInt(0xFF222222);
  static const yellowBadgeBg = PdfColor.fromInt(0xFFFBEEC3);
  static const redBadgeBg = PdfColor.fromInt(0xFFFBD8D8);
  // Type-based accent colors for tamizaje card borders.
  static const tealSustancias = PdfColor.fromInt(0xFF0FA58C);
  static const blueCondicionante = PdfColor.fromInt(0xFF4285F4);
  static const pinkAutoestima = PdfColor.fromInt(0xFFE91E63);
  // Navy at ~40% alpha for a soft fallback border.
  static const navySoft = PdfColor.fromInt(0x661D3F8C);
}

/// Formats the current moment into ("dd/MM/yyyy", "HH:mm").
({String fecha, String hora}) formatearFechaHoraAhora() {
  final ahora = DateTime.now();
  final fecha =
      '${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}';
  final hora =
      '${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}';
  return (fecha: fecha, hora: hora);
}

PdfColor colorParaNivelRiesgo(String nivelRiesgo, {bool esPorDefecto = false}) {
  if (esPorDefecto) return PdfColors.grey;
  switch (nivelRiesgo.toUpperCase()) {
    case 'BAJO':
      return PdfColors.green;
    case 'MODERADO':
      return PdfBrand.yellowBrand;
    case 'ALTO':
      return PdfBrand.redAlert;
    case 'SEVERO':
      return PdfBrand.yellowBrand;
    default:
      return PdfColors.grey;
  }
}

/// Border color for a tamizaje card based on its risk level and type.
///
/// Priority: severo/alto severity colors first, otherwise type-based accent,
/// with a soft navy fallback.
PdfColor colorBordeTarjeta(String nivelRiesgo, {String? tipoKey, String? titulo}) {
  final nivel = nivelRiesgo.toUpperCase();
  // Severity-first for high-risk cases.
  if (nivel == 'SEVERO') return PdfBrand.yellowBrand;
  if (nivel == 'ALTO') return PdfBrand.redAlert;

  final key = (tipoKey ?? '').toLowerCase();
  final title = (titulo ?? '').toLowerCase();

  if (key == 'condicionante' || title.contains('condicionante')) {
    return PdfBrand.blueCondicionante;
  }
  if (key == 'sustancias' ||
      title.contains('sustancia') ||
      title.contains('assist')) {
    return PdfBrand.tealSustancias;
  }
  if (key == 'rosemberg' ||
      title.contains('rosemberg') ||
      title.contains('rosenberg')) {
    return PdfBrand.navyBrand;
  }
  if (key == 'autoestima' || title.contains('autoestima')) {
    return PdfBrand.pinkAutoestima;
  }
  if (key == 'hamilton' || title.contains('hamilton')) {
    // Non-high hamilton — use soft navy (high is handled above).
    return PdfBrand.navySoft;
  }
  if (nivel == 'MODERADO') return PdfBrand.yellowBrand;
  return PdfBrand.navySoft;
}

/// Color used for the "NIVEL DE RIESGO" value text.
PdfColor colorValorNivelRiesgo(String nivelRiesgo) {
  final n = nivelRiesgo.toUpperCase();
  if (n == 'ALTO' || n == 'SEVERO') return PdfBrand.redAlert;
  return PdfBrand.cardGrey;
}

String sanitizarNombreArchivoSeguro(String nombre) {
  try {
    return nombre
        .replaceAll(RegExp(r'[^a-zA-Z0-9áéíóúÁÉÍÓÚñÑ\s]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .toLowerCase();
  } catch (_) {
    return 'informe_${DateTime.now().millisecondsSinceEpoch}';
  }
}

pw.Widget buildMensajeError(String mensaje) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColors.red50,
      border: pw.Border.all(color: PdfColors.red300, width: 1),
      borderRadius: pw.BorderRadius.circular(5),
    ),
    child: pw.Text(
      mensaje,
      style: const pw.TextStyle(fontSize: 10, color: PdfColors.red900),
    ),
  );
}

pw.Widget buildSeccionAdvertencias(List<String> errores) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColors.orange50,
      border: pw.Border.all(color: PdfColors.orange200, width: 1),
      borderRadius: pw.BorderRadius.circular(5),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'ADVERTENCIAS TÉCNICAS',
          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5),
        ...errores.map((error) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 2),
              child: pw.Text('- $error',
                  style: const pw.TextStyle(fontSize: 8)),
            )),
      ],
    ),
  );
}

/// Renders the brand logo. When [logo] is null (older call sites that
/// don't load the asset bundle yet) falls back to a visible placeholder
/// so the page still lays out correctly.
pw.Widget buildLogoPlaceholder({double size = 50, pw.MemoryImage? logo}) {
  if (logo != null) {
    return pw.Image(logo, width: size, height: size, fit: pw.BoxFit.contain);
  }
  return pw.Container(
    width: size,
    height: size,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.grey500, width: 1),
      borderRadius: pw.BorderRadius.circular(4),
    ),
    alignment: pw.Alignment.center,
    child: pw.Text(
      'LOGO',
      style: pw.TextStyle(
        fontSize: 9,
        color: PdfColors.grey600,
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  );
}
