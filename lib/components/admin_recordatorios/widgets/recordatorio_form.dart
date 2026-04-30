import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Form used for both creating and editing a [RecordatorRecord].
///
/// The parent owns the controllers / focus nodes (they live on the model)
/// and supplies [onSave]. Separating create vs. edit is only a matter of
/// the [title] string and what [onSave] does.
class RecordatorioForm extends StatelessWidget {
  const RecordatorioForm({
    super.key,
    required this.title,
    required this.titleController,
    required this.titleFocusNode,
    required this.titleValidator,
    required this.descriptionController,
    required this.descriptionFocusNode,
    required this.descriptionValidator,
    required this.onSave,
    this.leadingAction,
  });

  final String title;

  final TextEditingController titleController;
  final FocusNode titleFocusNode;
  final String? Function(BuildContext, String?)? titleValidator;

  final TextEditingController descriptionController;
  final FocusNode descriptionFocusNode;
  final String? Function(BuildContext, String?)? descriptionValidator;

  final Future<void> Function() onSave;

  /// Optional widget rendered to the left of the save button — used by the
  /// edit form to show a delete icon.
  final Widget? leadingAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      fontSize: 30.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              _label(context, 'Titulo del recordatorio', topPadding: 30.0),
              _field(
                context,
                controller: titleController,
                focusNode: titleFocusNode,
                validator: titleValidator,
                hint: 'Titulo del recordatorio',
                debounceTag: 'recordatorio.title',
              ),
              _label(context, 'Contenido del recordatorio', topPadding: 30.0),
              _field(
                context,
                controller: descriptionController,
                focusNode: descriptionFocusNode,
                validator: descriptionValidator,
                hint: 'Contenido del recordatorio',
                debounceTag: 'recordatorio.description',
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (leadingAction != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 15.0, 0.0),
                        child: leadingAction,
                      ),
                    FFButtonWidget(
                      onPressed: onSave,
                      text: 'Guardar',
                      options: FFButtonOptions(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            60.0, 20.0, 60.0, 20.0),
                        iconPadding: EdgeInsetsDirectional.zero,
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font:
                                  GoogleFonts.inter(fontWeight: FontWeight.w600),
                              color: const Color(0xFF265294),
                              fontSize: 18.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text, {required double topPadding}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, topPadding, 0.0, 0.0),
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w500),
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? Function(BuildContext, String?)? validator,
    required String hint,
    required String debounceTag,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (_) => EasyDebounce.debounce(
            debounceTag,
            const Duration(milliseconds: 100),
            () {},
          ),
          obscureText: false,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  color: FlutterFlowTheme.of(context).accent3,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0x00000000), width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).error,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).error,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
          maxLines: null,
          validator: validator?.asValidator(context),
        ),
      ),
    );
  }
}
