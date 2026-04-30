import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Top bar of the Resultados screen. Shows a back/reset arrow, a title
/// and the current user's avatar + name.
class ResultadoFilters extends StatelessWidget {
  const ResultadoFilters({
    super.key,
    required this.onReset,
  });

  /// Called when the user taps the back arrow to clear the currently
  /// selected question and related filters.
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onReset,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/Down.png',
              width: 26.0,
              height: 26.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Text(
              'Resultados',
              style: bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle: bodyMedium.fontStyle,
                ),
                fontSize: 36.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: AuthUserStreamWidget(
                    builder: (context) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _userPhoto(currentUserPhoto),
                    ),
                  ),
                ),
                AuthUserStreamWidget(
                  builder: (context) => Text(
                    currentUserDisplayName,
                    style: bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle: bodyMedium.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _userPhoto(String url) {
    if (url.isEmpty) {
      return Image.asset(
        'assets/images/User.png',
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      imageUrl: url,
      width: 30,
      height: 30,
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => Image.asset(
        'assets/images/User.png',
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      ),
    );
  }
}
