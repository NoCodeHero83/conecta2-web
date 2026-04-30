import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'usuario_actions_menu.dart';

/// A single row in the users table.
///
/// The row shows: avatar + name, role, email, phone, "Ver Perfil" button
/// and a 3-dot popup menu with edit/delete/print actions.
class UsuarioRow extends StatelessWidget {
  const UsuarioRow({
    super.key,
    required this.user,
    required this.currentUserRol,
    required this.onVerPerfil,
    required this.onEditar,
  });

  final UsersRecord user;
  final String currentUserRol;
  final VoidCallback onVerPerfil;
  final VoidCallback onEditar;

  static const _defaultAvatar =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/conecta2-wtnr9n/assets/9yllj3p8hz5o/User.png';

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isAdministrador = currentUserRol == 'Administrador';
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name + avatar
            Flexible(
              child: Container(
                width: width * 0.35,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildAvatar(),
                    const SizedBox(width: 5.0),
                    Flexible(
                      child: Text(
                        user.displayName,
                        style: theme.bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: theme.bodyMedium.fontWeight,
                            fontStyle: theme.bodyMedium.fontStyle,
                          ),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Role
            Flexible(
              child: Container(
                width: width * 0.14,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    user.rol,
                    style: theme.bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: theme.bodyMedium.fontWeight,
                        fontStyle: theme.bodyMedium.fontStyle,
                      ),
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ),
            ),
            // Email
            Flexible(
              child: Container(
                width: width * 0.16,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    user.email,
                    maxLines: 2,
                    style: theme.bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: theme.bodyMedium.fontWeight,
                        fontStyle: theme.bodyMedium.fontStyle,
                      ),
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ),
            ),
            // Phone
            Flexible(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    25.0, 0.0, 20.0, 0.0),
                child: Container(
                  width: width * 0.15,
                  decoration: BoxDecoration(color: theme.secondaryBackground),
                  child: Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      user.phoneNumber,
                      style: theme.bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: theme.bodyMedium.fontWeight,
                          fontStyle: theme.bodyMedium.fontStyle,
                        ),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Ver Perfil button
            Flexible(
              child: Container(
                width: width * 0.12,
                decoration: BoxDecoration(color: theme.secondaryBackground),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: onVerPerfil,
                    text: 'Ver Perfil',
                    options: FFButtonOptions(
                      height: 35.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 0.0, 20.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: const Color(0xFF265294),
                      textStyle: theme.titleSmall.override(
                        font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        color: Colors.white,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            // 3-dot menu (admin only)
            Flexible(
              child: Container(
                width: width * 0.1,
                decoration: const BoxDecoration(),
                child: Visibility(
                  visible: isAdministrador,
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: UsuarioActionsMenu(
                      user: user,
                      onEditar: onEditar,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final url = valueOrDefault<String>(user.photoUrl, _defaultAvatar);
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
        imageUrl: url,
        width: 25.0,
        height: 25.0,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) => _fallbackAvatar(),
        placeholder: (context, _) => _fallbackAvatar(),
      ),
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Colors.grey[400], size: 18.0),
    );
  }
}
