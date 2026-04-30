import '/flutter_flow/flutter_flow_util.dart';
import 'tamizajes_manuales_widget.dart' show TamizajesManualesWidget;
import 'package:flutter/material.dart';

class TamizajesManualesModel
    extends FlutterFlowModel<TamizajesManualesWidget> {
  /// Texto del buscador (nombre del paciente o tamizaje).
  String busqueda = '';

  /// Orden por fecha: true = descendente, false = ascendente.
  bool ordenDescendente = true;

  /// Página actual (basada en cero) para la paginación.
  int paginaActual = 0;

  /// Tamaño de página fijo (10 registros por página).
  static const int pageSize = 10;

  /// Controller del campo de búsqueda.
  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  @override
  void initState(BuildContext context) {
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
  }
}
