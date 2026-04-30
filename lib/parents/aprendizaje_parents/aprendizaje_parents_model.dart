import '/components/footer_parents/footer_parents_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'aprendizaje_parents_widget.dart' show AprendizajeParentsWidget;
import 'package:flutter/material.dart';

class AprendizajeParentsModel
    extends FlutterFlowModel<AprendizajeParentsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for footerParents component.
  late FooterParentsModel footerParentsModel;
  // Model for ProfesionalHeader component.
  late ProfesionalHeaderModel profesionalHeaderModel;

  @override
  void initState(BuildContext context) {
    footerParentsModel = createModel(context, () => FooterParentsModel());
    profesionalHeaderModel =
        createModel(context, () => ProfesionalHeaderModel());
  }

  @override
  void dispose() {
    footerParentsModel.dispose();
    profesionalHeaderModel.dispose();
  }
}
