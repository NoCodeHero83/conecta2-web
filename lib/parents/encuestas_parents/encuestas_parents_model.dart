import '/backend/backend.dart';
import '/components/footer_parents/footer_parents_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'encuestas_parents_widget.dart' show EncuestasParentsWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EncuestasParentsModel extends FlutterFlowModel<EncuestasParentsWidget> {
  ///  Local state fields for this page.

  int? retryCount = 0;

  int? maxRetries;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for SurveyLists widget.

  PagingController<DocumentSnapshot?, EncuestasRecord>?
      surveyListsPagingController;
  Query? surveyListsPagingQuery;
  List<StreamSubscription?> surveyListsStreamSubscriptions = [];

  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  RespuestasRecord? exist1;
  // Model for footerParents component.
  late FooterParentsModel footerParentsModel;
  // Model for ProfesionalHeader component.
  late ProfesionalHeaderModel profesionalHeaderModel;

  @override
  void initState(BuildContext context) {
    footerParentsModel = createModel(context, () => FooterParentsModel());
    profesionalHeaderModel =
        createModel(context, () => ProfesionalHeaderModel());
  }

  @override
  void dispose() {
    surveyListsStreamSubscriptions.forEach((s) => s?.cancel());
    surveyListsPagingController?.dispose();

    footerParentsModel.dispose();
    profesionalHeaderModel.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, EncuestasRecord> setSurveyListsController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    surveyListsPagingController ??= _createSurveyListsController(query, parent);
    if (surveyListsPagingQuery != query) {
      surveyListsPagingQuery = query;
      surveyListsPagingController?.refresh();
    }
    return surveyListsPagingController!;
  }

  PagingController<DocumentSnapshot?, EncuestasRecord>
      _createSurveyListsController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller = PagingController<DocumentSnapshot?, EncuestasRecord>(
        firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryEncuestasRecordPage(
          queryBuilder: (_) => surveyListsPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: surveyListsStreamSubscriptions,
          controller: controller,
          pageSize: 5,
          isStream: true,
        ),
      );
  }
}
