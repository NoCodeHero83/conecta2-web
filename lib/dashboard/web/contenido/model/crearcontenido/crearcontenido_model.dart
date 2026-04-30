import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'crearcontenido_widget.dart' show CrearcontenidoWidget;
import 'package:flutter/material.dart';

class CrearcontenidoModel extends FlutterFlowModel<CrearcontenidoWidget> {
  ///  Local state fields for this component.

  String? imgperfil;

  String? imgportada;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Titulo widget.
  FocusNode? tituloFocusNode;
  TextEditingController? tituloTextController;
  String? Function(BuildContext, String?)? tituloTextControllerValidator;
  bool isDataUploading_uploadDataXz3 = false;
  FFUploadedFile uploadedLocalFile_uploadDataXz3 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataXz3 = '';

  bool isDataUploading_uploadDataXz33 = false;
  FFUploadedFile uploadedLocalFile_uploadDataXz33 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataXz33 = '';

  bool isDataUploading_uploadDataXz2 = false;
  FFUploadedFile uploadedLocalFile_uploadDataXz2 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataXz2 = '';

  bool isDataUploading_uploadDataXz22 = false;
  FFUploadedFile uploadedLocalFile_uploadDataXz22 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataXz22 = '';

  // State field(s) for DropDown widget.
  List<String>? dropDownValue1;
  FormFieldController<List<String>>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tituloFocusNode?.dispose();
    tituloTextController?.dispose();
  }
}
