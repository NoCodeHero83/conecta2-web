import '/backend/backend.dart';
import '/components/footer_professionals/footer_professionals_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'literatura_pro_widget.dart' show LiteraturaProWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LiteraturaProModel extends FlutterFlowModel<LiteraturaProWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, ContenidoRecord>?
      listViewPagingController;
  Query? listViewPagingQuery;
  List<StreamSubscription?> listViewStreamSubscriptions = [];

  // Model for ProfesionalHeader component.
  late ProfesionalHeaderModel profesionalHeaderModel;
  // Model for footerProfessionals component.
  late FooterProfessionalsModel footerProfessionalsModel;

  @override
  void initState(BuildContext context) {
    profesionalHeaderModel =
        createModel(context, () => ProfesionalHeaderModel());
    footerProfessionalsModel =
        createModel(context, () => FooterProfessionalsModel());
  }

  @override
  void dispose() {
    listViewStreamSubscriptions.forEach((s) => s?.cancel());
    listViewPagingController?.dispose();

    profesionalHeaderModel.dispose();
    footerProfessionalsModel.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, ContenidoRecord> setListViewController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController ??= _createListViewController(query, parent);
    if (listViewPagingQuery != query) {
      listViewPagingQuery = query;
      listViewPagingController?.refresh();
    }
    return listViewPagingController!;
  }

  PagingController<DocumentSnapshot?, ContenidoRecord>
      _createListViewController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller = PagingController<DocumentSnapshot?, ContenidoRecord>(
        firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryContenidoRecordPage(
          queryBuilder: (_) => listViewPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions,
          controller: controller,
          pageSize: 5,
          isStream: true,
        ),
      );
  }
}
