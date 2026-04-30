import '/components/calendario/calendario_widget.dart';
import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'calendar_widget.dart' show CalendarWidget;
import 'package:flutter/material.dart';

class CalendarModel extends FlutterFlowModel<CalendarWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // Model for Calendario component.
  late CalendarioModel calendarioModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    calendarioModel = createModel(context, () => CalendarioModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    calendarioModel.dispose();
  }
}
