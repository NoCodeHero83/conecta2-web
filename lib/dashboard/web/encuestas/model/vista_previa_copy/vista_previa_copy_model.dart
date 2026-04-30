import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'vista_previa_copy_widget.dart' show VistaPreviaCopyWidget;
import 'package:flutter/material.dart';

class VistaPreviaCopyModel extends FlutterFlowModel<VistaPreviaCopyWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Checkbox widget (Condicionante).
  Map<ValorCondicionanteStruct, bool> checkboxValueMap9 = {};
  List<ValorCondicionanteStruct> get checkboxCheckedItems9 =>
      checkboxValueMap9.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for Checkbox widget (Tamizaje).
  Map<AtributosStruct, bool> checkboxValueMap10 = {};
  List<AtributosStruct> get checkboxCheckedItems10 => checkboxValueMap10.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget (generic string).
  Map<String, bool> checkboxValueMap11 = {};
  List<String> get checkboxCheckedItems11 => checkboxValueMap11.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget (preguntas).
  Map<PreguntasEncuestaStruct, bool> checkboxValueMap12 = {};
  List<PreguntasEncuestaStruct> get checkboxCheckedItems12 =>
      checkboxValueMap12.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // State field(s) for Checkbox widget (preguntas alt).
  Map<PreguntasEncuestaStruct, bool> checkboxValueMap13 = {};
  List<PreguntasEncuestaStruct> get checkboxCheckedItems13 =>
      checkboxValueMap13.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
