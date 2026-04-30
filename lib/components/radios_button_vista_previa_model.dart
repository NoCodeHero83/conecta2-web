import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'radios_button_vista_previa_widget.dart'
    show RadiosButtonVistaPreviaWidget;
import 'package:flutter/material.dart';

class RadiosButtonVistaPreviaModel
    extends FlutterFlowModel<RadiosButtonVistaPreviaWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
