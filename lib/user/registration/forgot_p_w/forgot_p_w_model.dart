import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'forgot_p_w_widget.dart' show ForgotPWWidget;
import 'package:flutter/material.dart';

class ForgotPWModel extends FlutterFlowModel<ForgotPWWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Correoelectronic widget.
  FocusNode? correoelectronicFocusNode;
  TextEditingController? correoelectronicTextController;
  String? Function(BuildContext, String?)?
      correoelectronicTextControllerValidator;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    correoelectronicFocusNode?.dispose();
    correoelectronicTextController?.dispose();

    registartionButtonModel.dispose();
  }
}
