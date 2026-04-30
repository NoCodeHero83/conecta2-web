import '/backend/backend.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'register_continue_widget.dart' show RegisterContinueWidget;
import 'package:flutter/material.dart';

class RegisterContinueModel extends FlutterFlowModel<RegisterContinueWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDownTipoPersona widget.
  String? dropDownTipoPersonaValue;
  FormFieldController<String>? dropDownTipoPersonaValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for correo widget.
  FocusNode? correoFocusNode;
  TextEditingController? correoTextController;
  String? Function(BuildContext, String?)? correoTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for Confirmar Contraseña widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordTextController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;
  // Stores action output result for [Firestore Query - Query a collection] action in registartionButton widget.
  UsersRecord? email;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    confirmPasswordVisibility = false;
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    correoFocusNode?.dispose();
    correoTextController?.dispose();

    textFieldFocusNode2?.dispose();
    passwordTextController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordTextController?.dispose();

    textFieldFocusNode3?.dispose();
    textController2?.dispose();

    registartionButtonModel.dispose();
  }
}
