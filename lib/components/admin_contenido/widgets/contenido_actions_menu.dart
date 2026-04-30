import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '/backend/backend.dart';
import '/dashboard/web/contenido/model/eliminacontenido/eliminacontenido_widget.dart';

/// Popup menu (3 dots) with Editar / Borrar actions for a contenido row.
class ContenidoActionsMenu extends StatelessWidget {
  const ContenidoActionsMenu({
    super.key,
    required this.item,
    required this.onEdit,
  });

  final ContenidoRecord item;
  final void Function(ContenidoRecord) onEdit;

  Future<void> _borrar(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return WebViewAware(
          child: Padding(
            padding: MediaQuery.viewInsetsOf(ctx),
            child: EliminacontenidoWidget(id: item.reference),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Más opciones',
      icon: Container(
        width: 26.0,
        height: 26.0,
        decoration: BoxDecoration(
          color: const Color(0xFF265294),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.more_horiz,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      padding: EdgeInsets.zero,
      onSelected: (value) {
        if (value == 'editar') {
          onEdit(item);
        } else if (value == 'borrar') {
          _borrar(context);
        }
      },
      itemBuilder: (ctx) => const [
        PopupMenuItem<String>(
          value: 'editar',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 16),
              SizedBox(width: 8),
              Text('Editar'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'borrar',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text('Borrar', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
