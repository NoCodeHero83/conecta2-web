import '/flutter_flow/flutter_flow_util.dart';
import 'text_fieltaamizaje_widget.dart' show TextFieltaamizajeWidget;
import 'package:flutter/material.dart';

class TextFieltaamizajeModel extends FlutterFlowModel<TextFieltaamizajeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextFieldEtiqueta widget.
  FocusNode? textFieldEtiquetaFocusNode;
  TextEditingController? textFieldEtiquetaTextController;
  String? Function(BuildContext, String?)?
      textFieldEtiquetaTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldEtiquetaFocusNode?.dispose();
    textFieldEtiquetaTextController?.dispose();
  }
}
