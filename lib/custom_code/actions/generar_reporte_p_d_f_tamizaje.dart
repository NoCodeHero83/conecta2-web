// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future generarReportePDFTamizaje(String userUid) async {
  try {
    // Obtener referencia del usuario desde su UID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userUid);

    // Obtener datos del usuario
    final userDoc = await userRef.get();
    if (!userDoc.exists) {
      throw Exception('Usuario no encontrado');
    }

    final userData = userDoc.data() as Map<String, dynamic>;

    // Obtener todos los tamizajes de tipo "Tamizajes"
    final encuestasSnapshot = await FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .where('Publicado', isEqualTo: true)
        .get();

    List<Map<String, dynamic>> todosLosTamizajes = [];

    // Para cada tamizaje, verificar si el usuario tiene respuestas
    for (var encuestaDoc in encuestasSnapshot.docs) {
      final encuestaData = encuestaDoc.data();
      final encuestaId = encuestaDoc.id;

      // Obtener respuestas del usuario para este tamizaje
      final respuestasSnapshot = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(encuestaId)
          .collection('Respuestas')
          .where('User_respuesta', isEqualTo: userRef)
          .get();

      if (respuestasSnapshot.docs.isNotEmpty) {
        // El usuario respondio este tamizaje
        final respuestaDoc = respuestasSnapshot.docs.first;
        final respuestaData = respuestaDoc.data();

        // Procesar respuestas y calcular puntajes por sustancia
        Map<String, dynamic> resultadosTamizaje = _procesarRespuestasTamizaje(
          encuestaData,
          respuestaData,
        );

        todosLosTamizajes.add({
          'titulo': encuestaData['titulo'] ?? 'Sin titulo',
          'descripcion': encuestaData['descripcion'] ?? '',
          'fecha': respuestaData['Fecha'] as Timestamp?,
          'resultados': resultadosTamizaje,
        });
      }
    }

    // MODIFICACIÓN: Ya no lanzamos excepción si no hay tamizajes
    if (todosLosTamizajes.isEmpty) {
      print(
          '⚠️  No se encontraron tamizajes respondidos. Generando PDF solo con datos del usuario.');
    } else {
      // Completar sustancias faltantes en todos los tamizajes
      for (var i = 0; i < todosLosTamizajes.length; i++) {
        final tamizaje = todosLosTamizajes[i];
        final resultados = tamizaje['resultados'] as Map<String, dynamic>;

        // Completar sustancias faltantes con valor 0
        final resultadosCompletos = _completarSustanciasFaltantes(resultados);
        todosLosTamizajes[i]['resultados'] = resultadosCompletos;
      }
    }

    // Generar PDF (ahora acepta lista vacía)
    final pdf = await _crearPDFReal(userData, todosLosTamizajes);

    // Mostrar el PDF
    await _mostrarPDF(pdf, userData['display_name'] ?? 'Usuario');

    print('PDF generado exitosamente');
    return 'success';
  } catch (e) {
    print('Error al generar el PDF: $e');
    throw Exception('Error al generar el PDF: $e');
  }
}

/// Completa las sustancias faltantes con valor 0
Map<String, dynamic> _completarSustanciasFaltantes(
    Map<String, dynamic> resultados) {
  try {
    print('  Completando sustancias faltantes...');

    // Lista completa de todas las sustancias que deben aparecer
    List<String> todasLasSustancias = [
      'Tabaco',
      'Bebidas alcoholicas',
      'Cannabis',
      'Cocaina',
      'Anfetaminas',
      'Inhalantes',
      'Tranquilizantes',
      'Alucinogenos',
      'Opiaceos',
      'Otros',
    ];

    final puntajesPorSustancia =
        Map<String, double>.from(resultados['puntajesPorSustancia'] ?? {});
    final nivelesRiesgoPorSustancia =
        Map<String, String>.from(resultados['nivelRiesgoPorSustancia'] ?? {});
    final detallesPorSustancia = Map<String, List<Map<String, dynamic>>>.from(
        resultados['detallesPorSustancia'] ?? {});

    // Completar sustancias faltantes
    for (var sustancia in todasLasSustancias) {
      if (!puntajesPorSustancia.containsKey(sustancia)) {
        puntajesPorSustancia[sustancia] = 0.0;
        nivelesRiesgoPorSustancia[sustancia] = 'Sin alarma';

        // Agregar detalle por defecto para sustancia faltante
        if (!detallesPorSustancia.containsKey(sustancia)) {
          detallesPorSustancia[sustancia] = [
            {
              'pregunta': 'Consumo de $sustancia',
              'respuesta': 'Nunca',
              'valor': 0.0,
            }
          ];
        }

        print('  ✓ Sustancia faltante completada: $sustancia (0.0)');
      }
    }

    return {
      'puntajesPorSustancia': puntajesPorSustancia,
      'detallesPorSustancia': detallesPorSustancia,
      'nivelRiesgoPorSustancia': nivelesRiesgoPorSustancia,
    };
  } catch (e) {
    print('  ERROR al completar sustancias faltantes: $e');
    return resultados;
  }
}

