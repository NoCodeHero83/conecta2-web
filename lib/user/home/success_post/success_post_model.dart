import '/components/footer/footer_widget.dart';
import '/components/header/header_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'success_post_widget.dart' show SuccessPostWidget;
import 'package:flutter/material.dart';

class SuccessPostModel extends FlutterFlowModel<SuccessPostWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    registartionButtonModel.dispose();
    footerModel.dispose();
  }
}
