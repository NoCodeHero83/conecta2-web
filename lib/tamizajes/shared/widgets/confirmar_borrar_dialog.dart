import '/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Muestra un diálogo de confirmación para borrar un tamizaje.
///
/// Retorna `true` si se borró exitosamente.
Future<bool> showConfirmarBorrarDialog(
  BuildContext context, {
  required RespuestasRecord respuesta,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24.0),
          const SizedBox(width: 8.0),
          Text(
            'Borrar tamizaje',
            style: GoogleFonts.inter(
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      content: Text(
        '¿Está seguro de borrar "${respuesta.titlo}"? '
        'Esta acción no se puede deshacer.',
        style: GoogleFonts.inter(fontSize: 14.0),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            'Cancelar',
            style: GoogleFonts.inter(color: const Color(0xFF959595)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(
            'Borrar',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );

  if (ok == true) {
    try {
      await respuesta.reference.delete();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tamizaje borrado', style: GoogleFonts.inter()),
          ),
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al borrar: $e')),
        );
      }
    }
  }
  return false;
}
