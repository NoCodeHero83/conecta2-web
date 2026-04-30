part of 'editarnotificacin_widget.dart';

extension _EditarnotificacinForm on _EditarnotificacinWidgetState {
  Widget buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsetsDirectional
                    .fromSTEB(0.0, 20.0,
                        0.0, 0.0),
            child: Text(
              'Detalles',
              style: FlutterFlowTheme
                      .of(context)
                  .bodyMedium
                  .override(
                    font: GoogleFonts
                        .inter(
                      fontWeight:
                          FontWeight
                              .w600,
                      fontStyle:
                          FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                    ),
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(
                                context)
                            .bodyMedium
                            .fontStyle,
                  ),
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional
                    .fromSTEB(0.0, 20.0,
                        0.0, 0.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.max,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              5.0),
                  child: Text(
                    'Mensaje de la notificación',
                    style: FlutterFlowTheme
                            .of(context)
                        .bodyMedium
                        .override(
                          font:
                              GoogleFonts
                                  .inter(
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing:
                              0.0,
                          fontWeight: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ),
                Container(
                  width:
                      double.infinity,
                  child: TextFormField(
                    controller: _model
                        .textController1,
                    focusNode: _model
                        .textFieldFocusNode1,
                    autofocus: true,
                    obscureText: false,
                    decoration:
                        InputDecoration(
                      labelStyle:
                          FlutterFlowTheme.of(
                                  context)
                              .labelMedium
                              .override(
                                font: GoogleFonts
                                    .inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing:
                                    0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      hintText:
                          'Mensaje',
                      hintStyle:
                          FlutterFlowTheme.of(
                                  context)
                              .labelMedium
                              .override(
                                font: GoogleFonts
                                    .inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                fontSize:
                                    18.0,
                                letterSpacing:
                                    0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      enabledBorder:
                          UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                          color: Color(
                              0x00000000),
                          width: 2.0,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                                    8.0),
                      ),
                      focusedBorder:
                          UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                          color: Color(
                              0x00000000),
                          width: 2.0,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                                    8.0),
                      ),
                      errorBorder:
                          UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                          color: Color(
                              0x00000000),
                          width: 2.0,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                                    8.0),
                      ),
                      focusedErrorBorder:
                          UnderlineInputBorder(
                        borderSide:
                            BorderSide(
                          color: Color(
                              0x00000000),
                          width: 2.0,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                                    8.0),
                      ),
                      filled: true,
                      fillColor: Color(
                          0xFFF5F5F5),
                    ),
                    style: FlutterFlowTheme
                            .of(context)
                        .bodyMedium
                        .override(
                          font:
                              GoogleFonts
                                  .inter(
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing:
                              0.0,
                          fontWeight: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                        ),
                    validator: _model
                        .textController1Validator
                        .asValidator(
                            context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional
                    .fromSTEB(0.0, 20.0,
                        0.0, 0.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.max,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              5.0),
                  child: Text(
                    '¿A quién se enviará?',
                    style: FlutterFlowTheme
                            .of(context)
                        .bodyMedium
                        .override(
                          font:
                              GoogleFonts
                                  .inter(
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing:
                              0.0,
                          fontWeight: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ),
                FlutterFlowDropDown<
                    String>(
                  controller: _model
                          .dropDownValueController1 ??=
                      FormFieldController<
                          String>(null),
                  options: [
                    'Adolescente',
                    'Acudiente',
                    'Profesional'
                  ],
                  onChanged: (val) =>
                      safeSetState(() =>
                          _model.dropDownValue1 =
                              val),
                  width:
                      double.infinity,
                  height: 56.0,
                  textStyle:
                      FlutterFlowTheme.of(
                              context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts
                                .inter(
                              fontWeight: FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing:
                                0.0,
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                  hintText:
                      'Please select...',
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme
                            .of(context)
                        .secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme
                          .of(context)
                      .secondaryBackground,
                  elevation: 2.0,
                  borderColor:
                      FlutterFlowTheme.of(
                              context)
                          .alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              16.0,
                              4.0,
                              16.0,
                              4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional
                    .fromSTEB(0.0, 20.0,
                        0.0, 0.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.max,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              5.0),
                  child: Text(
                    '¿A dónde llevará la notificiación?',
                    style: FlutterFlowTheme
                            .of(context)
                        .bodyMedium
                        .override(
                          font:
                              GoogleFonts
                                  .inter(
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing:
                              0.0,
                          fontWeight: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ),
                FlutterFlowDropDown<
                    String>(
                  controller: _model
                          .dropDownValueController2 ??=
                      FormFieldController<
                          String>(null),
                  options: [
                    'Adolescente',
                    'Acudiente',
                    'Profesional'
                  ],
                  onChanged: (val) =>
                      safeSetState(() =>
                          _model.dropDownValue2 =
                              val),
                  width:
                      double.infinity,
                  height: 56.0,
                  textStyle:
                      FlutterFlowTheme.of(
                              context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts
                                .inter(
                              fontWeight: FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing:
                                0.0,
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                  hintText:
                      'Please select...',
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme
                            .of(context)
                        .secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme
                          .of(context)
                      .secondaryBackground,
                  elevation: 2.0,
                  borderColor:
                      FlutterFlowTheme.of(
                              context)
                          .alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              16.0,
                              4.0,
                              16.0,
                              4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional
                    .fromSTEB(0.0, 40.0,
                        0.0, 0.0),
            child: Text(
              '¿Cuándo se enviará a notificación?',
              style: FlutterFlowTheme
                      .of(context)
                  .bodyMedium
                  .override(
                    font: GoogleFonts
                        .inter(
                      fontWeight:
                          FontWeight
                              .w600,
                      fontStyle:
                          FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                    ),
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(
                                context)
                            .bodyMedium
                            .fontStyle,
                  ),
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional
                    .fromSTEB(0.0, 20.0,
                        0.0, 0.0),
            child: Column(
              mainAxisSize:
                  MainAxisSize.max,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              0.0,
                              0.0,
                              0.0,
                              5.0),
                  child: Text(
                    'Hora',
                    style: FlutterFlowTheme
                            .of(context)
                        .bodyMedium
                        .override(
                          font:
                              GoogleFonts
                                  .inter(
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing:
                              0.0,
                          fontWeight: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                                  context)
                              .bodyMedium
                              .fontStyle,
                        ),
                  ),
                ),
                FlutterFlowDropDown<
                    String>(
                  controller: _model
                          .dropDownValueController3 ??=
                      FormFieldController<
                          String>(null),
                  options: [
                    'Adolescente',
                    'Acudiente',
                    'Profesional'
                  ],
                  onChanged: (val) =>
                      safeSetState(() =>
                          _model.dropDownValue3 =
                              val),
                  width:
                      double.infinity,
                  height: 56.0,
                  textStyle:
                      FlutterFlowTheme.of(
                              context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts
                                .inter(
                              fontWeight: FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            letterSpacing:
                                0.0,
                            fontWeight: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                                    context)
                                .bodyMedium
                                .fontStyle,
                          ),
                  hintText:
                      'Please select...',
                  icon: Icon(
                    Icons
                        .keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme
                            .of(context)
                        .secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme
                          .of(context)
                      .secondaryBackground,
                  elevation: 2.0,
                  borderColor:
                      FlutterFlowTheme.of(
                              context)
                          .alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin:
                      EdgeInsetsDirectional
                          .fromSTEB(
                              16.0,
                              4.0,
                              16.0,
                              4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
