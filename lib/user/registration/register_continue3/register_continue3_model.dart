import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'register_continue3_widget.dart' show RegisterContinue3Widget;
import 'package:flutter/material.dart';

class RegisterContinue3Model extends FlutterFlowModel<RegisterContinue3Widget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  DateTime? datePicked1;
  // State field(s) for selectParents widget.
  String? selectParentsValue;
  FormFieldController<String>? selectParentsValueController;
  DateTime? datePicked2;
  // State field(s) for TextFieldNombreParentesco widget.
  FocusNode? textFieldNombreParentescoFocusNode;
  TextEditingController? textFieldNombreParentescoTextController;
  String? Function(BuildContext, String?)?
      textFieldNombreParentescoTextControllerValidator;
  // State field(s) for TextFieldParentesco widget.
  FocusNode? textFieldParentescoFocusNode;
  TextEditingController? textFieldParentescoTextController;
  String? Function(BuildContext, String?)?
      textFieldParentescoTextControllerValidator;
  String? _textFieldParentescoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Parentesco is required';
    }

    return null;
  }

  // State field(s) for correoParentesco widget.
  FocusNode? correoParentescoFocusNode;
  TextEditingController? correoParentescoTextController;
  String? Function(BuildContext, String?)?
      correoParentescoTextControllerValidator;
  String? _correoParentescoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingresa tu correo electrónico is required';
    }

    return null;
  }

  // State field(s) for TextFieldTelefonoParentesco widget.
  FocusNode? textFieldTelefonoParentescoFocusNode;
  TextEditingController? textFieldTelefonoParentescoTextController;
  String? Function(BuildContext, String?)?
      textFieldTelefonoParentescoTextControllerValidator;
  String? _textFieldTelefonoParentescoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingresa tu teléfono is required';
    }

    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? usuarioCreado;

  // Stores the matched parent user found by email lookup.
  UsersRecord? matchedParentUser;

  // Whether a parent was found by email auto-link.
  bool parentLinked = false;

  @override
  void initState(BuildContext context) {
    textFieldParentescoTextControllerValidator =
        _textFieldParentescoTextControllerValidator;
    correoParentescoTextControllerValidator =
        _correoParentescoTextControllerValidator;
    textFieldTelefonoParentescoTextControllerValidator =
        _textFieldTelefonoParentescoTextControllerValidator;
  }

  @override
  void dispose() {
    textFieldNombreParentescoFocusNode?.dispose();
    textFieldNombreParentescoTextController?.dispose();

    textFieldParentescoFocusNode?.dispose();
    textFieldParentescoTextController?.dispose();

    correoParentescoFocusNode?.dispose();
    correoParentescoTextController?.dispose();

    textFieldTelefonoParentescoFocusNode?.dispose();
    textFieldTelefonoParentescoTextController?.dispose();
  }
}
