// ignore_for_file: avoid_web_libraries_in_flutter
// Implementación web: descarga vía Blob + AnchorElement.
// Solo se carga cuando dart:html está disponible (web).

import 'dart:html' as html;

void descargarExcelWeb(List<int> bytes, String fileName) {
  final blob = html.Blob(
    [bytes],
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  );
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  Future.delayed(const Duration(seconds: 1), () {
    html.Url.revokeObjectUrl(url);
  });
}
