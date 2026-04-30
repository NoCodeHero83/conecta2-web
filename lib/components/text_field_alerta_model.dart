import '/flutter_flow/flutter_flow_util.dart';
import 'text_field_alerta_widget.dart' show TextFieldAlertaWidget;
import 'package:flutter/material.dart';

class TextFieldAlertaModel extends FlutterFlowModel<TextFieldAlertaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextFieldMin1 widget.
  FocusNode? textFieldMin1FocusNode;
  TextEditingController? textFieldMin1TextController;
  String? Function(BuildContext, String?)? textFieldMin1TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldMin1FocusNode?.dispose();
    textFieldMin1TextController?.dispose();
  }
}
