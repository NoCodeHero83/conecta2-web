import '/components/lista_respuestas_cond_widget.dart';
import '/components/lista_respuestas_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/components/text_respuesta_widget.dart';
import '/components/verdaderofalso_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'encuestas_adolescente_open_widget.dart'
    show EncuestasAdolescenteOpenWidget;
import 'package:flutter/material.dart';

class EncuestasAdolescenteOpenModel
    extends FlutterFlowModel<EncuestasAdolescenteOpenWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for textRespuesta dynamic component.
  late FlutterFlowDynamicModels<TextRespuestaModel> textRespuestaModels;
  // Models for ListaRespuestas dynamic component.
  late FlutterFlowDynamicModels<ListaRespuestasModel> listaRespuestasModels;
  // Models for verdaderofalso dynamic component.
  late FlutterFlowDynamicModels<VerdaderofalsoModel> verdaderofalsoModels;
  // Models for ListaRespuestasCond dynamic component.
  late FlutterFlowDynamicModels<ListaRespuestasCondModel>
      listaRespuestasCondModels;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel;

  // State for 24h block
  bool isBlocked = false;
  String blockMessage = '';

  @override
  void initState(BuildContext context) {
    textRespuestaModels = FlutterFlowDynamicModels(() => TextRespuestaModel());
    listaRespuestasModels =
        FlutterFlowDynamicModels(() => ListaRespuestasModel());
    verdaderofalsoModels =
        FlutterFlowDynamicModels(() => VerdaderofalsoModel());
    listaRespuestasCondModels =
        FlutterFlowDynamicModels(() => ListaRespuestasCondModel());
    registartionButtonModel =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    textRespuestaModels.dispose();
    listaRespuestasModels.dispose();
    verdaderofalsoModels.dispose();
    listaRespuestasCondModels.dispose();
    registartionButtonModel.dispose();
  }
}
