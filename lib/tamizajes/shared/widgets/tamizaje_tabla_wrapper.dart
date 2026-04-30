import '/flutter_flow/flutter_flow_theme.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Wrapper visual unificado para tablas de tamizajes.
///
/// Provee el contenedor con bordes, sombra, cabecera navy y filas con
/// separadores. Solo maneja la envoltura visual — las columnas y filas
/// se pasan como children.
class TamizajeTablaWrapper extends StatelessWidget {
  const TamizajeTablaWrapper({
    super.key,
    required this.headerColumns,
    required this.rowCount,
    required this.rowBuilder,
  });

  /// Columnas del header (nombre + flex).
  final List<TamizajeColumna> headerColumns;

  /// Cantidad de filas.
  final int rowCount;

  /// Builder para cada fila.
  final Widget Function(BuildContext context, int index) rowBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: theme.alternate, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11.0),
        child: Column(
          children: [
            // Cabecera
            Container(
              decoration: BoxDecoration(
                color: kNavy.withValues(alpha: 0.06),
                border: Border(
                  bottom: BorderSide(color: theme.alternate, width: 1.0),
                ),
              ),
              child: Row(
                children: headerColumns
                    .map((col) => _Th(col.nombre, flex: col.flex))
                    .toList(),
              ),
            ),
            // Filas
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rowCount,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: theme.alternate),
              itemBuilder: rowBuilder,
            ),
          ],
        ),
      ),
    );
  }
}

/// Definición de columna para el header de tabla.
class TamizajeColumna {
  const TamizajeColumna(this.nombre, {this.flex = 1});
  final String nombre;
  final int flex;
}

class _Th extends StatelessWidget {
  const _Th(this.text, {required this.flex});
  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 13.0),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            color: kNavy,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
