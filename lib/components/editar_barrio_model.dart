import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'editar_barrio_widget.dart' show EditarBarrioWidget;
import 'package:flutter/material.dart';

class EditarBarrioModel extends FlutterFlowModel<EditarBarrioWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldNombreFocusNode?.dispose();
    textFieldNombreTextController?.dispose();
  }
}
