import '/flutter_flow/flutter_flow_theme.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget de estado vacío reutilizable para listas de tamizajes.
class TamizajeEmptyState extends StatelessWidget {
  const TamizajeEmptyState({
    super.key,
    required this.icon,
    required this.mensaje,
    this.submensaje,
  });

  final IconData icon;
  final String mensaje;
  final String? submensaje;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: kNavy.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48.0, color: kNavy),
          ),
          const SizedBox(height: 16.0),
          Text(
            mensaje,
            textAlign: TextAlign.center,
            style: theme.titleMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w500),
              color: theme.secondaryText,
              letterSpacing: 0.0,
            ),
          ),
          if (submensaje != null) ...[
            const SizedBox(height: 8.0),
            Text(
              submensaje!,
              textAlign: TextAlign.center,
              style: theme.bodySmall.override(
                font: GoogleFonts.inter(),
                color: theme.secondaryText.withValues(alpha: 0.7),
                letterSpacing: 0.0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