Map<String, dynamic> _procesarRespuestasTamizaje(
  Map<String, dynamic> encuestaData,
  Map<String, dynamic> respuestaData,
) {
  print('Procesando respuestas del tamizaje...');

  // Obtener alertas de la encuesta
  final alertas = encuestaData['alertas'] as List<dynamic>? ?? [];
  final test = respuestaData['test'] as List<dynamic>? ?? [];

  print('  Alertas disponibles: ${alertas.length}');
  for (var i = 0; i < alertas.length; i++) {
    final alerta = alertas[i];
    if (alerta is Map<String, dynamic>) {
      print(
          '    Alerta $i: ${alerta['sustancia']} - ${alerta['nivel']} (${alerta['min']}-${alerta['max']})');
    }
  }

  // Mapa para acumular puntajes por sustancia
  Map<String, double> puntajesPorSustancia = {};
  Map<String, List<Map<String, dynamic>>> detallesPorSustancia = {};

  // Procesar cada respuesta del test
  for (var item in test) {
    if (item is! Map<String, dynamic>) continue;

    final tipo = item['Tipo'] as String?;
    if (tipo != 'Tamizaje') continue;

    final pregunta = item['Pregunta'] as String? ?? '';
    final respuestaTamizaje = item['RespuestaTamizaje'] as List<dynamic>? ?? [];

    if (respuestaTamizaje.isEmpty) continue;

    final respuestaSeleccionada = respuestaTamizaje[0] as Map<String, dynamic>;
    final etiqueta = respuestaSeleccionada['etiqueta'] as String? ?? '';
    final valor = (respuestaSeleccionada['valor'] as num?)?.toDouble() ?? 0.0;

    // Obtener sustancia de la pregunta
    String sustancia = _extraerSustancia(pregunta);

    // Acumular puntaje
    puntajesPorSustancia[sustancia] =
        (puntajesPorSustancia[sustancia] ?? 0) + valor;

    // Guardar detalle
    if (!detallesPorSustancia.containsKey(sustancia)) {
      detallesPorSustancia[sustancia] = [];
    }
    detallesPorSustancia[sustancia]!.add({
      'pregunta': pregunta,
      'respuesta': etiqueta,
      'valor': valor,
    });
  }

  // Evaluar nivel de riesgo por sustancia segun alertas
  Map<String, String> nivelRiesgoPorSustancia = {};
  for (var sustancia in puntajesPorSustancia.keys) {
    final puntaje = puntajesPorSustancia[sustancia]!;
    nivelRiesgoPorSustancia[sustancia] =
        _evaluarNivelRiesgo(sustancia, puntaje, alertas);
  }

  return {
    'puntajesPorSustancia': puntajesPorSustancia,
    'detallesPorSustancia': detallesPorSustancia,
    'nivelRiesgoPorSustancia': nivelRiesgoPorSustancia,
  };
}

String _quitarTildes(String texto) {
  return texto
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('Á', 'A')
      .replaceAll('É', 'E')
      .replaceAll('Í', 'I')
      .replaceAll('Ó', 'O')
      .replaceAll('Ú', 'U');
}

String _extraerSustancia(String pregunta) {
  final preguntaLower = pregunta.toLowerCase();

  if (preguntaLower.contains('tabaco') || preguntaLower.contains('cigarrillo'))
    return 'Tabaco';
  if (preguntaLower.contains('alcohol') || preguntaLower.contains('bebidas'))
    return 'Bebidas alcoholicas';
  if (preguntaLower.contains('cannabis') || preguntaLower.contains('marihuana'))
    return 'Cannabis';
  if (preguntaLower.contains('cocaina') || preguntaLower.contains('coca'))
    return 'Cocaina';
  if (preguntaLower.contains('anfetamina') ||
      preguntaLower.contains('estimulante')) return 'Anfetaminas';
  if (preguntaLower.contains('inhalante')) return 'Inhalantes';
  if (preguntaLower.contains('tranquilizante') ||
      preguntaLower.contains('pastillas')) return 'Tranquilizantes';
  if (preguntaLower.contains('alucinogeno')) return 'Alucinogenos';
  if (preguntaLower.contains('opiaceo') || preguntaLower.contains('heroina'))
    return 'Opiaceos';

  return 'Otros';
}

