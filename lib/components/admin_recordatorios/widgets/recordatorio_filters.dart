import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Header row: page title + "Crear nuevo" button + current-user chip.
class RecordatoriosHeader extends StatelessWidget {
  const RecordatoriosHeader({super.key, required this.onCreatePressed});

  final VoidCallback onCreatePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              'Recordatorios',
              overflow: TextOverflow.ellipsis,
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(width: 25.0),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FFButtonWidget(
                  onPressed: onCreatePressed,
                  text: 'Crear nuevo',
                  options: FFButtonOptions(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        60.0, 20.0, 60.0, 20.0),
                    iconPadding: EdgeInsetsDirectional.zero,
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle:
                        FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                              color: const Color(0xFF265294),
                              fontSize: 18.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                            ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                const SizedBox(width: 25.0),
                const _UserChip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserChip extends StatelessWidget {
  const _UserChip();

  static const _fallbackPhoto =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/conecta2-wtnr9n/assets/9yllj3p8hz5o/User.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0, 0.0, 10.0, 0.0),
              child: AuthUserStreamWidget(
                builder: (context) => ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    valueOrDefault<String>(currentUserPhoto, _fallbackPhoto),
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 30.0,
                      height: 30.0,
                      color: const Color(0xFFE0E0E0),
                      child: const Icon(Icons.person,
                          size: 20.0, color: Color(0xFF265294)),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: AuthUserStreamWidget(
                builder: (context) => Text(
                  currentUserDisplayName,
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Search bar with optional "clear" button when a query is active.
class RecordatoriosSearchBar extends StatelessWidget {
  const RecordatoriosSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.validator,
    required this.onChanged,
    required this.showClearButton,
    required this.onClear,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(BuildContext, String?)? validator;
  final ValueChanged<String> onChanged;
  final bool showClearButton;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 300.0,
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              obscureText: false,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Buscar recordatorio',
                hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: FlutterFlowTheme.of(context).accent3,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0x00000000), width: 2.0),
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
                fillColor: FlutterFlowTheme.of(context).web2,
                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                    24.0, 16.0, 24.0, 16.0),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF265294),
                  size: 35.0,
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
              validator: validator?.asValidator(context),
            ),
          ),
          if (showClearButton)
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: const Icon(
                Icons.clear,
                color: Color(0xFF265294),
                size: 24.0,
              ),
              onPressed: onClear,
            ),
        ],
      ),
    );
  }
}
