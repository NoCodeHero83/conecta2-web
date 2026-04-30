import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'enc_tam_open_copy_widget.dart' show EncTamOpenCopyWidget;
import 'package:flutter/material.dart';

class EncTamOpenCopyModel extends FlutterFlowModel<EncTamOpenCopyWidget> {
  ///  Local state fields for this page.

  int? numeropreguntas;

  PreguntasEncuestaStruct? test;
  void updateTestStruct(Function(PreguntasEncuestaStruct) updateFn) {
    updateFn(test ??= PreguntasEncuestaStruct());
  }

  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxListTile widget.
  Map<String, bool> checkboxListTileValueMap = {};
  List<String> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

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

  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    registartionButtonModel.dispose();
  }
}
