import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'thank_you_widget.dart' show ThankYouWidget;
import 'package:flutter/material.dart';

class ThankYouModel extends FlutterFlowModel<ThankYouWidget> {
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
