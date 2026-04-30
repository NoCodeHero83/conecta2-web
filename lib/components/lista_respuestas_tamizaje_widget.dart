import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lista_respuestas_tamizaje_model.dart';
export 'lista_respuestas_tamizaje_model.dart';

class ListaRespuestasTamizajeWidget extends StatefulWidget {
  const ListaRespuestasTamizajeWidget({
    super.key,
    this.parameter2,
    this.parameter3,
  });

  final int? parameter2;
  final List<AtributosStruct>? parameter3;

  @override
  State<ListaRespuestasTamizajeWidget> createState() =>
      _ListaRespuestasTamizajeWidgetState();
}

class _ListaRespuestasTamizajeWidgetState
    extends State<ListaRespuestasTamizajeWidget> {
  late ListaRespuestasTamizajeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListaRespuestasTamizajeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final list = widget.parameter3?.toList() ?? [];

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(list.length, (listIndex) {
            final listItem = list[listIndex];
            return Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 1.0,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                  child: CheckboxListTile(
                    value: _model.seleccionValueMap[listItem] ??= false,
                    onChanged: (newValue) async {
                      safeSetState(
                          () => _model.seleccionValueMap[listItem] = newValue!);
                      if (newValue!) {
                        FFAppState().updateRespuestaEncAtIndex(
                          widget.parameter2!,
                          (e) => e
                            ..updateRespuestasSeleccionadas(
                              (e) => e.add(listItem.etiqueta),
                            ),
                        );
                        safeSetState(() {});
                      } else {
                        FFAppState().updateRespuestaEncAtIndex(
                          widget.parameter2!,
                          (e) => e
                            ..updateRespuestasSeleccionadas(
                              (e) => e.remove(_model.seleccionValueMap[listItem]
                                  ?.toString()),
                            ),
                        );
                        safeSetState(() {});
                      }
                    },
                    title: Text(
                      listItem.etiqueta,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).primary,
                    checkColor: FlutterFlowTheme.of(context).info,
                    dense: false,
                    controlAffinity: ListTileControlAffinity.leading,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            );
          }).divide(SizedBox(height: 10.0)),
        );
      },
    );
  }
}
