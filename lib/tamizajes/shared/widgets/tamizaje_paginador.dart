import '/flutter_flow/flutter_flow_theme.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Estilo visual del paginador.
enum PaginadorStyle { mobile, web }

/// Widget de paginación reutilizable para listas de tamizajes.
///
/// [PaginadorStyle.mobile] muestra pills compactos.
/// [PaginadorStyle.web] muestra una barra con conteo de registros.
class TamizajePaginador extends StatelessWidget {
  const TamizajePaginador({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onCambiarPagina,
    this.totalRegistros,
    this.style = PaginadorStyle.web,
  });

  final int paginaActual;
  final int totalPaginas;
  final ValueChanged<int> onCambiarPagina;
  final int? totalRegistros;
  final PaginadorStyle style;

  @override
  Widget build(BuildContext context) {
    if (totalPaginas <= 1 && style == PaginadorStyle.mobile) {
      return const SizedBox.shrink();
    }

    final theme = FlutterFlowTheme.of(context);

    if (style == PaginadorStyle.mobile) {
      return _buildMobile(theme);
    }
    return _buildWeb(theme);
  }

  Widget _buildWeb(FlutterFlowTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(top: BorderSide(color: theme.alternate)),
      ),
      child: Row(
        children: [
          if (totalRegistros != null)
            Text(
              '$totalRegistros registros',
              style: theme.bodySmall.override(
                font: GoogleFonts.inter(),
                color: theme.secondaryText,
                letterSpacing: 0.0,
              ),
            ),
          const Spacer(),
          IconButton(
            onPressed:
                paginaActual > 0 ? () => onCambiarPagina(paginaActual - 1) : null,
            icon: const Icon(Icons.chevron_left),
            color: kNavy,
            tooltip: 'Anterior',
          ),
          Text(
            'Página ${paginaActual + 1} de $totalPaginas',
            style: theme.labelMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w600),
              color: kNavy,
              letterSpacing: 0.0,
            ),
          ),
          IconButton(
            onPressed: paginaActual < totalPaginas - 1
                ? () => onCambiarPagina(paginaActual + 1)
                : null,
            icon: const Icon(Icons.chevron_right),
            color: kNavy,
            tooltip: 'Siguiente',
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _MobilePill(
            icon: Icons.chevron_left,
            enabled: paginaActual > 0,
            onTap: () => onCambiarPagina(paginaActual - 1),
          ),
          const SizedBox(width: 12.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: kNavy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              '${paginaActual + 1} / $totalPaginas',
              style: GoogleFonts.inter(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: kNavy,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          _MobilePill(
            icon: Icons.chevron_right,
            enabled: paginaActual < totalPaginas - 1,
            onTap: () => onCambiarPagina(paginaActual + 1),
          ),
        ],
      ),
    );
  }
}

class _MobilePill extends StatelessWidget {
  const _MobilePill({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: enabled ? kNavy : kNavy.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20.0,
          color: enabled ? Colors.white : kNavy.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
