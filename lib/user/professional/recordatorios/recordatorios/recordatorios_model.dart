import '/backend/backend.dart';
import '/components/footer_professionals/footer_professionals_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'recordatorios_widget.dart' show RecordatoriosWidget;
import 'package:flutter/material.dart';

class RecordatoriosModel extends FlutterFlowModel<RecordatoriosWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<RecordatorRecord> simpleSearchResults = [];
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;
  // Model for footerProfessionals component.
  late FooterProfessionalsModel footerProfessionalsModel;
  // Model for ProfesionalHeader component.
  late ProfesionalHeaderModel profesionalHeaderModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
    footerProfessionalsModel =
        createModel(context, () => FooterProfessionalsModel());
    profesionalHeaderModel =
        createModel(context, () => ProfesionalHeaderModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    registartionButtonModel.dispose();
    footerProfessionalsModel.dispose();
    profesionalHeaderModel.dispose();
  }
}
