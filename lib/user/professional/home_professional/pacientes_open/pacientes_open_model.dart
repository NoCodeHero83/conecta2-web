import '/backend/backend.dart';
import '/components/calendario_read/calendario_read_widget.dart';
import '/components/header_prof_back/header_prof_back_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'pacientes_open_widget.dart' show PacientesOpenWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class PacientesOpenModel extends FlutterFlowModel<PacientesOpenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Model for CalendarioRead component.
  late CalendarioReadModel calendarioReadModel;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  RespuestasRecord? getEncuestas;
  // Model for HeaderProfBack component.
  late HeaderProfBackModel headerProfBackModel;

  @override
  void initState(BuildContext context) {
    calendarioReadModel = createModel(context, () => CalendarioReadModel());
    headerProfBackModel = createModel(context, () => HeaderProfBackModel());
  }

  @override
  void dispose() {
    calendarioReadModel.dispose();
    headerProfBackModel.dispose();
  }
}
