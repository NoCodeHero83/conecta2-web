// Pure data-processing helpers used by the TamizajeDataTable widget.

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/substance_data.dart';

String quitarTildes(String texto) {
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

String extraerSustancia(String pregunta) {
  final preguntaLower = pregunta.toLowerCase();
  final preguntaNormalizada = quitarTildes(preguntaLower);

  if (preguntaNormalizada.contains('tabaco') ||
      preguntaNormalizada.contains('cigarrillo')) return 'Tabaco';
  if (preguntaNormalizada.contains('alcohol') ||
      preguntaNormalizada.contains('bebidas')) return 'Bebidas alcohólicas';
  if (preguntaNormalizada.contains('cannabis') ||
      preguntaNormalizada.contains('marihuana')) return 'Cannabis';
  if (preguntaNormalizada.contains('cocaina') ||
      preguntaNormalizada.contains('coca')) return 'Cocaína';
  if (preguntaNormalizada.contains('anfetamina') ||
      preguntaNormalizada.contains('estimulante')) return 'Anfetaminas';
  if (preguntaNormalizada.contains('inhalante')) return 'Inhalantes';
  if (preguntaNormalizada.contains('tranquilizante') ||
      preguntaNormalizada.contains('pastillas') ||
      preguntaNormalizada.contains('sedante')) return 'Tranquilizantes';
  if (preguntaNormalizada.contains('alucinogeno')) return 'Alucinógenos';
  if (preguntaNormalizada.contains('opiaceo') ||
      preguntaNormalizada.contains('heroina')) return 'Opiáceos';

  return 'Otros';
}

String evaluarNivelRiesgo(
    String sustancia, double puntaje, List<dynamic> alertas) {
  final sustanciaNormalizada = quitarTildes(sustancia.toLowerCase());

  List<Map<String, dynamic>> alertasCoincidentes = [];

  for (var alerta in alertas) {
    if (alerta is! Map<String, dynamic>) continue;

    final sustanciaAlerta = alerta['sustancia'] as String?;
    if (sustanciaAlerta == null) continue;

    final sustanciaAlertaNormalizada =
        quitarTildes(sustanciaAlerta.toLowerCase());

    final nivel = alerta['nivel'] as String?;
    final min = (alerta['min'] as num?)?.toDouble() ?? 0.0;
    final max = (alerta['max'] as num?)?.toDouble() ?? 0.0;

    if (sustanciaAlertaNormalizada == sustanciaNormalizada) {
      alertasCoincidentes.add({
        'nivel': nivel ?? 'Sin alarma',
        'min': min,
        'max': max,
      });
    }
  }

  if (alertasCoincidentes.isEmpty) {
    return 'Sin alarma';
  }

  alertasCoincidentes.sort((a, b) => a['min'].compareTo(b['min']));

  if (puntaje < alertasCoincidentes.first['min']) {
    return 'Sin alarma';
  }

  for (var i = 0; i < alertasCoincidentes.length; i++) {
    var alerta = alertasCoincidentes[i];
    final min = alerta['min'];
    final max = alerta['max'];
    final nivel = alerta['nivel'];

    if (i == alertasCoincidentes.length - 1 && max == 0) {
      if (puntaje >= min) {
        return nivel;
      }
    }

    if (i < alertasCoincidentes.length - 1) {
      final siguienteMin = alertasCoincidentes[i + 1]['min'];
      if (puntaje >= min && puntaje < siguienteMin) {
        return nivel;
      }
    } else if (max > 0) {
      if (puntaje >= min && puntaje <= max) {
        return nivel;
      }
    }
  }

  return alertasCoincidentes.last['nivel'];
}

Map<String, dynamic> procesarRespuestasTamizaje(
  Map<String, dynamic> encuestaData,
  Map<String, dynamic> respuestaData,
) {
  final alertas = encuestaData['alertas'] as List<dynamic>? ?? [];
  final test = respuestaData['test'] as List<dynamic>? ?? [];

  Map<String, double> puntajesPorSustancia = {};
  Map<String, List<Map<String, dynamic>>> detallesPorSustancia = {};

  for (var item in test) {
    if (item is! Map<String, dynamic>) continue;

    final tipo = item['Tipo'] as String?;
    if (tipo != 'Tamizaje') continue;

    final pregunta = item['Pregunta'] as String? ?? '';
    final respuestaTamizaje =
        item['RespuestaTamizaje'] as List<dynamic>? ?? [];

    if (respuestaTamizaje.isEmpty) continue;

    final respuestaSeleccionada =
        respuestaTamizaje[0] as Map<String, dynamic>;
    final etiqueta = respuestaSeleccionada['etiqueta'] as String? ?? '';
    final valor = (respuestaSeleccionada['valor'] as num?)?.toDouble() ?? 0.0;

    String sustancia = extraerSustancia(pregunta);

    puntajesPorSustancia[sustancia] =
        (puntajesPorSustancia[sustancia] ?? 0) + valor;

    if (!detallesPorSustancia.containsKey(sustancia)) {
      detallesPorSustancia[sustancia] = [];
    }
    detallesPorSustancia[sustancia]!.add({
      'pregunta': pregunta,
      'respuesta': etiqueta,
      'valor': valor,
    });
  }

  Map<String, String> nivelRiesgoPorSustancia = {};
  for (var sustancia in puntajesPorSustancia.keys) {
    final puntaje = puntajesPorSustancia[sustancia]!;
    nivelRiesgoPorSustancia[sustancia] =
        evaluarNivelRiesgo(sustancia, puntaje, alertas);
  }

  return {
    'puntajesPorSustancia': puntajesPorSustancia,
    'detallesPorSustancia': detallesPorSustancia,
    'nivelRiesgoPorSustancia': nivelRiesgoPorSustancia,
  };
}

Map<String, dynamic> completarSustanciasFaltantes(
    Map<String, dynamic> resultados) {
  final puntajesPorSustancia =
      Map<String, double>.from(resultados['puntajesPorSustancia'] ?? {});
  final nivelesRiesgoPorSustancia =
      Map<String, String>.from(resultados['nivelRiesgoPorSustancia'] ?? {});
  final detallesPorSustancia = Map<String, List<Map<String, dynamic>>>.from(
      resultados['detallesPorSustancia'] ?? {});

  for (var sustancia in kTodasLasSustancias) {
    if (!puntajesPorSustancia.containsKey(sustancia)) {
      puntajesPorSustancia[sustancia] = 0.0;
      nivelesRiesgoPorSustancia[sustancia] = 'Sin alarma';

      if (!detallesPorSustancia.containsKey(sustancia)) {
        detallesPorSustancia[sustancia] = [
          {
            'pregunta': 'Consumo de $sustancia',
            'respuesta': 'Nunca',
            'valor': 0.0,
          }
        ];
      }
    }
  }

  return {
    'puntajesPorSustancia': puntajesPorSustancia,
    'detallesPorSustancia': detallesPorSustancia,
    'nivelRiesgoPorSustancia': nivelesRiesgoPorSustancia,
  };
}

String formatFecha(Timestamp? timestamp) {
  if (timestamp == null) return 'Sin fecha';
  final fecha = timestamp.toDate();
  return '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
}

Map<String, dynamic> crearRegistroExcel(
  Map<String, dynamic> userData,
  Map<String, dynamic> resultados,
  Map<String, dynamic> respuestaData,
  int numeroRegistro,
) {
  final puntajes = resultados['puntajesPorSustancia'] as Map<String, double>;
  final niveles =
      resultados['nivelRiesgoPorSustancia'] as Map<String, String>;

  String fechaNacimientoFormateada = 'No registrada';
  String edad = 'No registrada';
  if (userData['fecha_nacimiento'] != null) {
    final fechaNacimiento =
        (userData['fecha_nacimiento'] as Timestamp).toDate();
    final ahora = DateTime.now();
    final edadCalculada = ahora.year - fechaNacimiento.year;
    edad = '$edadCalculada';
    fechaNacimientoFormateada =
        '${fechaNacimiento.day.toString().padLeft(2, '0')}/${fechaNacimiento.month.toString().padLeft(2, '0')}/${fechaNacimiento.year}';
  }

  String cursoVida = 'Adolescente';
  if (edad != 'No registrada') {
    final edadNum = int.tryParse(edad) ?? 0;
    if (edadNum < 13) {
      cursoVida = 'Niño';
    } else if (edadNum >= 13 && edadNum <= 19) {
      cursoVida = 'Adolescente';
    } else {
      cursoVida = 'Adulto';
    }
  }

  return {
    'N': numeroRegistro,
    'ANO': DateTime.now().year,
    'FOLIO': 'TZ${numeroRegistro.toString().padLeft(3, '0')}',
    'NOMBRE': userData['display_name'] ?? 'No especificado',
    'COLEGIO': userData['colegio'] ?? 'No registrado',
    'DOCUMENTO': userData['identidad'] ?? 'No registrado',
    'EDAD': edad,
    'FECHA_NACIMIENTO': fechaNacimientoFormateada,
    'GENERO': userData['genero'] ?? 'No especificado',
    'MUNICIPIO': userData['municipio'] ?? 'No registrado',
    'BARRIO': userData['barrio'] ?? 'No registrado',
    'GRADO': userData['grado']?.toString() ?? 'No registrado',
    'EPS': userData['eps'] ?? 'No registrada',
    'CURSO_VIDA': cursoVida,
    'TABACO_VALOR': puntajes['Tabaco'] ?? 0.0,
    'TABACO_RIESGO': niveles['Tabaco'] ?? 'Sin alarma',
    'ALCOHOL_VALOR': puntajes['Bebidas alcohólicas'] ?? 0.0,
    'ALCOHOL_RIESGO': niveles['Bebidas alcohólicas'] ?? 'Sin alarma',
    'CANNABIS_VALOR': puntajes['Cannabis'] ?? 0.0,
    'CANNABIS_RIESGO': niveles['Cannabis'] ?? 'Sin alarma',
    'COCAINA_VALOR': puntajes['Cocaína'] ?? 0.0,
    'COCAINA_RIESGO': niveles['Cocaína'] ?? 'Sin alarma',
    'ESTIMULANTES_VALOR': puntajes['Anfetaminas'] ?? 0.0,
    'ESTIMULANTES_RIESGO': niveles['Anfetaminas'] ?? 'Sin alarma',
    'INHALANTES_VALOR': puntajes['Inhalantes'] ?? 0.0,
    'INHALANTES_RIESGO': niveles['Inhalantes'] ?? 'Sin alarma',
    'SEDANTES_VALOR': puntajes['Tranquilizantes'] ?? 0.0,
    'SEDANTES_RIESGO': niveles['Tranquilizantes'] ?? 'Sin alarma',
    'ALUCINOGENOS_VALOR': puntajes['Alucinógenos'] ?? 0.0,
    'ALUCINOGENOS_RIESGO': niveles['Alucinógenos'] ?? 'Sin alarma',
    'OPIACEOS_VALOR': puntajes['Opiáceos'] ?? 0.0,
    'OPIACEOS_RIESGO': niveles['Opiáceos'] ?? 'Sin alarma',
    'OTRAS_VALOR': puntajes['Otros'] ?? 0.0,
    'OTRAS_RIESGO': niveles['Otros'] ?? 'Sin alarma',
    'FECHA_RESPUESTA': formatFecha(respuestaData['Fecha'] as Timestamp?),
  };
}
