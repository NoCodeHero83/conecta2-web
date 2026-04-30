import '/components/footer/footer_widget.dart';
import '/components/header/header_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'preview_post_widget.dart' show PreviewPostWidget;
import 'package:flutter/material.dart';

class PreviewPostModel extends FlutterFlowModel<PreviewPostWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;
  // Model for header component.
  late HeaderModel headerModel;
  // Model for footer component.
  late FooterModel footerModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
    headerModel = createModel(context, () => HeaderModel());
    footerModel = createModel(context, () => FooterModel());
  }

  @override
  void dispose() {
    registartionButtonModel.dispose();
    headerModel.dispose();
    footerModel.dispose();
  }
}
