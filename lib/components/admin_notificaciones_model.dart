import '/dashboard/web/createnotification/createnotification_widget.dart';
import '/dashboard/web/editarnotificacin/editarnotificacin_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'admin_notificaciones_widget.dart' show AdminNotificacionesWidget;
import 'package:flutter/material.dart';

class AdminNotificacionesModel
    extends FlutterFlowModel<AdminNotificacionesWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for createnotification component.
  late CreatenotificationModel createnotificationModel;
  // Model for Editarnotificacin component.
  late EditarnotificacinModel editarnotificacinModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController = FlutterFlowDataTableController<String>();

  @override
  void initState(BuildContext context) {
    createnotificationModel =
        createModel(context, () => CreatenotificationModel());
    editarnotificacinModel =
        createModel(context, () => EditarnotificacinModel());
  }

  @override
  void dispose() {
    createnotificationModel.dispose();
    editarnotificacinModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    paginatedDataTableController.dispose();
  }
}
