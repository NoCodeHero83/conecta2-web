import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';

/// A label + value column used across the profile views.
class InfoField extends StatelessWidget {
  const InfoField({
    super.key,
    required this.label,
    required this.value,
    this.valueFallback = '—',
  });

  final String label;
  final String? value;
  final String valueFallback;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final text = (value == null || value!.trim().isEmpty) ? valueFallback : value!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.bodyMedium.override(
            font: GoogleFonts.inter(
              fontWeight: theme.bodyMedium.fontWeight,
              fontStyle: theme.bodyMedium.fontStyle,
            ),
            letterSpacing: 0.0,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: theme.bodyMedium.override(
              font: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontStyle: theme.bodyMedium.fontStyle,
              ),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.0,
            ),
          ),
        ),
      ],
    );
  }
}

/// Horizontal pair of [InfoField]s (a row of two columns) matching the
/// existing 2-column layout from the profile pages.
class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.left, this.right});

  final InfoField left;
  final InfoField? right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: left),
          const SizedBox(width: 25.0),
          Expanded(child: right ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}
