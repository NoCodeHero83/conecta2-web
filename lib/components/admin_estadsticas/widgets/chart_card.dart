import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '../common/app_card.dart';

/// Convenience wrapper around [AppCard] for chart widgets: fixed height
/// and always has a title/subtitle header.
class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.height = 380,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: title,
      subtitle: subtitle,
      height: height,
      child: child,
    );
  }
}

/// Horizontal legend showing colored swatches and names for each nivel.
class NivelLegend extends StatelessWidget {
  const NivelLegend({super.key, required this.niveles, required this.colors});

  final List<String> niveles;
  final List<int> colors;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: List.generate(niveles.length, (i) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Color(colors[i]),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Text(niveles[i], style: GoogleFonts.inter(fontSize: 11)),
          ],
        );
      }),
    );
  }
}

/// Empty-state used when a chart has no data to render.
class ChartEmpty extends StatelessWidget {
  const ChartEmpty({super.key, this.message = 'Sin datos para mostrar'});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.insert_chart_outlined,
              size: 44, color: theme.secondaryText.withValues(alpha: 0.6)),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: theme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
