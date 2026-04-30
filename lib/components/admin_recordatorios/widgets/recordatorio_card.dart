import '/backend/backend.dart';
import '/components/eliminarrecord_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

/// Single recordatorio card used in both search results and the full list.
///
/// Presents the record's title/date and a three-dot [PopupMenuButton] with
/// "Editar" and "Eliminar" options — replacing the legacy arrow/trash icon
/// buttons for consistency with the rest of the admin UI.
class RecordatorioCard extends StatelessWidget {
  const RecordatorioCard({
    super.key,
    required this.record,
    required this.compact,
    required this.onEdit,
    required this.onDeleted,
  });

  final RecordatorRecord record;

  /// When true the card shrinks from 400 → 200 px because the right-hand
  /// form panel is visible.
  final bool compact;

  /// Called when the user picks "Editar" from the popup menu.
  final VoidCallback onEdit;

  /// Called after the delete dialog closes so the parent can reset its view.
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 10.0),
      child: Container(
        width: compact ? 200.0 : 400.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidFileLines,
                      color: Color(0xFF265294),
                      size: 24.0,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.titulo,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            if (record.createAt != null)
                              Text(
                                dateTimeFormat(
                                  'yMMMd',
                                  record.createAt!,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _RecordatorioActionsMenu(
                recordRef: record.reference,
                onEdit: onEdit,
                onDeleted: onDeleted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Three-dot popup menu — kept private because it is only used by the card.
class _RecordatorioActionsMenu extends StatelessWidget {
  const _RecordatorioActionsMenu({
    required this.recordRef,
    required this.onEdit,
    required this.onDeleted,
  });

  final DocumentReference recordRef;
  final VoidCallback onEdit;
  final VoidCallback onDeleted;

  Future<void> _handleSelection(BuildContext context, String value) async {
    switch (value) {
      case 'editar':
        onEdit();
        break;
      case 'eliminar':
        await showDialog<void>(
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: const AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: WebViewAware(
                child: EliminarrecordWidget(
                  recordID: recordRef,
                  close: () async {
                    onDeleted();
                  },
                ),
              ),
            );
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Opciones',
      icon: const Icon(
        Icons.more_vert,
        color: Color(0xFF265294),
        size: 26.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      onSelected: (value) => _handleSelection(context, value),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'editar',
          child: _menuRow(context, icon: Icons.edit_sharp, label: 'Editar'),
        ),
        PopupMenuItem<String>(
          value: 'eliminar',
          child: _menuRow(context, icon: Icons.delete, label: 'Eliminar'),
        ),
      ],
    );
  }

  Widget _menuRow(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF265294), size: 22.0),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
