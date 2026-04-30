import '/backend/backend.dart';
import '/components/footer_parents/footer_parents_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_parents_widget.dart' show HomeParentsWidget;
import 'package:flutter/material.dart';

class HomeParentsModel extends FlutterFlowModel<HomeParentsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
          pageViewController1!.hasClients &&
          pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  RespuestasRecord? exist5;
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
