import '/components/button_vazado/button_vazado_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataB3e369 = false;
  FFUploadedFile uploadedLocalFile_uploadDataB3e369 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataB3e369 = '';

  // State field(s) for TextFieldname widget.
  FocusNode? textFieldnameFocusNode;
  TextEditingController? textFieldnameTextController;
  String? Function(BuildContext, String?)? textFieldnameTextControllerValidator;
  // State field(s) for TextFieldemail widget.
  FocusNode? textFieldemailFocusNode;
  TextEditingController? textFieldemailTextController;
  String? Function(BuildContext, String?)?
      textFieldemailTextControllerValidator;
  // State field(s) for TextFieldphone widget.
  FocusNode? textFieldphoneFocusNode;
  TextEditingController? textFieldphoneTextController;
  String? Function(BuildContext, String?)?
      textFieldphoneTextControllerValidator;
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

  @override
  void initState(BuildContext context) {
    buttonVazadoModel = createModel(context, () => ButtonVazadoModel());
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    textFieldnameFocusNode?.dispose();
    textFieldnameTextController?.dispose();

    textFieldemailFocusNode?.dispose();
    textFieldemailTextController?.dispose();

    textFieldphoneFocusNode?.dispose();
    textFieldphoneTextController?.dispose();

    textFielddniFocusNode?.dispose();
    textFielddniTextController?.dispose();

    textFieldaddressFocusNode?.dispose();
    textFieldaddressTextController?.dispose();

    buttonVazadoModel.dispose();
    registartionButtonModel.dispose();
  }
}
