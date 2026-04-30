import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'admin_estadsticas/admin_estadsticas_widget.dart'
    show AdminEstadsticas2Widget;
import 'package:flutter/material.dart';

class AdminEstadsticas2Model extends FlutterFlowModel<AdminEstadsticas2Widget> {
  ///  Local state fields for this component.

  DocumentReference? ref;

  String filtroColegio = '';

  String filtroTamizaje = 'Todos';

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  List<UsersRecord>? all;
  // State field(s) for DropDownTamizaj widget.
  String? dropDownTamizajValue;
  FormFieldController<String>? dropDownTamizajValueController;
  // State field(s) for TextFieldColegio widget.
  String? textFieldColegioValue;
  FormFieldController<String>? textFieldColegioValueController;
  // State field(s) for DropDownNivel widget.
  String? dropDownNivelValue;
  FormFieldController<String>? dropDownNivelValueController;
  // State field(s) for DropDownSustancia widget.
  String? dropDownSustanciaValue;
  FormFieldController<String>? dropDownSustanciaValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
