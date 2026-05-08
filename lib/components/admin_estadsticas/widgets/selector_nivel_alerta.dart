import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '../common/filter_pill.dart';
import '../helpers/stats_calculator.dart';

/// Nivel de alerta según el [TamizajeTipo] activo (etiquetas distintas por familia).
class SelectorNivelAlerta extends StatelessWidget {
  const SelectorNivelAlerta({
    super.key,
    required this.tipo,
    required this.seleccionado,
    required this.onChanged,
  });

  final TamizajeTipo tipo;
  final String? seleccionado;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final niveles = tipo.niveles;

    return FilterPill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String?>(
            value: seleccionado,
            hint: Text(
              'Todos los niveles',
              style: filterPillLabelStyle(context),
            ),
            isDense: true,
            isExpanded: false,
            items: [
              DropdownMenuItem<String?>(
                value: null,
                child: Text(
                  'Todos los niveles',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryText,
                  ),
                ),
              ),
              ...niveles.map(
                (n) => DropdownMenuItem<String?>(
                  value: n,
                  child: Text(
                    n,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryText,
                    ),
                  ),
                ),
              ),
            ],
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
