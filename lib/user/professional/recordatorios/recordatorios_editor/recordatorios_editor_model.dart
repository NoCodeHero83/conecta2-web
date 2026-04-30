import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'recordatorios_editor_widget.dart' show RecordatoriosEditorWidget;
import 'package:flutter/material.dart';

class RecordatoriosEditorModel
    extends FlutterFlowModel<RecordatoriosEditorWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    registartionButtonModel.dispose();
  }
}