String _evaluarNivelRiesgo(
    String sustancia, double puntaje, List<dynamic> alertas) {
  print('  Evaluando nivel de riesgo para: $sustancia, puntaje: $puntaje');

  // Normalizar la sustancia (quitar tildes para comparación)
  final sustanciaNormalizada = _quitarTildes(sustancia.toLowerCase());

  // Lista para almacenar las alertas que coinciden con la sustancia
  List<Map<String, dynamic>> alertasCoincidentes = [];

  // Buscar todas las alertas para esta sustancia
  for (var alerta in alertas) {
    if (alerta is! Map<String, dynamic>) continue;

    final sustanciaAlerta = alerta['sustancia'] as String?;
    if (sustanciaAlerta == null) continue;

    // Normalizar la sustancia de la alerta
    final sustanciaAlertaNormalizada =
        _quitarTildes(sustanciaAlerta.toLowerCase());

    final nivel = alerta['nivel'] as String?;
    final min = (alerta['min'] as num?)?.toDouble() ?? 0.0;
    final max = (alerta['max'] as num?)?.toDouble() ?? 0.0;

    if (sustanciaAlertaNormalizada == sustanciaNormalizada) {
      alertasCoincidentes.add({
        'nivel': nivel ?? 'Sin alarma',
        'min': min,
        'max': max,
        'sustancia_original': sustanciaAlerta, // Guardar original para logs
      });
      print(
          '    Alerta encontrada: $sustanciaAlerta - $nivel (min: $min, max: $max)');
    }
  }

  // Si no hay alertas para esta sustancia, usar "Sin alarma"
  if (alertasCoincidentes.isEmpty) {
    print(
        '    ⚠️  No hay alertas definidas para $sustancia, usando "Sin alarma"');
    return 'Sin alarma';
  }

  // Ordenar alertas por rango (de menor a mayor)
  alertasCoincidentes.sort((a, b) => a['min'].compareTo(b['min']));

  // Caso especial: si el puntaje es menor que el mínimo de la primera alerta
  if (puntaje < alertasCoincidentes.first['min']) {
    print('    ✓ Puntaje muy bajo, usando "Sin alarma"');
    return 'Sin alarma';
  }

  // Evaluar cada alerta en orden
  for (var i = 0; i < alertasCoincidentes.length; i++) {
    var alerta = alertasCoincidentes[i];
    final min = alerta['min'];
    final max = alerta['max'];
    final nivel = alerta['nivel'];
    final sustanciaOriginal = alerta['sustancia_original'];

    // Si es la última alerta y max es 0, significa "mayor o igual que min"
    if (i == alertasCoincidentes.length - 1 && max == 0) {
      if (puntaje >= min) {
        print(
            '    ✓ Nivel asignado: $nivel para $sustanciaOriginal (puntaje >= $min) - ÚLTIMA ALERTA');
        return nivel;
      }
    }

    // Para alertas intermedias, usar rango [min, max)
    if (i < alertasCoincidentes.length - 1) {
      final siguienteMin = alertasCoincidentes[i + 1]['min'];
      if (puntaje >= min && puntaje < siguienteMin) {
        print(
            '    ✓ Nivel asignado: $nivel para $sustanciaOriginal ($min <= puntaje < $siguienteMin)');
        return nivel;
      }
    }
    // Para la última alerta con max definido
    else if (max > 0) {
      if (puntaje >= min && puntaje <= max) {
        print(
            '    ✓ Nivel asignado: $nivel para $sustanciaOriginal ($min <= puntaje <= $max) - ÚLTIMA CON MAX');
        return nivel;
      }
    }
  }

  // Si llegamos aquí, usar la última alerta
  final ultimaAlerta = alertasCoincidentes.last;
  print(
      '    ⚠️  Usando última alerta por defecto: ${ultimaAlerta['nivel']} para ${ultimaAlerta['sustancia_original']}');
  return ultimaAlerta['nivel'];
}

