import '/components/footer_professionals/footer_professionals_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tamizajes_pro_widget.dart' show TamizajesProWidget;
import 'package:flutter/material.dart';

class TamizajesProModel extends FlutterFlowModel<TamizajesProWidget> {
  ///  State fields for stateful widgets in this page.

  /// Texto del buscador (nombre del paciente o tamizaje).
  String busqueda = '';

  /// Orden por fecha: true = descendente (mas recientes primero).
  bool ordenDescendente = true;

  /// Pagina actual (basada en cero) para la paginacion.
  int paginaActual = 0;

  /// Tamano de pagina fijo.
  static const int pageSize = 10;

  // State field(s) for search TextField widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchController;
  String? Function(BuildContext, String?)? searchControllerValidator;

  // Model for footerProfessionals component.
  late FooterProfessionalsModel footerProfessionalsModel;
  // Model for ProfesionalHeader component.
  late ProfesionalHeaderModel profesionalHeaderModel;

  @override
  void initState(BuildContext context) {
    footerProfessionalsModel =
        createModel(context, () => FooterProfessionalsModel());
    profesionalHeaderModel =
        createModel(context, () => ProfesionalHeaderModel());
  }

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchController?.dispose();

    footerProfessionalsModel.dispose();
    profesionalHeaderModel.dispose();
  }
}
