import '/flutter_flow/flutter_flow_util.dart';
import 'resultados_tami_widget.dart' show ResultadosTamiWidget;
import 'package:flutter/material.dart';

class ResultadosTamiModel extends FlutterFlowModel<ResultadosTamiWidget> {
  /// Map of rich-text notas (Quill Delta JSON strings) keyed by the
  /// respuesta document reference path. Replaces the previous
  /// [TextEditingController] map now that notas use a rich editor.
  final Map<String, String> notasValues = {};

  /// Returns the current value for the given ref path, seeding it with
  /// [initialValue] the first time it is requested.
  String notasValueFor(String refPath, {String initialValue = ''}) {
    return notasValues.putIfAbsent(refPath, () => initialValue);
  }

  /// Updates the cached value for [refPath].
  void setNotasValue(String refPath, String value) {
    notasValues[refPath] = value;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    notasValues.clear();
  }
}