Future<Uint8List> _crearPDFReal(
  Map<String, dynamic> userData,
  List<Map<String, dynamic>> tamizajes,
) async {
  final pdf = pw.Document();

  DateTime ahora = DateTime.now();
  String fecha =
      '${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}';
  String hora =
      '${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}';

  // Extraer datos del usuario
  String displayName = userData['display_name'] ?? 'No especificado';
  String email = userData['email'] ?? 'No registrado';
  String telefono = userData['phone_number'] ?? 'No registrado';
  String genero = userData['genero'] ?? 'No especificado';
  String municipio = userData['municipio'] ?? 'No registrado';
  String barrio = userData['barrio'] ?? 'No registrado';
  String colegio = userData['colegio'] ?? 'No registrado';
  String eps = userData['eps'] ?? 'No registrada';
  String grado = userData['grado']?.toString() ?? 'No registrado';

  // Calcular edad si existe fecha_nacimiento
  String edad = 'No registrada';
  if (userData['fecha_nacimiento'] != null) {
    final fechaNacimiento =
        (userData['fecha_nacimiento'] as Timestamp).toDate();
    final edadCalculada = ahora.year - fechaNacimiento.year;
    edad = '$edadCalculada años';
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(2.0 * PdfPageFormat.cm),
      build: (pw.Context context) {
        List<pw.Widget> contenido = [];

        contenido.add(_buildHeader(fecha, hora));
        contenido.add(pw.SizedBox(height: 20));
        contenido.add(_buildTitle());
        contenido.add(pw.SizedBox(height: 20));
        contenido.add(_buildDatosPersonalesReales(
          displayName,
          email,
          telefono,
          edad,
          genero,
          municipio,
          barrio,
          colegio,
          eps,
          grado,
          fecha,
          userData,
        ));
        contenido.add(pw.SizedBox(height: 20));

        // MODIFICACIÓN: Solo mostrar resumen y detalles si hay tamizajes
        if (tamizajes.isNotEmpty) {
          contenido.add(_buildResumenGeneral(tamizajes));
          contenido.add(pw.SizedBox(height: 20));

          for (var tamizaje in tamizajes) {
            contenido.add(_buildDetalleTamizaje(tamizaje));
            contenido.add(pw.SizedBox(height: 15));
          }
        } else {
          // Mostrar mensaje cuando no hay tamizajes
          contenido.add(_buildSinTamizajes());
          contenido.add(pw.SizedBox(height: 20));
        }

        contenido.add(pw.SizedBox(height: 25));
        contenido.add(_buildFirmas(fecha));

        return contenido;
      },
    ),
  );

  return await pdf.save();
}

// NUEVA FUNCIÓN: Mensaje cuando no hay tamizajes
pw.Widget _buildSinTamizajes() {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: double.infinity,
          padding: pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Text(
            'TAMIZAJES',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(20),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  'No se encontraron tamizajes respondidos',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey700,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'El usuario aún no ha completado ningún tamizaje en el sistema.',
                  style: pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey600,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildHeader(String fecha, String hora) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(
        'CONECTA2 - SISTEMA DE EVALUACIÓN',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue900,
        ),
        textAlign: pw.TextAlign.center,
      ),
      pw.SizedBox(height: 8),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Fecha: $fecha',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Hora: $hora',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
      pw.Divider(thickness: 1.5),
    ],
  );
}

pw.Widget _buildTitle() {
  return pw.Container(
    width: double.infinity,
    padding: pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColors.blue50,
      border: pw.Border.all(color: PdfColors.blue700),
    ),
    child: pw.Text(
      'REPORTE DE TAMIZAJES APLICADOS',
      style: pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blue900,
      ),
      textAlign: pw.TextAlign.center,
    ),
  );
}

