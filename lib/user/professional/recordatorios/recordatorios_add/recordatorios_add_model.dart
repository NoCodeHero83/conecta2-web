import '/components/header_prof_back/header_prof_back_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'recordatorios_add_widget.dart' show RecordatoriosAddWidget;
import 'package:flutter/material.dart';

class RecordatoriosAddModel extends FlutterFlowModel<RecordatoriosAddWidget> {
  ///  State fields for stateful widgets in this page.

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
  // Model for HeaderProfBack component.
  late HeaderProfBackModel headerProfBackModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
    headerProfBackModel = createModel(context, () => HeaderProfBackModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    registartionButtonModel.dispose();
    headerProfBackModel.dispose();
  }
}
