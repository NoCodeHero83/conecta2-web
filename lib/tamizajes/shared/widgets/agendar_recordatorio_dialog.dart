import '/backend/backend.dart';
import '/tamizajes/shared/tamizajes_constants.dart';
import '/tamizajes/shared/tamizaje_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Muestra un diálogo para agendar un recordatorio de seguimiento.
///
/// Soporta [AlertDialog] (web/desktop) y [BottomSheet] (mobile) según
/// [useBottomSheet]. Retorna `true` si se agendó exitosamente.
Future<bool> showAgendarRecordatorioDialog(
  BuildContext context, {
  required DocumentReference adolescenteRef,
  required String tituloDefault,
  String? pacienteNombre,
  bool useBottomSheet = false,
}) async {
  final tituloController = TextEditingController(text: tituloDefault);
  final contenidoController = TextEditingController();
  DateTime fechaSeleccionada = DateTime.now().add(const Duration(days: 7));

  final ok = useBottomSheet
      ? await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          builder: (ctx) => _RecordatorioForm(
            tituloController: tituloController,
            contenidoController: contenidoController,
            fechaInicial: fechaSeleccionada,
            pacienteNombre: pacienteNombre,
            onFechaChanged: (d) => fechaSeleccionada = d,
            isBottomSheet: true,
          ),
        )
      : await showDialog<bool>(
          context: context,
          builder: (ctx) => StatefulBuilder(
            builder: (ctx, setStateDialog) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Row(
                children: [
                  const Icon(Icons.alarm, color: kNavy, size: 22.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Agendar recordatorio',
                    style: GoogleFonts.inter(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      color: kNavy,
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
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
                    TextField(
                      controller: tituloController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        labelStyle: GoogleFonts.inter(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: GoogleFonts.inter(fontSize: 14.0),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: contenidoController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Notas / contenido',
                        labelStyle: GoogleFonts.inter(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: GoogleFonts.inter(fontSize: 14.0),
                    ),
                    const SizedBox(height: 16.0),
                    _FechaSelector(
                      fecha: fechaSeleccionada,
                      onChanged: (d) {
                        fechaSeleccionada = d;
                        setStateDialog(() {});
                      },
                    ),
                  ],
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
                  onPressed: () => Navigator.of(ctx).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );

  if (ok == true) {
    try {
      await RemindersRecord.collection.doc().set(
            createRemindersRecordData(
              user: adolescenteRef,
              dueDate: fechaSeleccionada,
              title: tituloController.text.trim(),
              content: contenidoController.text.trim(),
            ),
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recordatorio agendado', style: GoogleFonts.inter()),
            backgroundColor: kSuccess,
          ),
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agendar: $e')),
        );
      }
    }
  }
  return false;
}

// ─── Selector de fecha reutilizable ──────────────────────────────────────────

class _FechaSelector extends StatelessWidget {
  const _FechaSelector({required this.fecha, required this.onChanged});
  final DateTime fecha;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 18.0, color: kNavy),
          const SizedBox(width: 10.0),
          Text(
            formatDate(fecha),
            style: GoogleFonts.inter(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: fecha,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
              );
              if (picked != null) onChanged(picked);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: kNavy,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Cambiar',
                style: GoogleFonts.inter(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Formulario para BottomSheet (mobile) ────────────────────────────────────

class _RecordatorioForm extends StatefulWidget {
  const _RecordatorioForm({
    required this.tituloController,
    required this.contenidoController,
    required this.fechaInicial,
    required this.pacienteNombre,
    required this.onFechaChanged,
    this.isBottomSheet = false,
  });

  final TextEditingController tituloController;
  final TextEditingController contenidoController;
  final DateTime fechaInicial;
  final String? pacienteNombre;
  final ValueChanged<DateTime> onFechaChanged;
  final bool isBottomSheet;

  @override
  State<_RecordatorioForm> createState() => _RecordatorioFormState();
}

class _RecordatorioFormState extends State<_RecordatorioForm> {
  late DateTime _fecha;

  @override
  void initState() {
    super.initState();
    _fecha = widget.fechaInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(Icons.alarm, color: kNavy, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Agendar recordatorio',
                style: GoogleFonts.inter(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  color: kNavy,
                ),
              ),
            ],
          ),
          if (widget.pacienteNombre != null &&
              widget.pacienteNombre!.isNotEmpty) ...[
            const SizedBox(height: 12.0),
            Text(
              'Paciente: ${widget.pacienteNombre}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
          ],
          const SizedBox(height: 16.0),
          TextField(
            controller: widget.tituloController,
            decoration: InputDecoration(
              labelText: 'Título',
              labelStyle: GoogleFonts.inter(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: GoogleFonts.inter(fontSize: 14.0),
          ),
          const SizedBox(height: 12.0),
          TextField(
            controller: widget.contenidoController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Notas / contenido',
              labelStyle: GoogleFonts.inter(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: GoogleFonts.inter(fontSize: 14.0),
          ),
          const SizedBox(height: 16.0),
          _FechaSelector(
            fecha: _fecha,
            onChanged: (d) {
              setState(() => _fecha = d);
              widget.onFechaChanged(d);
            },
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: GoogleFonts.inter(color: const Color(0xFF959595)),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kNavy,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
