import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lista_respuestas_tamizaje_widget.dart'
    show ListaRespuestasTamizajeWidget;
import 'package:flutter/material.dart';

class ListaRespuestasTamizajeModel
    extends FlutterFlowModel<ListaRespuestasTamizajeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Seleccion widget.
  Map<AtributosStruct, bool> seleccionValueMap = {};
  List<AtributosStruct> get seleccionCheckedItems => seleccionValueMap.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
