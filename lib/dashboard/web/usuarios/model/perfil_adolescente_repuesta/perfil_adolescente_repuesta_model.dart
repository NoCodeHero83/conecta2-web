import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'perfil_adolescente_repuesta_widget.dart'
    show PerfilAdolescenteRepuestaWidget;
import 'package:flutter/material.dart';

class PerfilAdolescenteRepuestaModel
    extends FlutterFlowModel<PerfilAdolescenteRepuestaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  Map<RespuestaTestStruct, bool> checkboxValueMap1 = {};
  List<RespuestaTestStruct> get checkboxCheckedItems1 =>
      checkboxValueMap1.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for Checkbox widget.
  Map<RespuestaTestStruct, bool> checkboxValueMap2 = {};
  List<RespuestaTestStruct> get checkboxCheckedItems2 =>
      checkboxValueMap2.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for Checkbox widget.
  Map<RespuestaTestStruct, bool> checkboxValueMap3 = {};
  List<RespuestaTestStruct> get checkboxCheckedItems3 =>
      checkboxValueMap3.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
