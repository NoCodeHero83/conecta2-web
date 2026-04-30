// Stub por defecto - no hace nada. Sobreescrito por las versiones
// web/io mediante conditional imports en excel_export.dart.

void descargarExcelWeb(List<int> bytes, String fileName) {
  // No-op en platforms no-web; el caller usa Share.shareXFiles en su lugar.
}
