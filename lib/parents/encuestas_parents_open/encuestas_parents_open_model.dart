import '/components/footer_parents/footer_parents_widget.dart';
import '/components/header_prof_back/header_prof_back_widget.dart';
import '/components/lista_respuestas_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/components/text_respuesta_widget.dart';
import '/components/verdaderofalso_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'encuestas_parents_open_widget.dart' show EncuestasParentsOpenWidget;
import 'package:flutter/material.dart';

class EncuestasParentsOpenModel
    extends FlutterFlowModel<EncuestasParentsOpenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for HeaderProfBack component.
  late HeaderProfBackModel headerProfBackModel;
  // Models for textRespuesta dynamic component.
  late FlutterFlowDynamicModels<TextRespuestaModel> textRespuestaModels;
  // Models for ListaRespuestas dynamic component.
  late FlutterFlowDynamicModels<ListaRespuestasModel> listaRespuestasModels;
  // Models for verdaderofalso dynamic component.
  late FlutterFlowDynamicModels<VerdaderofalsoModel> verdaderofalsoModels;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;
  // Model for footerParents component.
  late FooterParentsModel footerParentsModel;

  @override
  void initState(BuildContext context) {
    headerProfBackModel = createModel(context, () => HeaderProfBackModel());
    textRespuestaModels = FlutterFlowDynamicModels(() => TextRespuestaModel());
    listaRespuestasModels =
        FlutterFlowDynamicModels(() => ListaRespuestasModel());
    verdaderofalsoModels =
        FlutterFlowDynamicModels(() => VerdaderofalsoModel());
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
    footerParentsModel = createModel(context, () => FooterParentsModel());
  }

  @override
  void dispose() {
    headerProfBackModel.dispose();
    textRespuestaModels.dispose();
    listaRespuestasModels.dispose();
    verdaderofalsoModels.dispose();
    registartionButtonModel.dispose();
    footerParentsModel.dispose();
  }
}
