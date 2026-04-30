import '/backend/backend.dart';
import '/components/dias/dias_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'calendario_read_widget.dart' show CalendarioReadWidget;
import 'package:flutter/material.dart';

class CalendarioReadModel extends FlutterFlowModel<CalendarioReadWidget> {
  ///  Local state fields for this component.

  DateTime? inputDate;

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this component.

  // Model for Dias component.
  late DiasModel diasModel1;
  // Model for Dias component.
  late DiasModel diasModel2;
  // Model for Dias component.
  late DiasModel diasModel3;
  // Model for Dias component.
  late DiasModel diasModel4;
  // Model for Dias component.
  late DiasModel diasModel5;
  // Model for Dias component.
  late DiasModel diasModel6;
  // Model for Dias component.
  late DiasModel diasModel7;
  // Stores action output result for [Firestore Query - Query a collection] action in DayContainer widget.
  EmocionesRegistroRecord? leerreaccion;

  @override
  void initState(BuildContext context) {
    diasModel1 = createModel(context, () => DiasModel());
    diasModel2 = createModel(context, () => DiasModel());
    diasModel3 = createModel(context, () => DiasModel());
    diasModel4 = createModel(context, () => DiasModel());
    diasModel5 = createModel(context, () => DiasModel());
    diasModel6 = createModel(context, () => DiasModel());
    diasModel7 = createModel(context, () => DiasModel());
  }

  @override
  void dispose() {
    diasModel1.dispose();
    diasModel2.dispose();
    diasModel3.dispose();
    diasModel4.dispose();
    diasModel5.dispose();
    diasModel6.dispose();
    diasModel7.dispose();
  }
}
