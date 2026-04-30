import '/components/calendario_read2/calendario_read2_widget.dart';
import '/components/footer/footer_widget.dart';
import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'calendario_page_widget.dart' show CalendarioPageWidget;
import 'package:flutter/material.dart';

class CalendarioPageModel extends FlutterFlowModel<CalendarioPageWidget> {
  ///  Local state fields for this page.

  int? emocionelegida;

  String slider = 'Start';

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for CalendarioRead2 component.
  late CalendarioRead2Model calendarioRead2Model;
  // Model for header component.
  late HeaderModel headerModel;
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    calendarioRead2Model = createModel(context, () => CalendarioRead2Model());
    headerModel = createModel(context, () => HeaderModel());
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    calendarioRead2Model.dispose();
    headerModel.dispose();
    footerModel.dispose();
  }
}
