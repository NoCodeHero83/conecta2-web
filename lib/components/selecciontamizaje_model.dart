import '/flutter_flow/flutter_flow_util.dart';
import 'selecciontamizaje_widget.dart' show SelecciontamizajeWidget;
import 'package:flutter/material.dart';

class SelecciontamizajeModel extends FlutterFlowModel<SelecciontamizajeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxListTile widget.
  Map<String, bool> checkboxListTileValueMap = {};
  List<String> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
