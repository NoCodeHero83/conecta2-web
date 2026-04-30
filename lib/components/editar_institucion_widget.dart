import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'editar_institucion_model.dart';
export 'editar_institucion_model.dart';
part 'editar_institucion_parts/header.dart';
part 'editar_institucion_parts/nombre.dart';
part 'editar_institucion_parts/barrio.dart';
part 'editar_institucion_parts/latlon.dart';
part 'editar_institucion_parts/sector_direccion.dart';
part 'editar_institucion_parts/codigo.dart';
part 'editar_institucion_parts/guardar.dart';

class EditarInstitucionWidget extends StatefulWidget {
  const EditarInstitucionWidget({
    super.key,
    required this.refInstitucion,
  });

  final DocumentReference? refInstitucion;

  @override
  State<EditarInstitucionWidget> createState() =>
      _EditarInstitucionWidgetState();
}

class _EditarInstitucionWidgetState extends State<EditarInstitucionWidget> {
  late EditarInstitucionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditarInstitucionModel());

    _model.textFieldNombreFocusNode ??= FocusNode();

    _model.textFielddLatitudFocusNode ??= FocusNode();

    _model.textFielddLongitudFocusNode ??= FocusNode();

    _model.textFieldDireccionFocusNode ??= FocusNode();

    _model.textFieldCodigoFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
        child: StreamBuilder<ColegiosRecord>(
          stream: ColegiosRecord.getDocument(widget.refInstitucion!),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }

            final containerColegiosRecord = snapshot.data!;

            return Container(
              constraints: BoxConstraints(
                maxWidth: 800.0,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: StreamBuilder<List<BarriosRecord>>(
                stream: queryBarriosRecord(),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<BarriosRecord> formBarriosRecordList = snapshot.data!;

                  return Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 24.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  _buildNombre(context, containerColegiosRecord),
                                  _buildBarrio(context, containerColegiosRecord, formBarriosRecordList),
                                  _buildLatLon(context, containerColegiosRecord),
                                  _buildSectorDir(context, containerColegiosRecord),
                                ],
                              ),
                            ),
                            _buildCodigo(context, containerColegiosRecord),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 42.0, 0.0, 0.0),
                                child: _buildGuardar(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
