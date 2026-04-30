import '/backend/backend.dart';
import '/components/footer_professionals/footer_professionals_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'encuestas_pro_widget.dart' show EncuestasProWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EncuestasProModel extends FlutterFlowModel<EncuestasProWidget> {
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
  RespuestasRecord? exist;
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
    surveyListsStreamSubscriptions.forEach((s) => s?.cancel());
    surveyListsPagingController?.dispose();

    profesionalHeaderModel.dispose();
    footerProfessionalsModel.dispose();
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
