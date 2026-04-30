part of '../wizard_tamizaje_manual.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Stepper visual
// ─────────────────────────────────────────────────────────────────────────────

class _Stepper extends StatelessWidget {
  const _Stepper({required this.paso, required this.theme});
  final int paso;
  final FlutterFlowTheme theme;

  @override
  Widget build(BuildContext context) {
    const labels = [
      '1. Adolescente',
      '2. Tamizaje',
      '3. Aplicación',
      '4. Resultados',
    ];
    return Container(
      color: theme.secondaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(labels.length, (i) {
          final activo = i == paso;
          final hecho = i < paso;
          return Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: hecho
                      ? const Color(0xFF34A853)
                      : (activo ? _kNavy : theme.alternate),
                  child: hecho
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                          '${i + 1}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    labels[i],
                    overflow: TextOverflow.ellipsis,
                    style: theme.bodySmall.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            activo ? FontWeight.w700 : FontWeight.w500,
                      ),
                      color: activo ? _kNavy : theme.secondaryText,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                if (i < labels.length - 1)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: theme.alternate,
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

// ─────────────────────────────────────────────────────────────────────────────
// Paso 1 — selección de adolescente
// ─────────────────────────────────────────────────────────────────────────────

