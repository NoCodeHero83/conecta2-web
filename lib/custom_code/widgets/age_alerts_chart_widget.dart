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

class AgeAlertsChartWidget extends StatefulWidget {
  const AgeAlertsChartWidget({
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
  State<AgeAlertsChartWidget> createState() => _AgeAlertsChartWidgetState();
}

class _AgeAlertsChartWidgetState extends State<AgeAlertsChartWidget> {
  List<AgeAlertData> alertsData = [
    AgeAlertData('5-9', 0),
    AgeAlertData('10-14', 0),
    AgeAlertData('15-19', 0),
    AgeAlertData('+20', 0),
  ];

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
    _loadAgeData();
  }

  @override
  void didUpdateWidget(covariant AgeAlertsChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colegio != widget.colegio ||
        oldWidget.nivelRiesgo != widget.nivelRiesgo ||
        oldWidget.sustancia != widget.sustancia ||
        oldWidget.tamizaje != widget.tamizaje) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      _loadAgeData();
    }
  }

  String? _normalizarFiltro(String? filtro) {
    if (filtro == null || filtro.trim().isEmpty) return null;
    final normalized = filtro.trim().toUpperCase();
    if (normalized == 'TODOS' || normalized == 'TODAS') return null;
    return filtro.trim();
  }

  Future<void> _loadAgeData() async {
    try {
      // Normalizar filtros
      final colegioFiltro = _normalizarFiltro(widget.colegio);
      final nivelRiesgoFiltro = _normalizarFiltro(widget.nivelRiesgo);
      final sustanciaFiltro = _normalizarFiltro(widget.sustancia);
      final tamizajeFiltro = _normalizarFiltro(widget.tamizaje);

      debugPrint('=== GRAFICO EDAD (ALERTAS) - FILTROS ===');
      debugPrint('Colegio: ${colegioFiltro ?? "TODOS"}');
      debugPrint('Nivel Riesgo: ${nivelRiesgoFiltro ?? "TODOS"}');
      debugPrint('Sustancia: ${sustanciaFiltro ?? "TODAS"}');
      debugPrint('Tamizaje: ${tamizajeFiltro ?? "TODOS"}');

      // VALIDACIÓN: Si no hay tamizaje específico seleccionado
      if (tamizajeFiltro == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'Seleccione un tamizaje para ver el gráfico de edad';
          alertsData = [
            AgeAlertData('5-9', 0),
            AgeAlertData('10-14', 0),
            AgeAlertData('15-19', 0),
            AgeAlertData('+20', 0),
          ];
        });
        return;
      }

      await _loadAlertsByAge(
          colegioFiltro, nivelRiesgoFiltro, sustanciaFiltro, tamizajeFiltro);
    } catch (e) {
      debugPrint('Error al cargar datos de edad: $e');
      setState(() {
        errorMessage = 'Error al cargar datos';
        isLoading = false;
      });
    }
  }

  Future<void> _loadAlertsByAge(
      String? colegioFiltro,
      String? nivelRiesgoFiltro,
      String? sustanciaFiltro,
      String? tamizajeFiltro) async {
    Map<String, int> edadAlertasCount = {
      '5-9': 0,
      '10-14': 0,
      '15-19': 0,
      '+20': 0,
    };

    // Construir query base para encuestas
    Query<Map<String, dynamic>> encuestasQuery = FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .where('Publicado', isEqualTo: true);

    // Si hay filtro de tamizaje específico, agregar a la query
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

      debugPrint('Procesando encuesta: ${encuestaData['titulo']}');

      // Obtener todas las respuestas
      final respuestasSnapshot = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(encuestaId)
          .collection('Respuestas')
          .get();

      debugPrint('  Respuestas encontradas: ${respuestasSnapshot.docs.length}');

      for (var respuestaDoc in respuestasSnapshot.docs) {
        final respuestaData = respuestaDoc.data();
        final userRef = respuestaData['User_respuesta'] as DocumentReference?;

        if (userRef == null) continue;

        // Obtener datos del usuario
        final userDoc = await userRef.get();
        if (!userDoc.exists) continue;

        final userData = userDoc.data() as Map<String, dynamic>;
        final colegioUsuario = userData['colegio'] as String? ?? '';
        final fechaNacimiento = userData['fecha_nacimiento'];

        // FILTRO 1: Por colegio (solo si está definido)
        // Si colegioFiltro es null, incluye TODOS los colegios
        if (colegioFiltro != null &&
            colegioUsuario.isNotEmpty &&
            !colegioUsuario
                .toUpperCase()
                .contains(colegioFiltro.toUpperCase())) {
          continue;
        }

        // Calcular edad del usuario
        int? edad;
        if (fechaNacimiento != null) {
          DateTime? birthDate;
          if (fechaNacimiento is Timestamp) {
            birthDate = fechaNacimiento.toDate();
          } else if (fechaNacimiento is String) {
            birthDate = DateTime.tryParse(fechaNacimiento);
          }

          if (birthDate != null) {
            final now = DateTime.now();
            edad = now.year - birthDate.year;
            if (now.month < birthDate.month ||
                (now.month == birthDate.month && now.day < birthDate.day)) {
              edad--;
            }
          }
        }

        // Si no tiene edad válida, continuar con el siguiente usuario
        if (edad == null) {
          continue;
        }

        // Determinar rango de edad
        String? rangoEdad;
        if (edad >= 5 && edad <= 9) {
          rangoEdad = '5-9';
        } else if (edad >= 10 && edad <= 14) {
          rangoEdad = '10-14';
        } else if (edad >= 15 && edad <= 19) {
          rangoEdad = '15-19';
        } else if (edad >= 20) {
          rangoEdad = '+20';
        } else {
          continue;
        }

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
          // FILTRO 2: Por sustancia (solo si está definido) - usando comparación sin tildes
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

          // FILTRO 3: Por nivel de riesgo (solo si está definido)
          if (nivelRiesgoFiltro != null &&
              nivel.toUpperCase() != nivelRiesgoFiltro.toUpperCase()) {
            continue;
          }

          // Contar esta alerta para el rango de edad
          edadAlertasCount[rangoEdad] = (edadAlertasCount[rangoEdad] ?? 0) + 1;
        }
      }
    }

    debugPrint('=== RESULTADO FINAL ===');
    debugPrint('Alertas por edad: $edadAlertasCount');
    debugPrint(
        'Total alertas: ${edadAlertasCount.values.reduce((a, b) => a + b)}');

    setState(() {
      alertsData = [
        AgeAlertData('5-9', edadAlertasCount['5-9'] ?? 0),
        AgeAlertData('10-14', edadAlertasCount['10-14'] ?? 0),
        AgeAlertData('15-19', edadAlertasCount['15-19'] ?? 0),
        AgeAlertData('+20', edadAlertasCount['+20'] ?? 0),
      ];
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
    List<String> partes = ['ALERTAS POR EDAD'];

    if (widget.colegio != null &&
        widget.colegio!.trim().isNotEmpty &&
        widget.colegio!.trim().toUpperCase() != 'TODOS') {
      partes.add(widget.colegio!);
    }

    return partes.join(' - ');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: widget.width,
        height: widget.height ?? 400,
        padding: const EdgeInsets.all(16),
        child: Center(
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
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Container(
        width: widget.width,
        height: widget.height ?? 400,
        padding: const EdgeInsets.all(16),
        child: Center(
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
        ),
      );
    }

    // Determinar valor maximo para el eje Y
    double maxValue = alertsData
        .map((e) => e.alerts.toDouble())
        .fold(0.0, (a, b) => a > b ? a : b);
    final roundedMax =
        maxValue > 0 ? ((maxValue / 10).ceil() * 10).toDouble() : 10.0;

    return Container(
      width: widget.width,
      height: widget.height ?? 400,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 20,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getTitulo(),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Outfit',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xffF7B900),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Alertas',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                maxY: roundedMax,
                minY: 0.0,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String ageGroup = alertsData[group.x.toInt()].ageGroup;
                      return BarTooltipItem(
                        '$ageGroup años\n${rod.toY.round()} alertas',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
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
                        if (value.toInt() < alertsData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              alertsData[value.toInt()].ageGroup,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 11,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Readex Pro',
                                fontSize: 11,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        );
                      },
                      reservedSize: 30,
                      interval: roundedMax > 0 ? (roundedMax / 5) : 2.0,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    left: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: roundedMax > 0 ? (roundedMax / 5) : 2.0,
                  verticalInterval: 1.0,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: FlutterFlowTheme.of(context)
                          .alternate
                          .withOpacity(0.3),
                      strokeWidth: 0.5,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.transparent,
                      strokeWidth: 0,
                    );
                  },
                ),
                barGroups: alertsData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final barColor = data.alerts > 0
                      ? const Color(0xffF7B900)
                      : const Color(0xffF7B900).withOpacity(0.2);

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.alerts.toDouble(),
                        color: barColor,
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AgeAlertData {
  final String ageGroup;
  final int alerts;

  AgeAlertData(this.ageGroup, this.alerts);
}
