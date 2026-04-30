import '/components/footer_parents/footer_parents_widget.dart';
import '/components/header_prof_back/header_prof_back_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'respuesta_parents_open_widget.dart' show RespuestaParentsOpenWidget;
import 'package:flutter/material.dart';

class RespuestaParentsOpenModel
    extends FlutterFlowModel<RespuestaParentsOpenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for HeaderProfBack component.
  late HeaderProfBackModel headerProfBackModel;
  // Model for footerParents component.
  late FooterParentsModel footerParentsModel;

  @override
  void initState(BuildContext context) {
    headerProfBackModel = createModel(context, () => HeaderProfBackModel());
    footerParentsModel = createModel(context, () => FooterParentsModel());
  }

  @override
  void dispose() {
    headerProfBackModel.dispose();
    footerParentsModel.dispose();
  }
}
