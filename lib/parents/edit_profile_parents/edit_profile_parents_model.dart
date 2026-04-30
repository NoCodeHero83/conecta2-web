import '/components/button_vazado/button_vazado_widget.dart';
import '/components/header_prof_back/header_prof_back_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_profile_parents_widget.dart' show EditProfileParentsWidget;
import 'package:flutter/material.dart';

class EditProfileParentsModel
    extends FlutterFlowModel<EditProfileParentsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextFieldname widget.
  FocusNode? textFieldnameFocusNode;
  TextEditingController? textFieldnameTextController;
  String? Function(BuildContext, String?)? textFieldnameTextControllerValidator;
  // State field(s) for TextFieldemail widget.
  FocusNode? textFieldemailFocusNode;
  TextEditingController? textFieldemailTextController;
  String? Function(BuildContext, String?)?
      textFieldemailTextControllerValidator;
  // State field(s) for TextFieldcelular widget.
  FocusNode? textFieldcelularFocusNode;
  TextEditingController? textFieldcelularTextController;
  String? Function(BuildContext, String?)?
      textFieldcelularTextControllerValidator;
  // State field(s) for TextFielddni widget.
  FocusNode? textFielddniFocusNode;
  TextEditingController? textFielddniTextController;
  String? Function(BuildContext, String?)? textFielddniTextControllerValidator;
  // State field(s) for TextFieldaddress widget.
  FocusNode? textFieldaddressFocusNode;
  TextEditingController? textFieldaddressTextController;
  String? Function(BuildContext, String?)?
      textFieldaddressTextControllerValidator;
  // Model for buttonVazado component.
  late ButtonVazadoModel buttonVazadoModel;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;
  // Model for HeaderProfBack component.
  late HeaderProfBackModel headerProfBackModel;

  @override
  void initState(BuildContext context) {
    buttonVazadoModel = createModel(context, () => ButtonVazadoModel());
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
    headerProfBackModel = createModel(context, () => HeaderProfBackModel());
  }

  @override
  void dispose() {
    textFieldnameFocusNode?.dispose();
    textFieldnameTextController?.dispose();

    textFieldemailFocusNode?.dispose();
    textFieldemailTextController?.dispose();

    textFieldcelularFocusNode?.dispose();
    textFieldcelularTextController?.dispose();

    textFielddniFocusNode?.dispose();
    textFielddniTextController?.dispose();

    textFieldaddressFocusNode?.dispose();
    textFieldaddressTextController?.dispose();

    buttonVazadoModel.dispose();
    registartionButtonModel.dispose();
    headerProfBackModel.dispose();
  }
}
