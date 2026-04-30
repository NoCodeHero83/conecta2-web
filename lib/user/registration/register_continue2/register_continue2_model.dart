import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'register_continue2_widget.dart' show RegisterContinue2Widget;
import 'package:flutter/material.dart';

class RegisterContinue2Model extends FlutterFlowModel<RegisterContinue2Widget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  DateTime? datePicked;
  // State field(s) for DropDownGenero widget.
  String? dropDownGeneroValue;
  FormFieldController<String>? dropDownGeneroValueController;
  // State field(s) for TextFieldColegio widget.
  String? textFieldColegioValue;
  FormFieldController<String>? textFieldColegioValueController;
  // State field(s) for anio widget.
  String? anioValue;
  FormFieldController<String>? anioValueController;
  // State field(s) for eps widget.
  String? epsValue;
  FormFieldController<String>? epsValueController;
  // State field(s) for TextFieldDoc widget.
  FocusNode? textFieldDocFocusNode;
  TextEditingController? textFieldDocTextController;
  String? Function(BuildContext, String?)? textFieldDocTextControllerValidator;
  String? _textFieldDocTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'El documento de identidad es obligatorio';
    }

    return null;
  }

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ColegiosRecord? colegioelegido;

  @override
  void initState(BuildContext context) {
    textFieldDocTextControllerValidator = _textFieldDocTextControllerValidator;
  }

  @override
  void dispose() {
    textFieldDocFocusNode?.dispose();
    textFieldDocTextController?.dispose();
  }
}
