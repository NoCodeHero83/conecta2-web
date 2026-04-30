part of 'editar_contenido_widget.dart';

extension _EditarContenidoSidebar on _EditarContenidoWidgetState {
  Widget buildSidebar(
      BuildContext context, ContenidoRecord rowContenidoRecord) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 50.0,
              color: Color(0x26000000),
              offset: Offset(20.0, 20.0),
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 15.0),
                              child: Text(
                                'Dirigido a:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        FlutterFlowDropDown<String>(
                          multiSelectController:
                              _model.dropDownRolesValueController ??=
                                  FormListFieldController<String>(
                                      _model.dropDownRolesValue ??=
                                          List<String>.from(
                            rowContenidoRecord.roles,
                          )),
                          options: FFAppConstants.Role,
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 56.0,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: Color(0xFF9E8888),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          hintText: 'Seleccionar',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF265294),
                            size: 35.0,
                          ),
                          fillColor: Color(0xFFF5F5F5),
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 4.0),
                          hidesUnderline: true,
                          isOverButton: false,
                          isSearchable: false,
                          isMultiSelect: true,
                          onMultiSelectChanged: (val) => safeSetState(
                              () => _model.dropDownRolesValue = val),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 15.0),
                              child: Text(
                                '¿Notificar cuando se publique?',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder<List<UsersRecord>>(
                          stream: queryUsersRecord(),
                          builder: (context, snapshot) {
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
                            List<UsersRecord> dropDownUsersRecordList =
                                snapshot.data!;

                            return FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(null),
                              options: ['All'],
                              onChanged: (val) async {
                                safeSetState(
                                    () => _model.dropDownValue = val);
                                triggerPushNotification(
                                  notificationTitle: 'nuevo contenido',
                                  notificationText:
                                      'Hemos publicado un nuevo articulo llamado: ${_model.textController.text} puedes verlo en la sección de contenido',
                                  notificationSound: 'default',
                                  userRefs: dropDownUsersRecordList
                                      .map((e) => e.reference)
                                      .toList(),
                                  initialPageName: 'book',
                                  parameterData: {},
                                );
                              },
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 56.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF9E8888),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Seleccionar',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF265294),
                                size: 35.0,
                              ),
                              fillColor: Color(0xFFF5F5F5),
                              elevation: 2.0,
                              borderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderWidth: 2.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.0, 40.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await rowContenidoRecord.reference
                              .update(createContenidoRecordData(
                            titulo: _model.dropDownValue,
                            publicado: false,
                            html: FFAppState().HTML,
                          ));
                          FFAppState().selectUser = 'Contenidoprevia';
                          FFAppState().createEncuesta = true;
                          safeSetState(() {});
                        },
                        text: 'Vista Previa',
                        options: _sidebarOutlineButtonOptions(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.0, 20.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await widget.contenidoID!.update({
                            ...createContenidoRecordData(
                              titulo: _model.textController.text,
                              publicado: false,
                              html: rowContenidoRecord.html,
                              imageProfile:
                                  _model.uploadedFileUrl_uploadDataMes2 != ''
                                      ? _model.uploadedFileUrl_uploadDataMes2
                                      : rowContenidoRecord.imageProfile,
                              imagePortada:
                                  _model.uploadedFileUrl_uploadDataXz5 != ''
                                      ? _model.uploadedFileUrl_uploadDataXz5
                                      : rowContenidoRecord.imagePortada,
                            ),
                            ...mapToFirestore(
                              {'Roles': _model.dropDownRolesValue},
                            ),
                          });
                          FFAppState().selectUser = '';
                          safeSetState(() {});
                        },
                        text: 'Guardar como borrador',
                        options: _sidebarOutlineButtonOptions(context),
                      ),
                    ),
                    Builder(
                      builder: (context) => Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await widget.contenidoID!.update({
                              ...createContenidoRecordData(
                                titulo: _model.textController.text,
                                publicado: true,
                                html: FFAppState().HTML,
                                imageProfile:
                                    _model.uploadedFileUrl_uploadDataMes2 != ''
                                        ? _model.uploadedFileUrl_uploadDataMes2
                                        : rowContenidoRecord.imageProfile,
                                imagePortada:
                                    _model.uploadedFileUrl_uploadDataXz5 != ''
                                        ? _model.uploadedFileUrl_uploadDataXz5
                                        : rowContenidoRecord.imagePortada,
                              ),
                              ...mapToFirestore(
                                {'Roles': _model.dropDownRolesValue},
                              ),
                            });
                            FFAppState().selectUser = '';
                            safeSetState(() {});
                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment:
                                      AlignmentDirectional(0.0, 0.0).resolve(
                                          Directionality.of(context)),
                                  child: WebViewAware(
                                    child: SuccesspopupWidget(),
                                  ),
                                );
                              },
                            );
                          },
                          text: 'Publicar',
                          options: _sidebarPublishButtonOptions(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FFButtonOptions _sidebarOutlineButtonOptions(BuildContext context) =>
      FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 54.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: FlutterFlowTheme.of(context).secondaryBackground,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.inter(
                fontWeight:
                    FlutterFlowTheme.of(context).titleSmall.fontWeight,
                fontStyle:
                    FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: Color(0xFF265294),
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 3.0,
        borderSide: BorderSide(color: Color(0xFFF6BD33), width: 1.0),
        borderRadius: BorderRadius.circular(40.0),
      );

  FFButtonOptions _sidebarPublishButtonOptions(BuildContext context) =>
      FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 54.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: Color(0xFFF6BD33),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.inter(
                fontWeight:
                    FlutterFlowTheme.of(context).titleSmall.fontWeight,
                fontStyle:
                    FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: Color(0xFF265294),
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 3.0,
        borderSide: BorderSide(color: Color(0xFFF6BD33), width: 1.0),
        borderRadius: BorderRadius.circular(40.0),
      );
}
