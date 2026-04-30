import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';

/// Unified styling for toolbar filter controls (rango de fechas, selector
/// de sede, etc.). Keeps height, radius and shadow consistent across the
/// module so the toolbar reads as a single row of pills.
class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  static const double height = 40;
  static const double radius = 8;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final decorated = Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: child,
    );
    if (onTap == null) return decorated;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: decorated,
      ),
    );
  }
}

/// Text style used for labels inside filter pills.
TextStyle filterPillLabelStyle(BuildContext context) {
  final theme = FlutterFlowTheme.of(context);
  return GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: theme.primaryText,
  );
}
