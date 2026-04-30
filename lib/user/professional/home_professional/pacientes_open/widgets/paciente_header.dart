import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Default avatar URL used when a user has no profile image set.
const String kDefaultAvatarUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/conecta2-wtnr9n/assets/9yllj3p8hz5o/User.png';

/// Network image with a graceful fallback to the default avatar asset.
class SafeAvatar extends StatelessWidget {
  const SafeAvatar({
    super.key,
    required this.imageUrl,
    this.size = 88.0,
  });

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
        imageUrl: valueOrDefault<String>(imageUrl, kDefaultAvatarUrl),
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => Image.network(
          kDefaultAvatarUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 48),
        ),
      ),
    );
  }
}

/// Top of the patient page: avatar + name + role, and acudiente/professional
/// summary cards.
class PacienteHeader extends StatelessWidget {
  const PacienteHeader({super.key, required this.user});

  final UsersRecord user;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    final label = bodyMedium.override(
      font: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontStyle: bodyMedium.fontStyle,
      ),
      fontSize: 20.0,
      letterSpacing: 0.0,
      fontWeight: FontWeight.w600,
      fontStyle: bodyMedium.fontStyle,
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeAvatar(imageUrl: user.photoUrl, size: 88.0),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName, style: label),
                Text(
                  user.rol,
                  style: bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: bodyMedium.fontWeight,
                      fontStyle: bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: bodyMedium.fontWeight,
                    fontStyle: bodyMedium.fontStyle,
                  ),
                ),
              ],
            ),
          ].divide(const SizedBox(width: 12.0)),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _PersonCard(
                  title: 'Acudiente',
                  name: user.acudiente.nombre,
                ),
              ),
              Expanded(
                child: _PersonCard(
                  title: 'Professional',
                  name: user.profesionales.nombre,
                ),
              ),
            ].divide(const SizedBox(width: 8.0)),
          ),
        ),
      ],
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.title, required this.name});

  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
          child: Text(
            title,
            style: bodyMedium.override(
              font: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontStyle: bodyMedium.fontStyle,
              ),
              fontSize: 14.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
              fontStyle: bodyMedium.fontStyle,
            ),
          ),
        ),
        Container(
          width: 165.0,
          height: 47.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SafeAvatar(imageUrl: '', size: 33.0),
              Flexible(
                child: AutoSizeText(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontStyle: bodyMedium.fontStyle,
                    ),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle: bodyMedium.fontStyle,
                  ),
                ),
              ),
            ].divide(const SizedBox(width: 8.0)).around(const SizedBox(width: 8.0)),
          ),
        ),
      ],
    );
  }
}
