import '/flutter_flow/flutter_flow_util.dart';
import 'encuesta_preguntas_t_copy_copy_widget.dart'
    show EncuestaPreguntasTCopyCopyWidget;
import 'package:flutter/material.dart';

class EncuestaPreguntasTCopyCopyModel
    extends FlutterFlowModel<EncuestaPreguntasTCopyCopyWidget> {
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
