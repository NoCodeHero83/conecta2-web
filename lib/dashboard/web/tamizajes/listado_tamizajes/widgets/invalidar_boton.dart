import '/backend/backend.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Botón para invalidar un tamizaje con diálogo de confirmación.
class InvalidarBoton extends StatefulWidget {
  const InvalidarBoton({super.key, required this.respuesta});

  final RespuestasRecord respuesta;

  @override
  State<InvalidarBoton> createState() => _InvalidarBotonState();
}

class _InvalidarBotonState extends State<InvalidarBoton> {
  bool _invalidating = false;

  Future<void> _confirmarInvalidar() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: kDanger, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Invalidar tamizaje',
              style: GoogleFonts.inter(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: kDanger,
              ),
            ),
          ],
        ),
        content: Text(
          'Al invalidar este tamizaje, el adolescente no podrá volver a '
          'realizarlo durante 24 horas.\n\n'
          '¿Estás seguro de que deseas invalidar este tamizaje?',
          style: GoogleFonts.inter(fontSize: 14.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancelar',
                style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: kDanger,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              elevation: 0,
            ),
            child: Text('Invalidar',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _invalidating = true);
    try {
      await invalidarTamizaje(widget.respuesta.reference);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tamizaje invalidado correctamente')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al invalidar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _invalidating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.respuesta.invalidado) return const SizedBox.shrink();

    return ElevatedButton.icon(
      onPressed: _invalidating ? null : _confirmarInvalidar,
      icon: _invalidating
          ? const SizedBox(
              width: 12.0,
              height: 12.0,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.block_outlined, size: 14.0),
      label: const Text('Invalidar'),
      style: ElevatedButton.styleFrom(
        backgroundColor: kDanger,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        textStyle:
            GoogleFonts.inter(fontSize: 11.0, fontWeight: FontWeight.w600),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        elevation: 0,
      ),
    );
  }
}
