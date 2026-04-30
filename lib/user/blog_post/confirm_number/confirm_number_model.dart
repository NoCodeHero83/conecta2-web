import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'confirm_number_widget.dart' show ConfirmNumberWidget;
import 'package:flutter/material.dart';

class ConfirmNumberModel extends FlutterFlowModel<ConfirmNumberWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    registartionButtonModel.dispose();
  }
}
