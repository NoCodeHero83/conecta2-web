import '/dashboard/web/usuarios/model/perfil_adolescente_repuesta/perfil_adolescente_repuesta_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'perfil_acudiente_widget.dart' show PerfilAcudienteWidget;
import 'package:flutter/material.dart';

class PerfilAcudienteModel extends FlutterFlowModel<PerfilAcudienteWidget> {
  ///  Local state fields for this component.

  String slider = 'Datos Personales';

  DateTime? selectedDate;

  DocumentReference? refEncuestas;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for PerfilAdolescenteRepuesta component.
  late PerfilAdolescenteRepuestaModel perfilAdolescenteRepuestaModel;

  @override
  void initState(BuildContext context) {
    perfilAdolescenteRepuestaModel =
        createModel(context, () => PerfilAdolescenteRepuestaModel());
  }

  @override
  void dispose() {
    perfilAdolescenteRepuestaModel.dispose();
  }
}
