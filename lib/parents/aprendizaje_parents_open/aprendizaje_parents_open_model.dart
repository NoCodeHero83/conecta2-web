import '/components/header_prof_back/header_prof_back_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'aprendizaje_parents_open_widget.dart' show AprendizajeParentsOpenWidget;
import 'package:flutter/material.dart';

class AprendizajeParentsOpenModel
    extends FlutterFlowModel<AprendizajeParentsOpenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for HeaderProfBack component.
  late HeaderProfBackModel headerProfBackModel;

  @override
  void initState(BuildContext context) {
    headerProfBackModel = createModel(context, () => HeaderProfBackModel());
  }

  @override
  void dispose() {
    headerProfBackModel.dispose();
  }
}
