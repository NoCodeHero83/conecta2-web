import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'selecciontamizaje_model.dart';
export 'selecciontamizaje_model.dart';

class SelecciontamizajeWidget extends StatefulWidget {
  const SelecciontamizajeWidget({
    super.key,
    this.parameter1,
    this.parameter2,
  });

  final int? parameter1;
  final List<String>? parameter2;

  @override
  State<SelecciontamizajeWidget> createState() =>
      _SelecciontamizajeWidgetState();
}

class _SelecciontamizajeWidgetState extends State<SelecciontamizajeWidget> {
  late SelecciontamizajeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelecciontamizajeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Builder(
              builder: (context) {
                final list = widget.parameter2?.toList() ?? [];

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
                            value: _model.checkboxListTileValueMap[listItem] ??=
                                false,
                            onChanged: (newValue) async {
                              safeSetState(() =>
                                  _model.checkboxListTileValueMap[listItem] =
                                      newValue!);
                              if (newValue!) {
                                FFAppState().updateRespuestaEncAtIndex(
                                  widget.parameter1!,
                                  (e) => e..select2 = listItem,
                                );
                                safeSetState(() {});
                              }
                            },
                            title: Text(
                              listItem,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
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
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
            ),
          ),
        ],
      ),
    );
  }
}
