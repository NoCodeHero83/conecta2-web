import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

/// Bundle of images embedded in the generated PDF (logo + alert
/// triangles). Load once per report with [PdfAssets.load] and pass the
/// resulting instance to the builders so they don't each re-read the
/// same bytes from the asset bundle.
class PdfAssets {
  PdfAssets({
    required this.logo,
    required this.warningRed,
    required this.warningYellow,
  });

  final pw.MemoryImage logo;
  final pw.MemoryImage warningRed;
  final pw.MemoryImage warningYellow;

  static Future<pw.MemoryImage> _img(String path) async {
    final data = await rootBundle.load(path);
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  static Future<PdfAssets> load() async {
    final results = await Future.wait([
      _img('assets/pdf/logo.png'),
      _img('assets/pdf/warning_red.png'),
      _img('assets/pdf/warning_yellow.png'),
    ]);
    return PdfAssets(
      logo: results[0],
      warningRed: results[1],
      warningYellow: results[2],
    );
  }
}
