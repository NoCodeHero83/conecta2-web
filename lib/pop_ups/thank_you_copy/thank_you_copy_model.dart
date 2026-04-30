import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'thank_you_copy_widget.dart' show ThankYouCopyWidget;
import 'package:flutter/material.dart';

class ThankYouCopyModel extends FlutterFlowModel<ThankYouCopyWidget> {
  ///  State fields for stateful widgets in this component.

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
