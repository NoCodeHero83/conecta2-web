import '/backend/backend.dart';
import '/tamizajes/shared/tamizaje_utils.dart';
import '/tamizajes/shared/widgets/tamizaje_tabla_wrapper.dart';
import 'fila_tamizaje.dart';
import 'package:flutter/material.dart';

/// Tabla de tamizajes con cabecera y filas para el dashboard admin.
class TablaTamizajes extends StatelessWidget {
  const TablaTamizajes({
    super.key,
    required this.respuestas,
    this.onVerDetalle,
  });

  final List<RespuestasRecord> respuestas;
  final void Function(RespuestasRecord)? onVerDetalle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: TamizajeTablaWrapper(
        headerColumns: const [
          TamizajeColumna('Paciente', flex: 3),
          TamizajeColumna('Tamizaje', flex: 3),
          TamizajeColumna('Fecha', flex: 2),
          TamizajeColumna('Puntaje', flex: 1),
          TamizajeColumna('Notas', flex: 3),
          TamizajeColumna('Estado', flex: 2),
          TamizajeColumna('Acciones', flex: 3),
        ],
        rowCount: respuestas.length,
        rowBuilder: (context, index) {
          final r = respuestas[index];
          return FilaTamizaje(
            respuesta: r,
            hayIdeacion: hasIdeacion(r.test),
            onVerDetalle: onVerDetalle,
            zebra: index.isOdd,
          );
        },
      ),
    );
  }
}
