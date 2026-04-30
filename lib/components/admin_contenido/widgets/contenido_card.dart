import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'contenido_actions_menu.dart';

/// A single row representing a [ContenidoRecord] in the admin table.
class ContenidoCard extends StatelessWidget {
  const ContenidoCard({
    super.key,
    required this.item,
    required this.onPreview,
    required this.onEdit,
  });

  final ContenidoRecord item;
  final void Function(ContenidoRecord) onPreview;
  final void Function(ContenidoRecord) onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Título
            Flexible(
              child: Container(
                width: screenWidth * 0.35,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        item.titulo,
                        style: theme.bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: theme.bodyMedium.fontWeight,
                            fontStyle: theme.bodyMedium.fontStyle,
                          ),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: theme.bodyMedium.fontWeight,
                          fontStyle: theme.bodyMedium.fontStyle,
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 5.0)),
                ),
              ),
            ),
            // Dirigido para (roles)
            Flexible(
              child: Container(
                width: screenWidth * 0.14,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: item.roles
                      .map(
                        (roleItem) => Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            roleItem,
                            style: theme.bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: theme.bodyMedium.fontWeight,
                                fontStyle: theme.bodyMedium.fontStyle,
                              ),
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: theme.bodyMedium.fontWeight,
                              fontStyle: theme.bodyMedium.fontStyle,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            // Estado
            Flexible(
              child: Container(
                width: screenWidth * 0.16,
                height: 38.0,
                decoration: BoxDecoration(
                  color: item.publicado
                      ? const Color(0xFF88FFDB)
                      : const Color(0xFFFFCB9B),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  item.publicado ? 'Publicado' : 'Borrador',
                  style: theme.bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: theme.bodyMedium.fontWeight,
                      fontStyle: theme.bodyMedium.fontStyle,
                    ),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: theme.bodyMedium.fontWeight,
                    fontStyle: theme.bodyMedium.fontStyle,
                  ),
                ),
              ),
            ),
            // Creación
            Flexible(
              child: Container(
                width: screenWidth * 0.15,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  item.createAt != null
                      ? dateTimeFormat(
                          'yMMMd',
                          item.createAt!,
                          locale: FFLocalizations.of(context).languageCode,
                        )
                      : '',
                  style: theme.bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: theme.bodyMedium.fontWeight,
                      fontStyle: theme.bodyMedium.fontStyle,
                    ),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: theme.bodyMedium.fontWeight,
                    fontStyle: theme.bodyMedium.fontStyle,
                  ),
                ),
              ),
            ),
            // Vista previa
            Flexible(
              child: Container(
                width: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                ),
                alignment: AlignmentDirectional.center,
                child: FFButtonWidget(
                  onPressed: () => onPreview(item),
                  text: 'Vista Previa',
                  options: FFButtonOptions(
                    height: 35.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 0.0, 20.0, 0.0),
                    iconPadding: EdgeInsetsDirectional.zero,
                    color: const Color(0xFF265294),
                    textStyle: theme.titleSmall.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle: theme.titleSmall.fontStyle,
                      ),
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: theme.titleSmall.fontStyle,
                    ),
                    elevation: 0.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            // Acciones (3 dots)
            Flexible(
              child: Container(
                width: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                ),
                alignment: AlignmentDirectional.center,
                child: ContenidoActionsMenu(
                  item: item,
                  onEdit: onEdit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
