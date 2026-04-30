import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'crear_institucion_widget.dart' show CrearInstitucionWidget;
import 'package:flutter/material.dart';

class CrearInstitucionModel extends FlutterFlowModel<CrearInstitucionWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextFieldNombre widget.
  FocusNode? textFieldNombreFocusNode;
  TextEditingController? textFieldNombreTextController;
  String? Function(BuildContext, String?)?
      textFieldNombreTextControllerValidator;
  String? _textFieldNombreTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'El nombre es obligatorio';
    }

    return null;
  }

  // State field(s) for DropDownBarrio widget.
  String? dropDownBarrioValue;
  FormFieldController<String>? dropDownBarrioValueController;
  // State field(s) for TextFielddLatitud widget.
  FocusNode? textFielddLatitudFocusNode;
  TextEditingController? textFielddLatitudTextController;
  String? Function(BuildContext, String?)?
      textFielddLatitudTextControllerValidator;
  String? _textFielddLatitudTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Latitud es obligatorio';
    }

    if (!RegExp('^-?\\d+(\\.\\d+)?\$').hasMatch(val)) {
      return 'Ingrese coordenada valida';
    }
    return null;
  }

  // State field(s) for TextFielddLongitud widget.
  FocusNode? textFielddLongitudFocusNode;
  TextEditingController? textFielddLongitudTextController;
  String? Function(BuildContext, String?)?
      textFielddLongitudTextControllerValidator;
  String? _textFielddLongitudTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Longitud es obligatorio';
    }

    if (!RegExp('^-?\\d+(\\.\\d+)?\$').hasMatch(val)) {
      return 'Ingrese una coordenada valida';
    }
    return null;
  }

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
  BarriosRecord? barriosActual;

  @override
  void initState(BuildContext context) {
    textFieldNombreTextControllerValidator =
        _textFieldNombreTextControllerValidator;
    textFielddLatitudTextControllerValidator =
        _textFielddLatitudTextControllerValidator;
    textFielddLongitudTextControllerValidator =
        _textFielddLongitudTextControllerValidator;
  }

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
