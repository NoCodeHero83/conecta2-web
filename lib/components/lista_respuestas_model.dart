import '/flutter_flow/flutter_flow_util.dart';
import 'lista_respuestas_widget.dart' show ListaRespuestasWidget;
import 'package:flutter/material.dart';

class ListaRespuestasModel extends FlutterFlowModel<ListaRespuestasWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Seleccion widget.
  Map<String, bool> seleccionValueMap = {};
  List<String> get seleccionCheckedItems => seleccionValueMap.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
