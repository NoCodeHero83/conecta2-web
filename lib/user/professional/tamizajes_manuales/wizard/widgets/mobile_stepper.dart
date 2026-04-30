import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Mobile stepper: compact horizontal circles with connecting lines.
class MobileStepper extends StatelessWidget {
  const MobileStepper({super.key, required this.paso, required this.theme});
  final int paso;
  final FlutterFlowTheme theme;

  static const _labels = ['Adolescente', 'Tamizaje', 'Aplicar', 'Resultados'];

  @override
  Widget build(BuildContext context) {
    const inactiveGrey = Color(0xFFD9DCE1);
    const doneGreen = Color(0xFF34A853);
    const activeNavy = Color(0xFF265294);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: List.generate(_labels.length, (i) {
          final done = i < paso;
          final active = i == paso;
          final circleColor = done
              ? doneGreen
              : active
                  ? activeNavy
                  : inactiveGrey;
          return Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: circleColor,
                        boxShadow: active
                            ? [
                                BoxShadow(
                                  color: activeNavy.withValues(alpha: 0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: done
                          ? const Icon(Icons.check,
                              size: 15, color: Colors.white)
                          : Text(
                              '${i + 1}',
                              style: GoogleFonts.inter(
                                color: active
                                    ? Colors.white
                                    : const Color(0xFF6B7280),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labels[i],
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w500,
                        color: active
                            ? activeNavy
                            : done
                                ? doneGreen
                                : const Color(0xFF6B7280),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (i < _labels.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      color: i < paso ? doneGreen : inactiveGrey,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
