part of '../crear_institucion_widget.dart';

extension CIGuardar on _CrearInstitucionWidgetState {
  Widget _buildGuardarButton(BuildContext context) {
    return (
                            FFButtonWidget(
                              onPressed: () async {
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  return;
                                }
                                if (_model.sectorValue == null) {
                                  return;
                                }
                                _model.barriosActual =
                                    await queryBarriosRecordOnce(
                                  queryBuilder: (barriosRecord) =>
                                      barriosRecord.where(
                                    'nombre',
                                    isEqualTo: _model.dropDownBarrioValue,
                                  ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);

                                await ColegiosRecord.collection
                                    .doc()
                                    .set(createColegiosRecordData(
                                      barrio: _model.dropDownBarrioValue,
                                      codDane: _model
                                          .textFieldCodigoTextController.text,
                                      direccion: _model
                                          .textFieldDireccionTextController
                                          .text,
                                      latitud: _model
                                          .textFielddLatitudTextController.text,
                                      longitud: _model
                                          .textFielddLongitudTextController
                                          .text,
                                      municipio:
                                          _model.barriosActual?.municipio,
                                      nombre: _model
                                          .textFieldNombreTextController.text,
                                      sector: _model.sectorValue,
                                    ));
                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              text: 'Guardar',
                              options: FFButtonOptions(
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )
    );
  }
}
