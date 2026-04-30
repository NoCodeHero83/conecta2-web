import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'editar_institucion_widget.dart' show EditarInstitucionWidget;
import 'package:flutter/material.dart';

class EditarInstitucionModel extends FlutterFlowModel<EditarInstitucionWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextFieldNombre widget.
  FocusNode? textFieldNombreFocusNode;
  TextEditingController? textFieldNombreTextController;
  String? Function(BuildContext, String?)?
      textFieldNombreTextControllerValidator;
  // State field(s) for DropDownBarrio widget.
  String? dropDownBarrioValue;
  FormFieldController<String>? dropDownBarrioValueController;
  // State field(s) for TextFielddLatitud widget.
  FocusNode? textFielddLatitudFocusNode;
  TextEditingController? textFielddLatitudTextController;
  String? Function(BuildContext, String?)?
      textFielddLatitudTextControllerValidator;
  // State field(s) for TextFielddLongitud widget.
  FocusNode? textFielddLongitudFocusNode;
  TextEditingController? textFielddLongitudTextController;
  String? Function(BuildContext, String?)?
      textFielddLongitudTextControllerValidator;
  // State field(s) for sector widget.
  String? sectorValue;
  FormFieldController<String>? sectorValueController;
  // State field(s) for TextFieldDireccion widget.
  FocusNode? textFieldDireccionFocusNode;
  TextEditingController? textFieldDireccionTextController;
  String? Function(BuildContext, String?)?
      textFieldDireccionTextControllerValidator;
  // State field(s) for TextFieldCodigo widget.
  FocusNode? textFieldCodigoFocusNode;
  TextEditingController? textFieldCodigoTextController;
  String? Function(BuildContext, String?)?
      textFieldCodigoTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  BarriosRecord? ubicacionDelBarrio;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNombreFocusNode?.dispose();
    textFieldNombreTextController?.dispose();

    textFielddLatitudFocusNode?.dispose();
    textFielddLatitudTextController?.dispose();

    textFielddLongitudFocusNode?.dispose();
    textFielddLongitudTextController?.dispose();

    textFieldDireccionFocusNode?.dispose();
    textFieldDireccionTextController?.dispose();

    textFieldCodigoFocusNode?.dispose();
    textFieldCodigoTextController?.dispose();
  }
}
