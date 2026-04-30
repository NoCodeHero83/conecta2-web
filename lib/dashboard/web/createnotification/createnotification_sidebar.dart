part of 'createnotification_widget.dart';

extension _CreatenotificationSidebar on _CreatenotificationWidgetState {
  Widget buildSidebar(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          30.0, 0.0, 0.0, 0.0),
      child: Container(
        width:
            MediaQuery.sizeOf(context).width *
                0.3,
        height:
            MediaQuery.sizeOf(context).height *
                1.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 50.0,
              color: Color(0x26000000),
              offset: Offset(
                20.0,
                20.0,
              ),
            )
          ],
          borderRadius:
              BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(
                        0.0, 20.0, 0.0, 0.0),
                child: Text(
                  'Vista previa',
                  style: FlutterFlowTheme.of(
                          context)
                      .bodyMedium
                      .override(
                        font: GoogleFonts.inter(
                          fontWeight:
                              FontWeight.w600,
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
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional
                      .fromSTEB(
                          0.0, 40.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model
                          .textController2,
                      focusNode: _model
                          .textFieldFocusNode2,
                      autofocus: true,
                      obscureText: false,
                      decoration:
                          InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(
                                    context)
                                .labelMedium
                                .override(
                                  font:
                                      GoogleFonts
                                          .inter(
                                    fontWeight: FlutterFlowTheme.of(
                                            context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(
                                            context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing:
                                      0.0,
                                  fontWeight: FlutterFlowTheme.of(
                                          context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(
                                          context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Mensaje',
                        hintStyle:
                            FlutterFlowTheme.of(
                                    context)
                                .labelMedium
                                .override(
                                  font:
                                      GoogleFonts
                                          .inter(
                                    fontWeight: FlutterFlowTheme.of(
                                            context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(
                                            context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  fontSize:
                                      18.0,
                                  letterSpacing:
                                      0.0,
                                  fontWeight: FlutterFlowTheme.of(
                                          context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(
                                          context)
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
                        fillColor:
                            Color(0xFFF5F5F5),
                      ),
                      style:
                          FlutterFlowTheme.of(
                                  context)
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
                          .textController2Validator
                          .asValidator(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
