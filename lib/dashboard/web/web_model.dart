import '/components/admin_contenido/admin_contenido_widget.dart';
import '/components/admin_encuestas/admin_encuestas_widget.dart';
import '/components/admin_estadsticas/admin_estadsticas_widget.dart';
import '/components/admin_mapa_widget.dart';
import '/components/admin_notificaciones_widget.dart';
import '/components/admin_profile_widget.dart';
import '/components/admin_recordatorios_widget.dart';
import '/components/admin_usuarioss_widget.dart';
import '/components/barrios_widget.dart';
import '/components/excel_page_widget.dart';
import '/components/instituciones_widget.dart';
import '/components/menu_pc_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'web_widget.dart' show WebWidget;
import 'package:flutter/material.dart';

/// Holds the one-model-per-section state for the dashboard shell.
/// Each sub-section owns a single model; the previous version had
/// duplicated instances (e.g. `adminEncuestasModel1..4`) because the
/// shell rendered the same widget with different params. With the
/// router migration only one section is mounted at a time, so we
/// keep a single model per section.
class WebModel extends FlutterFlowModel<WebWidget> {
  late MenuPcModel menuPcModel;

  late AdminUsuariossModel adminUsuariossModel;
  late AdminEncuestasModel adminEncuestasModel;
  late AdminEncuestasModel adminTamizajesModel;
  late AdminNotificacionesModel adminNotificacionesModel;
  late AdminContenido2Model adminContenido2Model;
  late AdminEstadsticas2Model adminEstadsticas2Model;
  late AdminProfileModel adminProfileModel;
  late AdminRecordatoriosModel adminRecordatoriosModel;
  late AdminMapaModel adminMapaModel;
  late InstitucionesModel institucionesModel;
  late BarriosModel barriosModel;
  late ExcelPageModel excelPageModel;

  @override
  void initState(BuildContext context) {
    menuPcModel = createModel(context, () => MenuPcModel());
    adminUsuariossModel = createModel(context, () => AdminUsuariossModel());
    adminEncuestasModel = createModel(context, () => AdminEncuestasModel());
    adminTamizajesModel = createModel(context, () => AdminEncuestasModel());
    adminNotificacionesModel =
        createModel(context, () => AdminNotificacionesModel());
    adminContenido2Model = createModel(context, () => AdminContenido2Model());
    adminEstadsticas2Model =
        createModel(context, () => AdminEstadsticas2Model());
    adminProfileModel = createModel(context, () => AdminProfileModel());
    adminRecordatoriosModel =
        createModel(context, () => AdminRecordatoriosModel());
    adminMapaModel = createModel(context, () => AdminMapaModel());
    institucionesModel = createModel(context, () => InstitucionesModel());
    barriosModel = createModel(context, () => BarriosModel());
    excelPageModel = createModel(context, () => ExcelPageModel());
  }

  @override
  void dispose() {
    menuPcModel.dispose();
    adminUsuariossModel.dispose();
    adminEncuestasModel.dispose();
    adminTamizajesModel.dispose();
    adminNotificacionesModel.dispose();
    adminContenido2Model.dispose();
    adminEstadsticas2Model.dispose();
    adminProfileModel.dispose();
    adminRecordatoriosModel.dispose();
    adminMapaModel.dispose();
    institucionesModel.dispose();
    barriosModel.dispose();
    excelPageModel.dispose();
  }
}
