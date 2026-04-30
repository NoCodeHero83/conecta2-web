import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'usuario_row.dart';

/// Renders the table header row and a list of [UsuarioRow]s.
///
/// This widget is shrink-wrapped and is designed to be hosted inside an
/// outer scroll view. It no longer wraps the list in a fixed-height
/// SizedBox (which caused the 4988px vertical overflow), letting the list
/// size itself to its content and allowing its parent to scroll.
class UsuariosList extends StatelessWidget {
  const UsuariosList({
    super.key,
    required this.users,
    required this.currentUserRol,
    required this.onVerPerfil,
    required this.onEditar,
    this.emptyMessage,
  });

  final List<UsersRecord> users;
  final String currentUserRol;
  final void Function(UsersRecord user) onVerPerfil;
  final void Function(UsersRecord user) onEditar;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
      child: Container(
        width: width,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, theme, width),
            if (users.isEmpty && emptyMessage != null)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  emptyMessage!,
                  style: theme.bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UsuarioRow(
                    user: user,
                    currentUserRol: currentUserRol,
                    onVerPerfil: () => onVerPerfil(user),
                    onEditar: () => onEditar(user),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    FlutterFlowTheme theme,
    double width,
  ) {
    final headerStyle = theme.bodyMedium.override(
      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
      color: const Color(0xFF9E8888),
      fontSize: 18.0,
      letterSpacing: 0.0,
      fontWeight: FontWeight.w500,
    );

    return Container(
      width: width,
      height: 60.0,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                width: width * 0.35,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text('Nombre y Apellidos', style: headerStyle),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: width * 0.14,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text('Tipo de usuario', style: headerStyle),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: width * 0.16,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text('Correo electrónico', style: headerStyle),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: width * 0.15,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text('Celular', style: headerStyle),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: width * 0.12,
                decoration: BoxDecoration(color: theme.secondaryBackground),
              ),
            ),
            Flexible(
              child: Container(
                width: width * 0.1,
                decoration: BoxDecoration(color: theme.secondaryBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
