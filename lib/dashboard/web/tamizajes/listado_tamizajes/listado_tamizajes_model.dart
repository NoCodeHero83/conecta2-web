import '/flutter_flow/flutter_flow_util.dart';
import 'listado_tamizajes_widget.dart' show ListadoTamizajesWidget;
import 'package:flutter/material.dart';

class ListadoTamizajesModel
    extends FlutterFlowModel<ListadoTamizajesWidget> {
  /// Currently selected category filter.
  String filtroCategoria = 'Todas';

  /// Currently selected status filter.
  String filtroEstado = 'Todos';

  /// Texto de búsqueda.
  String busqueda = '';

  /// Orden por fecha: true = más recientes primero.
  bool ordenDescendente = true;

  /// Página actual (base cero).
  int paginaActual = 0;

  /// Controllers para la barra de búsqueda.
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
