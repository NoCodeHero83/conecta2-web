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

class HorizontalBarChartEPSWidget extends StatefulWidget {
  const HorizontalBarChartEPSWidget({
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
  State<HorizontalBarChartEPSWidget> createState() =>
      _HorizontalBarChartEPSWidgetState();
}

class _HorizontalBarChartEPSWidgetState
    extends State<HorizontalBarChartEPSWidget> {
  List<ChartData> chartData = [];
  int? touchedIndex;
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
  void didUpdateWidget(HorizontalBarChartEPSWidget oldWidget) {
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

  Future<void> fetchChartData() async {
    try {
      // Normalizar filtros - si es "Todos" o vacío, se considera null
      final colegioFiltro = (widget.colegio == null ||
              widget.colegio!.trim().isEmpty ||
              widget.colegio!.trim().toUpperCase() == 'TODOS')
          ? null
          : widget.colegio!.trim();

      final nivelRiesgoFiltro = (widget.nivelRiesgo == null ||
              widget.nivelRiesgo!.trim().isEmpty ||
              widget.nivelRiesgo!.trim().toUpperCase() == 'TODOS')
          ? null
          : widget.nivelRiesgo!.trim();

      final sustanciaFiltro = (widget.sustancia == null ||
              widget.sustancia!.trim().isEmpty ||
              widget.sustancia!.trim().toUpperCase() == 'TODOS' ||
              widget.sustancia!.trim().toUpperCase() == 'TODAS')
          ? null
          : widget.sustancia!.trim();

      final tamizajeFiltro = (widget.tamizaje == null ||
              widget.tamizaje!.trim().isEmpty ||
              widget.tamizaje!.trim().toUpperCase() == 'TODOS')
          ? null
          : widget.tamizaje!.trim();

      debugPrint('=== FILTROS DEL GRAFICO EPS (ALERTAS) ===');
      debugPrint('Colegio: ${colegioFiltro ?? "TODOS"}');
      debugPrint('Nivel Riesgo: ${nivelRiesgoFiltro ?? "TODOS"}');
      debugPrint('Sustancia: ${sustanciaFiltro ?? "TODAS"}');
      debugPrint('Tamizaje: ${tamizajeFiltro ?? "TODOS"}');

      // VALIDACIÓN: Si no hay tamizaje específico seleccionado
      if (tamizajeFiltro == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'Seleccione un tamizaje para ver el gráfico';
          chartData = [];
        });
        return;
      }

      // Siempre contar alertas
      await _fetchAlertasData(
          colegioFiltro, nivelRiesgoFiltro, sustanciaFiltro, tamizajeFiltro);
    } catch (e) {
      debugPrint('Error al cargar datos del grafico: $e');
      setState(() {
        errorMessage = 'Error al cargar datos';
        isLoading = false;
      });
    }
  }

  Future<void> _fetchAlertasData(
      String? colegioFiltro,
      String? nivelRiesgoFiltro,
      String? sustanciaFiltro,
      String? tamizajeFiltro) async {
    Map<String, int> epsAlertasCount = {};

    // Construir query base para encuestas
    Query<Map<String, dynamic>> encuestasQuery = FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .where('Publicado', isEqualTo: true);

    // Si hay filtro de tamizaje específico, agregar a la query usando "titulo"
    if (tamizajeFiltro != null) {
      encuestasQuery =
          encuestasQuery.where('titulo', isEqualTo: tamizajeFiltro);
    }

    final encuestasSnapshot = await encuestasQuery.get();

    debugPrint('Total encuestas encontradas: ${encuestasSnapshot.docs.length}');

    for (var encuestaDoc in encuestasSnapshot.docs) {
      final encuestaData = encuestaDoc.data();
      final encuestaId = encuestaDoc.id;
      final alertas = encuestaData['alertas'] as List<dynamic>? ?? [];

      // Obtener todas las respuestas
      final respuestasSnapshot = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(encuestaId)
          .collection('Respuestas')
          .get();

      for (var respuestaDoc in respuestasSnapshot.docs) {
        final respuestaData = respuestaDoc.data();
        final userRef = respuestaData['User_respuesta'] as DocumentReference?;

        if (userRef == null) continue;

        // Obtener datos del usuario
        final userDoc = await userRef.get();
        if (!userDoc.exists) continue;

        final userData = userDoc.data() as Map<String, dynamic>;
        final colegioUsuario = userData['colegio'] as String? ?? '';
        final epsUsuario = userData['eps'] as String? ?? '';

        // FILTRO 1: Por colegio (si está definido)
        if (colegioFiltro != null &&
            !colegioUsuario
                .toUpperCase()
                .contains(colegioFiltro.toUpperCase())) {
          continue;
        }

        // Si NO hay EPS válida, no contabilizar
        if (epsUsuario.isEmpty) continue;

        // Procesar respuestas del test
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
          if (sustanciaFiltro != null) {
            final sustanciaItemSinTildes =
                _quitarTildes(sustanciaItem.toUpperCase());
            final sustanciaFiltroSinTildes =
                _quitarTildes(sustanciaFiltro.toUpperCase());

            if (!sustanciaItemSinTildes.contains(sustanciaFiltroSinTildes)) {
              continue;
            }
          }

          final puntaje = puntajesPorSustancia[sustanciaItem]!;
          final nivel = _evaluarNivelRiesgo(sustanciaItem, puntaje, alertas);

          // FILTRO 3: Por nivel de riesgo (si está definido)
          if (nivelRiesgoFiltro != null &&
              nivel.toUpperCase() != nivelRiesgoFiltro.toUpperCase()) {
            continue;
          }

          // Contar esta alerta para la EPS
          epsAlertasCount[epsUsuario] = (epsAlertasCount[epsUsuario] ?? 0) + 1;
        }
      }
    }

    debugPrint('EPS con alertas: ${epsAlertasCount.length}');
    epsAlertasCount.forEach((key, value) {
      debugPrint('$key: $value alertas');
    });

    // Ordenar y tomar top 5
    final sortedEntries = epsAlertasCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final top5Entries = sortedEntries.take(5).toList();

    List<ChartData> dataList =
        top5Entries.map((e) => ChartData(e.key, e.value)).toList();

    setState(() {
      chartData = dataList;
      isLoading = false;
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

  String _getTitulo() {
    String titulo = 'ALERTAS POR EPS';

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

    if (chartData.isEmpty) {
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

    final sortedData = List<ChartData>.from(chartData)
      ..sort((a, b) => b.value.compareTo(a.value));

    final maxValue = sortedData.first.value.toDouble();
    final roundedMax = ((maxValue / 20).ceil() * 20).toDouble();

    double getBarWidth() {
      if (sortedData.length == 1) return 80.0;
      if (sortedData.length == 2) return 60.0;
      if (sortedData.length == 3) return 50.0;
      if (sortedData.length <= 5) return 40.0;
      return 35.0;
    }

    return Container(
      width: widget.width,
      height: widget.height ?? 400,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 0),
            child: Text(
              _getTitulo(),
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: Transform.rotate(
                        angle: math.pi / 2,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            maxY: roundedMax,
                            minY: 0,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (group) =>
                                    FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                tooltipPadding: const EdgeInsets.all(8),
                                tooltipMargin: 8,
                                direction: TooltipDirection.auto,
                                tooltipBorder: BorderSide(
                                  color:
                                      const Color(0xFF3B82F6).withOpacity(0.3),
                                  width: 1,
                                ),
                                fitInsideHorizontally: true,
                                fitInsideVertically: true,
                                rotateAngle: -90,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  final data = sortedData[group.x.toInt()];
                                  return BarTooltipItem(
                                    '${data.value}',
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF3B82F6),
                                        ),
                                  );
                                },
                              ),
                              touchCallback:
                                  (FlTouchEvent event, barTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      barTouchResponse == null ||
                                      barTouchResponse.spot == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = barTouchResponse
                                      .spot!.touchedBarGroupIndex;
                                });
                              },
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 &&
                                        index < sortedData.length) {
                                      return Transform.rotate(
                                        angle: -math.pi / 2,
                                        child: Container(
                                          width: 130,
                                          padding: const EdgeInsets.only(
                                              left: 12.0, top: 6.0),
                                          alignment: sortedData.length == 1
                                              ? Alignment.center
                                              : Alignment.centerLeft,
                                          child: Text(
                                            sortedData[index].epsName,
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: sortedData.length == 1
                                                ? TextAlign.center
                                                : TextAlign.left,
                                          ),
                                        ),
                                      );
                                    }
                                    return const Text('');
                                  },
                                  reservedSize: 130,
                                  interval: 1,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    // Ocultar el 0 y el valor máximo
                                    if (value == 0 || value == roundedMax) {
                                      return const Text('');
                                    }
                                    return Transform.rotate(
                                      angle: -math.pi / 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Text(
                                          value.toInt().toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 11,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                  reservedSize: 40,
                                  interval: 20,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                left: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.5,
                                ),
                                bottom: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              horizontalInterval: 20,
                              verticalInterval: 1,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: FlutterFlowTheme.of(context)
                                      .alternate
                                      .withOpacity(0.3),
                                  strokeWidth: 0.8,
                                  dashArray: [5, 5],
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: FlutterFlowTheme.of(context)
                                      .alternate
                                      .withOpacity(0.3),
                                  strokeWidth: 0.8,
                                );
                              },
                            ),
                            barGroups: sortedData.asMap().entries.map((entry) {
                              final index = entry.key;
                              final data = entry.value;
                              final isTouched = index == touchedIndex;
                              final baseWidth = getBarWidth();

                              return BarChartGroupData(
                                x: index,
                                groupVertically: true,
                                barRods: [
                                  BarChartRodData(
                                    toY: data.value.toDouble(),
                                    color: isTouched
                                        ? const Color(0xFF60A5FA)
                                        : const Color(0xff045AA4),
                                    width:
                                        isTouched ? baseWidth + 5 : baseWidth,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  final String epsName;
  final int value;

  ChartData(this.epsName, this.value);
}