pw.Widget _buildDatosPersonalesReales(
  String nombre,
  String email,
  String telefono,
  String edad,
  String genero,
  String municipio,
  String barrio,
  String colegio,
  String eps,
  String grado,
  String fecha,
  Map<String, dynamic> userData,
) {
  // Obtener datos del acudiente si existen
  final acudiente = userData['Acudiente'] as Map<String, dynamic>?;
  String nombreAcudiente = acudiente?['Nombre'] ?? 'No registrado';
  String parentesco = acudiente?['parentesco'] ?? 'No especificado';
  String correoAcudiente = acudiente?['correo'] ?? 'No registrado';
  String telefonoAcudiente = acudiente?['telefono'] ?? 'No registrado';
  String rol = userData['rol'] ?? 'No especificado';

  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Datos del estudiante
        pw.Container(
          width: double.infinity,
          padding: pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Text(
            'DATOS DEL ESTUDIANTE',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: {
              0: pw.FlexColumnWidth(1.5),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(1.5),
              3: pw.FlexColumnWidth(2),
            },
            children: [
              _buildTableRow(['Nombre:', nombre, 'Email:', email]),
              _buildTableRow(['Edad:', edad, 'Género:', genero]),
              _buildTableRow(['Rol:', rol, 'Grado:', grado]),
              _buildTableRow(['Municipio:', municipio, 'Barrio:', barrio]),
              _buildTableRow(['Teléfono:', telefono, 'EPS:', eps]),
              _buildTableRow(['Institución:', colegio, '', '']),
            ],
          ),
        ),

        // Datos del acudiente
        pw.SizedBox(height: 15),
        pw.Container(
          width: double.infinity,
          padding: pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Text(
            'DATOS DEL ACUDIENTE',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: {
              0: pw.FlexColumnWidth(1.5),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(1.5),
              3: pw.FlexColumnWidth(2),
            },
            children: [
              _buildTableRow(
                  ['Nombre:', nombreAcudiente, 'Parentesco:', parentesco]),
              _buildTableRow(
                  ['Correo:', correoAcudiente, 'Teléfono:', telefonoAcudiente]),
            ],
          ),
        ),
      ],
    ),
  );
}

