import '/flutter_flow/flutter_flow_theme.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Barra de filtros (categoría + estado) para el listado admin de tamizajes.
class TamizajeFilters extends StatelessWidget {
  const TamizajeFilters({
    super.key,
    required this.filtroCategoria,
    required this.filtroEstado,
    required this.onCategoriaChanged,
    required this.onEstadoChanged,
  });

  final String filtroCategoria;
  final String filtroEstado;
  final ValueChanged<String> onCategoriaChanged;
  final ValueChanged<String> onEstadoChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      color: theme.secondaryBackground,
      child: Wrap(
        spacing: 16.0,
        runSpacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Filtros:',
            style: theme.labelMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w600),
              fontSize: 13.0,
              letterSpacing: 0.0,
            ),
          ),
          _FiltroDropdown(
            label: 'Categoría',
            value: filtroCategoria,
            items: kCategoriasTamizaje,
            onChanged: (v) {
              if (v != null) onCategoriaChanged(v);
            },
            theme: theme,
          ),
          _FiltroDropdown(
            label: 'Estado',
            value: filtroEstado,
            items: kEstadosTamizaje,
            onChanged: (v) {
              if (v != null) onEstadoChanged(v);
            },
            theme: theme,
          ),
        ],
      ),
    );
  }
}

class _FiltroDropdown extends StatelessWidget {
  const _FiltroDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.theme,
  });

  final String label;
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;
  final FlutterFlowTheme theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: GoogleFonts.inter(
            fontSize: 12.0,
            color: theme.secondaryText,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: theme.alternate),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: DropdownButton<String>(
            value: value,
            isDense: true,
            underline: const SizedBox(),
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: theme.primaryText,
            ),
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: GoogleFonts.inter(
                          fontSize: 12.0,
                          color: theme.primaryText,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
