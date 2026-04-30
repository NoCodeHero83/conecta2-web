import '/flutter_flow/flutter_flow_util.dart';
import 'tamizaje_respuesta_widget.dart' show TamizajeRespuestaWidget;
import 'package:flutter/material.dart';

class TamizajeRespuestaModel extends FlutterFlowModel<TamizajeRespuestaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
