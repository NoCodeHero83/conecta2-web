import '/backend/backend.dart';
import '/components/rich_text_notas/rich_text_notas_widget.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Muestra un diálogo para editar las notas del profesional sobre un tamizaje.
///
/// Retorna `true` si se guardaron las notas exitosamente.
Future<bool> showNotasProfesionalDialog(
  BuildContext context, {
  required RespuestasRecord respuesta,
  String? pacienteNombre,
}) async {
  String notasValue = respuesta.notasProfesional;
  bool saving = false;

  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setStateDialog) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Row(
          children: [
            const Icon(Icons.edit_note, color: kNavy, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Notas del profesional',
                style: GoogleFonts.inter(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  color: kNavy,
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 420.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (pacienteNombre != null && pacienteNombre.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Paciente: $pacienteNombre',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                RichTextNotasEditor(
                  initialValue: respuesta.notasProfesional,
                  onChanged: (v) => notasValue = v,
                  placeholder:
                      'Escribe aqui las notas del profesional...',
                  minHeight: 180,
                ),
              ],
            ),
          ),
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
            onPressed: saving
                ? null
                : () async {
                    setStateDialog(() => saving = true);
                    try {
                      await updateNotasProfesional(
                        respuesta.reference,
                        notasValue,
                      );
                      if (ctx.mounted) Navigator.of(ctx).pop(true);
                    } catch (e) {
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          SnackBar(content: Text('Error al guardar: $e')),
                        );
                      }
                    } finally {
                      if (ctx.mounted) {
                        setStateDialog(() => saving = false);
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: kNavy,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              saving ? 'Guardando...' : 'Guardar',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ),
  );

  if (result == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notas guardadas correctamente',
            style: GoogleFonts.inter()),
        backgroundColor: kSuccess,
      ),
    );
  }
  return result == true;
}
