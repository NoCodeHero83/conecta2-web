import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'crear_barrio_widget.dart' show CrearBarrioWidget;
import 'package:flutter/material.dart';

class CrearBarrioModel extends FlutterFlowModel<CrearBarrioWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextFieldNombre widget.
  FocusNode? textFieldNombreFocusNode;
  TextEditingController? textFieldNombreTextController;
  String? Function(BuildContext, String?)?
      textFieldNombreTextControllerValidator;
  // State field(s) for TextFieldMunicipio widget.
  String? textFieldMunicipioValue;
  FormFieldController<String>? textFieldMunicipioValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  BarriosRecord? resultado;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNombreFocusNode?.dispose();
    textFieldNombreTextController?.dispose();
  }
}
