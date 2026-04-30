import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'resultados_widget.dart' show ResultadosWidget;
import 'package:flutter/material.dart';

class ResultadosModel extends FlutterFlowModel<ResultadosWidget> {
  ///  Local state fields for this component.

  String? tipo2;

  String? pregunta;

  int? itemlist;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget.
  Map<AtributosStruct, bool> checkboxValueMap1 = {};
  List<AtributosStruct> get checkboxCheckedItems1 => checkboxValueMap1.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget.
  Map<String, bool> checkboxValueMap2 = {};
  List<String> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget.
  Map<PreguntasEncuestaStruct, bool> checkboxValueMap3 = {};
  List<PreguntasEncuestaStruct> get checkboxCheckedItems3 =>
      checkboxValueMap3.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for Checkbox widget.
  Map<PreguntasEncuestaStruct, bool> checkboxValueMap4 = {};
  List<PreguntasEncuestaStruct> get checkboxCheckedItems4 =>
      checkboxValueMap4.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
