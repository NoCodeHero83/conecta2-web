import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '../common/filter_pill.dart';
import '../helpers/stats_calculator.dart';

/// Segmented pill-style selector for the tamizaje type. Visually consistent
/// with the other filter pills in the toolbar.
class SelectorTipoTamizaje extends StatelessWidget {
  const SelectorTipoTamizaje({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TamizajeTipo selected;
  final ValueChanged<TamizajeTipo> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return FilterPill(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: TamizajeTipo.values.map((t) {
            final isSelected = t == selected;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Material(
                color: isSelected ? theme.accent2 : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                  onTap: () => onChanged(t),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    child: Center(
                      child: Text(
                        t.label,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected ? Colors.white : theme.primaryText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
