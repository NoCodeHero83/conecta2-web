import '/components/lista_respuestas_cond_widget.dart';
import '/components/lista_respuestas_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/components/text_respuesta_widget.dart';
import '/components/verdaderofalso_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'encuestas_adolescente_open2_widget.dart'
    show EncuestasAdolescenteOpen2Widget;
import 'package:flutter/material.dart';

class EncuestasAdolescenteOpen2Model
    extends FlutterFlowModel<EncuestasAdolescenteOpen2Widget> {
  ///  Local state fields for this page.

  int? step = 1;

  ///  State fields for stateful widgets in this page.

  // Models for ListaRespuestasCond dynamic component.
  late FlutterFlowDynamicModels<ListaRespuestasCondModel>
      listaRespuestasCondModels;
  // Models for verdaderofalso dynamic component.
  late FlutterFlowDynamicModels<VerdaderofalsoModel> verdaderofalsoModels;
  // Models for ListaRespuestas dynamic component.
  late FlutterFlowDynamicModels<ListaRespuestasModel> listaRespuestasModels;
  // Models for textRespuesta dynamic component.
  late FlutterFlowDynamicModels<TextRespuestaModel> textRespuestaModels;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel1;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel2;

  @override
  void initState(BuildContext context) {
    listaRespuestasCondModels =
        FlutterFlowDynamicModels(() => ListaRespuestasCondModel());
    verdaderofalsoModels =
        FlutterFlowDynamicModels(() => VerdaderofalsoModel());
    listaRespuestasModels =
        FlutterFlowDynamicModels(() => ListaRespuestasModel());
    textRespuestaModels = FlutterFlowDynamicModels(() => TextRespuestaModel());
    registartionButtonModel1 =
        createModel(context, () => RegistartionButtonModel());
    registartionButtonModel2 =
        createModel(context, () => RegistartionButtonModel());
  }

  @override
  void dispose() {
    listaRespuestasCondModels.dispose();
    verdaderofalsoModels.dispose();
    listaRespuestasModels.dispose();
    textRespuestaModels.dispose();
    registartionButtonModel1.dispose();
    registartionButtonModel2.dispose();
  }
}
