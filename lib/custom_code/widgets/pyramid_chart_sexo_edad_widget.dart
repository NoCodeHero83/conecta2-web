// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

class PyramidChartSexoEdadWidget extends StatefulWidget {
  const PyramidChartSexoEdadWidget({
    super.key,
    this.width,
    this.height,
    this.colegio,
    this.nivelRiesgo,
    this.sustancia,
    this.tamizaje,
  });

  final double? width;
  final double? height;
  final String? colegio;
  final String? nivelRiesgo;
  final String? sustancia;
  final String? tamizaje;

  @override
  State<PyramidChartSexoEdadWidget> createState() =>
      _PyramidChartSexoEdadWidgetState();
}

class _PyramidChartSexoEdadWidgetState
    extends State<PyramidChartSexoEdadWidget> {
  Map<String, AgeGroupData> ageGroups = {};
  bool isLoading = true;
  String errorMessage = '';

  // Función para quitar tildes de un texto
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

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  @override
  void didUpdateWidget(PyramidChartSexoEdadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colegio != widget.colegio ||
        oldWidget.nivelRiesgo != widget.nivelRiesgo ||
        oldWidget.sustancia != widget.sustancia ||
        oldWidget.tamizaje != widget.tamizaje) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      fetchChartData();
    }
  }

  String getAgeGroup(int age) {
    if (age >= 0 && age <= 9) return '0-9';
    if (age >= 10 && age <= 14) return '10-14';
    if (age >= 15 && age <= 19) return '15-19';
    if (age >= 20 && age <= 24) return '20-24';
    if (age >= 25 && age <= 29) return '25-29';
    if (age >= 30 && age <= 34) return '30-34';
    if (age >= 35 && age <= 39) return '35-39';
    if (age >= 40 && age <= 49) return '40-49';
    if (age >= 50 && age <= 54) return '50-54';
    if (age >= 55 && age <= 59) return '55-59';
    return '60+';
  }

  int calculateAge(dynamic fechaNacimiento) {
    if (fechaNacimiento == null) return 0;

    DateTime? birthDate;
    if (fechaNacimiento is Timestamp) {
      birthDate = fechaNacimiento.toDate();
    } else if (fechaNacimiento is String) {
      birthDate = DateTime.tryParse(fechaNacimiento);
    }

    if (birthDate == null) return 0;

    final today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<void> fetchChartData() async {
    try {
      // Normalizar filtros - si es "Todos" o vacío, se considera null
      final filtroColegio = (widget.colegio == null ||
              widget.colegio!.trim().isEmpty ||
              widget.colegio!.trim().toUpperCase() == 'TODOS')
          ? null
          : widget.colegio!.trim();

      final filtroNivel = (widget.nivelRiesgo == null ||
              widget.nivelRiesgo!.trim().isEmpty ||
              widget.nivelRiesgo!.trim().toUpperCase() == 'TODOS')
          ? null
          : widget.nivelRiesgo!.trim();

      final filtroSustancia = (widget.sustancia == null ||
              widget.sustancia!.trim().isEmpty ||
              widget.sustancia!.trim().toUpperCase() == 'TODOS' ||
              widget.sustancia!.trim().toUpperCase() == 'TODAS')
          ? null
          : widget.sustancia!.trim();

      final filtroTamizaje = (widget.tamizaje == null ||
              widget.tamizaje!.trim().isEmpty ||
              widget.tamizaje!.trim().toUpperCase() == 'TODOS')
          ? null
          : widget.tamizaje!.trim();

      debugPrint('=== FILTROS PIRAMIDE (ALERTAS) ===');
      debugPrint('Colegio: ${filtroColegio ?? "TODOS"}');
      debugPrint('Nivel: ${filtroNivel ?? "TODOS"}');
      debugPrint('Sustancia: ${filtroSustancia ?? "TODAS"}');
      debugPrint('Tamizaje: ${filtroTamizaje ?? "TODOS"}');

      // VALIDACIÓN: Si no hay tamizaje específico seleccionado
      if (filtroTamizaje == null) {
        setState(() {
          isLoading = false;
          errorMessage =
              'Seleccione un tamizaje para ver el gráfico de pirámide';
          ageGroups = {};
        });
        return;
      }

      Map<String, AgeGroupData> tempGroups = {
        '0-9': AgeGroupData(),
        '10-14': AgeGroupData(),
        '15-19': AgeGroupData(),
        '20-24': AgeGroupData(),
        '25-29': AgeGroupData(),
        '30-34': AgeGroupData(),
        '35-39': AgeGroupData(),
        '40-49': AgeGroupData(),
        '50-54': AgeGroupData(),
        '55-59': AgeGroupData(),
        '60+': AgeGroupData(),
      };

      // Siempre contar alertas
      await _contarAlertas(tempGroups, filtroColegio, filtroNivel,
          filtroSustancia, filtroTamizaje);

      setState(() {
        ageGroups = tempGroups;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error al cargar datos del gráfico: $e');
      setState(() {
        errorMessage = 'Error al cargar datos';
        isLoading = false;
      });
    }
  }

  Future<void> _contarAlertas(
      Map<String, AgeGroupData> tempGroups,
      String? filtroColegio,
      String? filtroNivel,
      String? filtroSustancia,
      String? filtroTamizaje) async {
    // Construir query base para encuestas
    Query<Map<String, dynamic>> encuestasQuery = FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .where('Publicado', isEqualTo: true);

    // Si hay filtro de tamizaje específico, agregar a la query usando "titulo"
    if (filtroTamizaje != null) {
      encuestasQuery =
          encuestasQuery.where('titulo', isEqualTo: filtroTamizaje);
    }

    final encuestasSnapshot = await encuestasQuery.get();

    debugPrint('Total encuestas encontradas: ${encuestasSnapshot.docs.length}');

    // Procesar cada encuesta
    for (var encuestaDoc in encuestasSnapshot.docs) {
      final encuestaData = encuestaDoc.data();
      final alertas = encuestaData['alertas'] as List<dynamic>? ?? [];

      // Obtener respuestas de esta encuesta
      final respuestasSnapshot = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(encuestaDoc.id)
          .collection('Respuestas')
          .get();

      // Procesar cada respuesta
      for (var respuestaDoc in respuestasSnapshot.docs) {
        final respuestaData = respuestaDoc.data();
        final userRef = respuestaData['User_respuesta'] as DocumentReference?;

        if (userRef == null) continue;

        // Obtener datos del usuario
        final userDoc = await userRef.get();
        if (!userDoc.exists) continue;

        final userData = userDoc.data() as Map<String, dynamic>?;
        if (userData == null) continue;

        final colegio = userData['colegio']?.toString() ?? '';
        final genero = userData['genero']?.toString().trim() ?? '';
        final fechaNacimiento = userData['fecha_nacimiento'];

        // FILTRO 1: Por colegio (si está definido)
        if (filtroColegio != null &&
            colegio.isNotEmpty &&
            !colegio.toUpperCase().contains(filtroColegio.toUpperCase())) {
          continue;
        }

        // Verificar que tenga género y edad válidos
        if (genero.isEmpty || fechaNacimiento == null) continue;

        final age = calculateAge(fechaNacimiento);
        final ageGroup = getAgeGroup(age);

        // Calcular puntajes por sustancia
        final test = respuestaData['test'] as List<dynamic>? ?? [];
        Map<String, double> puntajesPorSustancia = {};

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
          final valor =
              (respuestaSeleccionada['valor'] as num?)?.toDouble() ?? 0.0;

          String sustanciaItem = _extraerSustancia(pregunta);
          puntajesPorSustancia[sustanciaItem] =
              (puntajesPorSustancia[sustanciaItem] ?? 0) + valor;
        }

        // Evaluar cada sustancia y contar alertas
        for (var sustanciaItem in puntajesPorSustancia.keys) {
          // FILTRO 2: Por sustancia (si está definido) - usando comparación sin tildes
          if (filtroSustancia != null) {
            final sustanciaItemSinTildes =
                _quitarTildes(sustanciaItem.toUpperCase());
            final sustanciaFiltroSinTildes =
                _quitarTildes(filtroSustancia.toUpperCase());

            if (!sustanciaItemSinTildes.contains(sustanciaFiltroSinTildes)) {
              continue;
            }
          }

          final puntaje = puntajesPorSustancia[sustanciaItem]!;
          final nivel = _evaluarNivelRiesgo(sustanciaItem, puntaje, alertas);

          // FILTRO 3: Por nivel (si está definido)
          if (filtroNivel != null &&
              nivel.toUpperCase() != filtroNivel.toUpperCase()) {
            continue;
          }

          // Contar esta alerta por género y grupo de edad
          if (genero.toLowerCase() == 'masculino') {
            tempGroups[ageGroup]?.masculino += 1;
          } else if (genero.toLowerCase() == 'femenino') {
            tempGroups[ageGroup]?.femenino += 1;
          }
        }
      }
    }

    // Debug: mostrar resultados
    debugPrint('=== RESULTADO ALERTAS POR EDAD Y SEXO ===');
    tempGroups.forEach((key, value) {
      if (value.masculino > 0 || value.femenino > 0) {
        debugPrint('$key -> M: ${value.masculino}, F: ${value.femenino}');
      }
    });
  }

  String _extraerSustancia(String pregunta) {
    final preguntaSinTildes = _quitarTildes(pregunta.toLowerCase());

    if (preguntaSinTildes.contains('tabaco')) return 'Tabaco';
    if (preguntaSinTildes.contains('alcohol') ||
        preguntaSinTildes.contains('bebidas')) return 'Bebidas alcoholicas';
    if (preguntaSinTildes.contains('cannabis') ||
        preguntaSinTildes.contains('marihuana')) return 'Cannabis';
    if (preguntaSinTildes.contains('cocaina') ||
        preguntaSinTildes.contains('coca')) return 'Cocaina';
    if (preguntaSinTildes.contains('anfetamina') ||
        preguntaSinTildes.contains('estimulante')) return 'Anfetaminas';
    if (preguntaSinTildes.contains('inhalante')) return 'Inhalantes';
    if (preguntaSinTildes.contains('tranquilizante')) return 'Tranquilizantes';
    if (preguntaSinTildes.contains('alucinogeno')) return 'Alucinogenos';
    if (preguntaSinTildes.contains('opiaceo') ||
        preguntaSinTildes.contains('heroina')) return 'Opiaceos';

    return 'Otros';
  }

  String _evaluarNivelRiesgo(
      String sustancia, double puntaje, List<dynamic> alertas) {
    // Normalizar la sustancia sin tildes para comparación
    final sustanciaSinTildes = _quitarTildes(sustancia);

    for (var alerta in alertas) {
      if (alerta is! Map<String, dynamic>) continue;

      final sustanciaAlerta = alerta['sustancia'] as String?;
      if (sustanciaAlerta == null) continue;

      // Normalizar la sustancia de la alerta sin tildes
      final sustanciaAlertaSinTildes = _quitarTildes(sustanciaAlerta);

      final nivel = alerta['nivel'] as String?;
      final min = (alerta['min'] as num?)?.toDouble() ?? 0.0;
      final max = (alerta['max'] as num?)?.toDouble() ?? 0.0;

      // Comparar sustancias sin tildes
      if (sustanciaAlertaSinTildes == sustanciaSinTildes) {
        if (max == 0 && puntaje >= min) {
          return nivel ?? 'Desconocido';
        }
        if (puntaje >= min && puntaje <= max) {
          return nivel ?? 'Desconocido';
        }
      }
    }

    return 'Bajo';
  }

  String _generarTitulo() {
    String titulo = 'ALERTAS POR SEXO Y EDAD';

    if (widget.colegio != null &&
        widget.colegio!.trim().isNotEmpty &&
        widget.colegio!.trim().toUpperCase() != 'TODOS') {
      titulo += ' EN ${widget.colegio!.toUpperCase()}';
    }

    return titulo;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: FlutterFlowTheme.of(context).primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Cargando datos...',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ],
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_outlined,
              size: 48,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 16,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (ageGroups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            const SizedBox(height: 16),
            Text(
              'No se encontraron alertas con los filtros aplicados.',
              style: FlutterFlowTheme.of(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Obtener el valor máximo para escalar
    int maxValue = 0;
    ageGroups.forEach((key, value) {
      if (value.masculino > maxValue) maxValue = value.masculino;
      if (value.femenino > maxValue) maxValue = value.femenino;
    });

    final sortedKeys = ageGroups.keys.toList();

    return Container(
      width: widget.width,
      height: widget.height ?? 400,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Título
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 0),
            child: Text(
              _generarTitulo(),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          // Leyenda
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xff045AA4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Sexo M',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xffDF2B19),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Sexo F',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
          // Gráfico de pirámide
          Expanded(
            child: ListView.builder(
              itemCount: sortedKeys.length,
              itemBuilder: (context, index) {
                final key = sortedKeys[index];
                final data = ageGroups[key]!;

                final masculinoWidth =
                    maxValue > 0 ? (data.masculino / maxValue) : 0.0;
                final femeninoWidth =
                    maxValue > 0 ? (data.femenino / maxValue) : 0.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      // Lado Masculino (Izquierda)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (data.masculino > 0)
                              Text(
                                '${data.masculino}',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 11,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: FractionallySizedBox(
                                alignment: Alignment.centerRight,
                                widthFactor: masculinoWidth,
                                child: Container(
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff045AA4),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      bottomLeft: Radius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Centro - Etiqueta de edad
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          key,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Readex Pro',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                      ),
                      // Lado Femenino (Derecha)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: femeninoWidth,
                                child: Container(
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffDF2B19),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (data.femenino > 0)
                              Text(
                                '${data.femenino}',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 11,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AgeGroupData {
  int masculino = 0;
  int femenino = 0;
}
