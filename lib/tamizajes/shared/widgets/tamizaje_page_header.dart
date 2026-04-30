import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Header unificado para todas las sub-páginas de tamizajes en web.
///
/// Soporta: botón volver, breadcrumb, título, ícono, badge, y acción derecha.
class TamizajePageHeader extends StatelessWidget {
  const TamizajePageHeader({
    super.key,
    required this.titulo,
    this.breadcrumb,
    this.onVolver,
    this.icon = Icons.assignment_outlined,
    this.badge,
    this.trailing,
  });

  final String titulo;
  final String? breadcrumb;
  final VoidCallback? onVolver;
  final IconData icon;
  final Widget? badge;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Botón volver
          if (onVolver != null) ...[
            Material(
              color: kNavy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: onVolver,
                borderRadius: BorderRadius.circular(10.0),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.arrow_back_rounded, color: kNavy, size: 20.0),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
          ],

          // Ícono
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: kNavy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: kNavy, size: 22.0),
          ),
          const SizedBox(width: 14.0),

          // Título + breadcrumb
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (breadcrumb != null && onVolver != null)
                  GestureDetector(
                    onTap: onVolver,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        '← $breadcrumb',
                        style: GoogleFonts.inter(
                          fontSize: 12.0,
                          color: kNavy.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        titulo,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          letterSpacing: -0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: 10.0),
                      badge!,
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Acción derecha
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Badge de tipo (Manual / App) para usar en headers.
class TipoBadge extends StatelessWidget {
  const TipoBadge({super.key, required this.esManual});
  final bool esManual;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: esManual ? const Color(0xFFE3F2FD) : const Color(0xFFEDE7F6),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: esManual ? kManualBlue : kAppPurple,
          width: 0.8,
        ),
      ),
      child: Text(
        esManual ? 'Manual' : 'App',
        style: GoogleFonts.inter(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: esManual ? kManualBlue : kAppPurple,
        ),
      ),
    );
  }
}
