import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lista_respuestas_cond_model.dart';
export 'lista_respuestas_cond_model.dart';

class ListaRespuestasCondWidget extends StatefulWidget {
  const ListaRespuestasCondWidget({
    super.key,
    this.parameter2,
    this.parameter3,
  });

  final int? parameter2;
  final List<ValorCondicionanteStruct>? parameter3;

  @override
  State<ListaRespuestasCondWidget> createState() =>
      _ListaRespuestasCondWidgetState();
}

class _ListaRespuestasCondWidgetState extends State<ListaRespuestasCondWidget> {
  late ListaRespuestasCondModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListaRespuestasCondModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        final list = widget.parameter3?.toList() ?? [];

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(list.length, (listIndex) {
            final listItem = list[listIndex];
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                    child: Text(
                      listItem.etiqueta,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().updateRespuestaEncAtIndex(
                      widget.parameter2!,
                      (e) => e
                        ..updateRespuestasSeleccionadas(
                          (e) => e.add(listItem.sustanciaValor),
                        ),
                    );
                    FFAppState().addToTamizajeSustanciaPermitidas(
                        listItem.sustanciaValor);
                    FFAppState().update(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: FFAppState()
                                          .TamizajeSustanciaPermitidas
                                          .where((e) =>
                                              e == listItem.sustanciaValor)
                                          .toList()
                                          .length !=
                                      0
                                  ? FlutterFlowTheme.of(context).secondary
                                  : FlutterFlowTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            child: Visibility(
                              visible: FFAppState()
                                      .TamizajeSustanciaPermitidas
                                      .where(
                                          (e) => e == listItem.sustanciaValor)
                                      .toList()
                                      .length !=
                                  0,
                              child: Icon(
                                Icons.check,
                                color: FFAppState()
                                            .TamizajeSustanciaPermitidas
                                            .where((e) =>
                                                e == listItem.sustanciaValor)
                                            .toList()
                                            .length !=
                                        0
                                    ? FlutterFlowTheme.of(context)
                                        .primaryBackground
                                    : FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 3.0, 0.0),
                            child: Text(
                              'Si',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 5.0)),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    FFAppState().updateRespuestaEncAtIndex(
                      widget.parameter2!,
                      (e) => e
                        ..updateRespuestasSeleccionadas(
                          (e) => e.remove(listItem.sustanciaValor),
                        ),
                    );
                    FFAppState().removeFromTamizajeSustanciaPermitidas(
                        listItem.sustanciaValor);
                    FFAppState().update(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              color: FFAppState()
                                          .TamizajeSustanciaPermitidas
                                          .where((e) =>
                                              e == listItem.sustanciaValor)
                                          .toList()
                                          .length ==
                                      0
                                  ? FlutterFlowTheme.of(context).secondary
                                  : FlutterFlowTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            child: Visibility(
                              visible: FFAppState()
                                      .TamizajeSustanciaPermitidas
                                      .where(
                                          (e) => e == listItem.sustanciaValor)
                                      .toList()
                                      .length ==
                                  0,
                              child: Icon(
                                Icons.check,
                                color: FFAppState()
                                            .TamizajeSustanciaPermitidas
                                            .where((e) =>
                                                e == listItem.sustanciaValor)
                                            .toList()
                                            .length !=
                                        0
                                    ? FlutterFlowTheme.of(context)
                                        .primaryBackground
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                size: 24.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 3.0, 0.0),
                            child: Text(
                              'No',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 5.0)),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            );
          }).divide(SizedBox(height: 10.0)),
        );
      },
    );
  }
}
