import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'crear_institucion_model.dart';
export 'crear_institucion_model.dart';
part 'crear_institucion_parts/header.dart';
part 'crear_institucion_parts/nombre.dart';
part 'crear_institucion_parts/barrio.dart';
part 'crear_institucion_parts/latlon.dart';
part 'crear_institucion_parts/sector_direccion.dart';
part 'crear_institucion_parts/codigo.dart';
part 'crear_institucion_parts/guardar.dart';

class CrearInstitucionWidget extends StatefulWidget {
  const CrearInstitucionWidget({super.key});

  @override
  State<CrearInstitucionWidget> createState() => _CrearInstitucionWidgetState();
}

class _CrearInstitucionWidgetState extends State<CrearInstitucionWidget> {
  late CrearInstitucionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CrearInstitucionModel());

    _model.textFieldNombreTextController ??= TextEditingController();
    _model.textFieldNombreFocusNode ??= FocusNode();

    _model.textFielddLatitudTextController ??= TextEditingController();
    _model.textFielddLatitudFocusNode ??= FocusNode();

    _model.textFielddLongitudTextController ??= TextEditingController();
    _model.textFielddLongitudFocusNode ??= FocusNode();

    _model.textFieldDireccionTextController ??= TextEditingController();
    _model.textFieldDireccionFocusNode ??= FocusNode();

    _model.textFieldCodigoTextController ??= TextEditingController();
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
        child: Container(
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
                              _buildNombre(context),
                              _buildBarrio(context, formBarriosRecordList),
                              _buildLatLon(context),
                              _buildSectorDir(context),
                            ],
                          ),
                        ),
                        _buildCodigo(context),
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
                            child: _buildGuardarButton(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
