import '/flutter_flow/flutter_flow_util.dart';
import 'tamizaje_respuesta2_widget.dart' show TamizajeRespuesta2Widget;
import 'package:flutter/material.dart';

class TamizajeRespuesta2Model
    extends FlutterFlowModel<TamizajeRespuesta2Widget> {
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
