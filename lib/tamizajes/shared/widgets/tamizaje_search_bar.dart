import '/flutter_flow/flutter_flow_theme.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Barra de búsqueda + botón de orden reutilizable para listas de tamizajes.
class TamizajeSearchBar extends StatelessWidget {
  const TamizajeSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.ordenDescendente,
    required this.onChangedSearch,
    required this.onToggleOrden,
    this.hintText = 'Buscar por nombre de paciente o tamizaje…',
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool ordenDescendente;
  final ValueChanged<String> onChangedSearch;
  final VoidCallback onToggleOrden;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      color: theme.secondaryBackground,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 44,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: onChangedSearch,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 13.5,
                    color: theme.secondaryText.withValues(alpha: 0.7),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.0,
                    color: theme.secondaryText.withValues(alpha: 0.8),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    borderSide: const BorderSide(color: kNavy, width: 1.4),
                  ),
                ),
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  color: theme.primaryText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            height: 44,
            child: OutlinedButton.icon(
              onPressed: onToggleOrden,
              icon: Icon(
                ordenDescendente ? Icons.south : Icons.north,
                size: 16.0,
              ),
              label: Text(ordenDescendente ? 'Más recientes' : 'Más antiguos'),
              style: OutlinedButton.styleFrom(
                foregroundColor: kNavy,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                textStyle: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
                side: const BorderSide(color: kNavy, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