pw.TableRow _buildTableRow(List<String> cells) {
  return pw.TableRow(
    children: cells.map((cell) {
      bool isLabel = cells.indexOf(cell) % 2 == 0;
      return pw.Container(
        padding: pw.EdgeInsets.all(6),
        child: pw.Text(
          cell,
          style: pw.TextStyle(
            fontSize: 9,
            fontWeight: isLabel ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      );
    }).toList(),
  );
}

pw.Widget _buildResumenGeneral(List<Map<String, dynamic>> tamizajes) {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: double.infinity,
          padding: pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Text(
            'RESUMEN DE TAMIZAJES RESPONDIDOS',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Container(
          padding: pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Total de tamizajes completados: ${tamizajes.length}',
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              ...tamizajes.map((t) => pw.Container(
                    margin: pw.EdgeInsets.only(bottom: 4),
                    child: pw.Row(
                      children: [
                        pw.Text('• ', style: pw.TextStyle(fontSize: 9)),
                        pw.Expanded(
                          child: pw.Text(
                            t['titulo'] as String,
                            style: pw.TextStyle(fontSize: 9),
                          ),
                        ),
                        pw.Text(
                          _formatFecha(t['fecha'] as Timestamp?),
                          style: pw.TextStyle(
                              fontSize: 8, color: PdfColors.grey700),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildDetalleTamizaje(Map<String, dynamic> tamizaje) {
  final titulo = tamizaje['titulo'] as String;
  final descripcion = tamizaje['descripcion'] as String;
  final resultados = tamizaje['resultados'] as Map<String, dynamic>;
  final puntajes = resultados['puntajesPorSustancia'] as Map<String, double>;
  final niveles = resultados['nivelRiesgoPorSustancia'] as Map<String, String>;
  final detalles = resultados['detallesPorSustancia']
      as Map<String, List<Map<String, dynamic>>>;

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Titulo del tamizaje
      pw.Container(
        width: double.infinity,
        padding: pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          color: PdfColors.blue100,
          border: pw.Border.all(color: PdfColors.blue700),
        ),
        child: pw.Text(
          titulo,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
      ),

      // Resultados finales por sustancia
      pw.Container(
        padding: pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey400),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'RESULTADOS:',
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),

            // Tabla compacta de resultados
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              columnWidths: {
                0: pw.FlexColumnWidth(3),
                1: pw.FlexColumnWidth(1.5),
                2: pw.FlexColumnWidth(1.5),
                3: pw.FlexColumnWidth(1),
              },
              children: [
                // Header
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Sustancia',
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Preguntas',
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Puntaje',
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text(
                        'Nivel',
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),

                // Filas de datos - SIEMPRE 10 SUSTANCIAS
                ..._obtenerTodasLasSustancias().map((sustancia) {
                  final puntaje = puntajes[sustancia] ?? 0.0;
                  final nivel = niveles[sustancia] ?? 'Sin alarma';
                  final numPreguntas = detalles[sustancia]?.length ?? 1;
                  final colorNivel = _getColorForNivel(nivel);

                  return pw.TableRow(
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          sustancia,
                          style: pw.TextStyle(fontSize: 7),
                        ),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          '$numPreguntas',
                          style: pw.TextStyle(fontSize: 7),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text(
                          puntaje.toStringAsFixed(1),
                          style: pw.TextStyle(
                              fontSize: 7, fontWeight: pw.FontWeight.bold),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.all(5),
                        decoration: pw.BoxDecoration(color: colorNivel),
                        child: pw.Text(
                          nivel,
                          style: pw.TextStyle(
                            fontSize: 7,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),

      // Detalle de respuestas
      pw.Container(
        padding: pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          border: pw.Border(
            left: pw.BorderSide(color: PdfColors.grey400),
            right: pw.BorderSide(color: PdfColors.grey400),
            bottom: pw.BorderSide(color: PdfColors.grey400),
          ),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'DETALLE DE RESPUESTAS:',
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 5),

            // Mostrar todas las sustancias
            ..._obtenerTodasLasSustancias().map((sustancia) {
              final preguntasRespuestas = detalles[sustancia] ?? [];
              final puntaje = puntajes[sustancia] ?? 0.0;

              return pw.Container(
                margin: pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          '• ',
                          style: pw.TextStyle(fontSize: 7),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            sustancia,
                            style: pw.TextStyle(
                              fontSize: 7,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...preguntasRespuestas.map((item) {
                      final respuesta = item['respuesta'] as String;
                      final valor = item['valor'] as double;

                      return pw.Container(
                        margin: pw.EdgeInsets.only(left: 10, bottom: 2),
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 15,
                              child: pw.Text(
                                '${valor.toInt()}',
                                style: pw.TextStyle(
                                  fontSize: 6,
                                  fontWeight: pw.FontWeight.bold,
                                  color: valor > 0
                                      ? PdfColors.blue700
                                      : PdfColors.grey500,
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Text(
                                respuesta,
                                style: pw.TextStyle(fontSize: 6),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    ],
  );
}

/// Retorna la lista completa de sustancias
List<String> _obtenerTodasLasSustancias() {
  return [
    'Tabaco',
    'Bebidas alcoholicas',
    'Cannabis',
    'Cocaina',
    'Anfetaminas',
    'Inhalantes',
    'Tranquilizantes',
    'Alucinogenos',
    'Opiaceos',
    'Otros',
  ];
}

PdfColor _getColorForNivel(String nivel) {
  switch (nivel.toUpperCase()) {
    case 'BAJO':
      return PdfColors.green50;
    case 'MODERADO':
      return PdfColors.yellow50;
    case 'ALTO':
      return PdfColors.red50;
    case 'SIN ALARMA':
      return PdfColors.grey100;
    default:
      return PdfColors.grey100;
  }
}

pw.Widget _buildFirmas(String fecha) {
  return pw.Center(
    child: pw.Column(
      children: [
        pw.Container(
          width: 250,
          margin: pw.EdgeInsets.only(bottom: 5),
          child: pw.Divider(thickness: 1),
        ),
        pw.Text(
          'PROFESIONAL RESPONSABLE',
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(
          'Fecha: $fecha',
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        ),
      ],
    ),
  );
}

String _formatFecha(Timestamp? timestamp) {
  if (timestamp == null) return 'Sin fecha';
  final fecha = timestamp.toDate();
  return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
}

Future<void> _mostrarPDF(Uint8List pdfBytes, String usuario) async {
  try {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
    print('PDF mostrado exitosamente para: $usuario');
  } catch (e) {
    print('Error al mostrar PDF: $e');
    await _compartirPDF(pdfBytes, usuario);
  }
}

Future<void> _compartirPDF(Uint8List pdfBytes, String usuario) async {
  try {
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'reporte_tamizajes_${_sanitizarNombreArchivo(usuario)}.pdf',
    );
    print('PDF compartido exitosamente para: $usuario');
  } catch (e) {
    print('Error al compartir PDF: $e');
    throw Exception('No se pudo mostrar ni compartir el PDF');
  }
}

String _sanitizarNombreArchivo(String nombre) {
  return nombre.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
}
