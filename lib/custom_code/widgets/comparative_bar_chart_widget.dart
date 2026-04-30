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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class ComparativeBarChartWidget extends StatefulWidget {
  final String? colegio;
  final String? nivelRiesgo;
  final String? sustancia;
  final String? tamizaje;
  final double width;
  final double height;

  const ComparativeBarChartWidget({
    Key? key,
    this.colegio,
    this.nivelRiesgo,
    this.sustancia,
    this.tamizaje,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ComparativeBarChartWidgetState createState() =>
      _ComparativeBarChartWidgetState();
}

class _ComparativeBarChartWidgetState extends State<ComparativeBarChartWidget> {
  late List<BarChartGroupData> _chartData;
  late List<String> _years;
  bool _isLoading = true;
  String _errorMessage = '';

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
    _fetchChartData();
  }

  @override
  void didUpdateWidget(ComparativeBarChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colegio != widget.colegio ||
        oldWidget.nivelRiesgo != widget.nivelRiesgo ||
        oldWidget.sustancia != widget.sustancia ||
        oldWidget.tamizaje != widget.tamizaje) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
      _fetchChartData();
    }
  }

  Future<void> _fetchChartData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Normalizar filtros
      final filtroColegio = _normalizeFilter(widget.colegio);
      final filtroNivel = _normalizeFilter(widget.nivelRiesgo);
      final filtroSustancia = _normalizeFilter(widget.sustancia);
      final filtroTamizaje = _normalizeFilter(widget.tamizaje);

      debugPrint('=== FILTROS COMPARATIVO (ALERTAS) ===');
      debugPrint('Colegio: ${filtroColegio ?? "TODOS"}');
      debugPrint('Nivel: ${filtroNivel ?? "TODOS"}');
      debugPrint('Sustancia: ${filtroSustancia ?? "TODAS"}');
      debugPrint('Tamizaje: ${filtroTamizaje ?? "TODOS"}');

      // VALIDACIÓN: Si no hay tamizaje específico seleccionado
      if (filtroTamizaje == null) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Seleccione un tamizaje para ver el gráfico comparativo';
          _chartData = [];
          _years = [];
        });
        return;
      }

      // Determinar si estamos en modo alertas
      final bool mostrarAlertas = filtroNivel != null ||
          filtroSustancia != null ||
          filtroTamizaje != null;

      // Obtener datos de los últimos 5 años
      final currentYear = DateTime.now().year;
      final years =
          List.generate(5, (index) => (currentYear - 4 + index).toString());

      final Map<String, Map<String, int>> yearData = {};

      for (final year in years) {
        yearData[year] = {
          'totalTamizajes': 0,
          'conAlertas': 0,
        };
      }

      if (mostrarAlertas) {
        // MODO ALERTAS - Contar tamizajes con alertas específicas
        await _fetchAlertasData(yearData, filtroColegio, filtroNivel,
            filtroSustancia, filtroTamizaje);
      } else {
        // MODO GENERAL - Contar todos los tamizajes
        await _fetchGeneralData(yearData, filtroColegio);
      }

      // Preparar datos para el gráfico
      _prepareChartData(yearData, years);
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar datos';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _normalizeFilter(String? filter) {
    if (filter == null || filter.trim().isEmpty) return null;
    final normalized = filter.trim().toUpperCase();
    if (normalized == 'TODOS' || normalized == 'TODAS') return null;
    return filter.trim();
  }

  Future<void> _fetchGeneralData(
      Map<String, Map<String, int>> yearData, String? filtroColegio) async {
    // Obtener encuestas publicadas
    Query encuestasQuery = FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .where('Publicado', isEqualTo: true);

    final encuestasSnapshot = await encuestasQuery.get();

    for (final encuestaDoc in encuestasSnapshot.docs) {
      // Obtener respuestas de esta encuesta
      final respuestasSnapshot = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(encuestaDoc.id)
          .collection('Respuestas')
          .get();

      for (final respuestaDoc in respuestasSnapshot.docs) {
        final respuestaData = respuestaDoc.data() as Map<String, dynamic>;
        final userRef = respuestaData['User_respuesta'] as DocumentReference;

        // Obtener datos del usuario
        final userDoc = await userRef.get();
        if (!userDoc.exists) continue;

        final userData = userDoc.data() as Map<String, dynamic>?;
        if (userData == null) continue;

        // Aplicar filtro de colegio
        if (filtroColegio != null) {
          final userColegio = userData['colegio']?.toString() ?? '';
          if (!userColegio
              .toUpperCase()
              .contains(filtroColegio.toUpperCase())) {
            continue;
          }
        }

        // Obtener año de la respuesta
        final timestamp = respuestaDoc['Fecha'] ?? respuestaDoc['Fecha'];
        final DateTime responseDate;

        if (timestamp is Timestamp) {
          responseDate = timestamp.toDate();
        } else if (timestamp is String) {
          responseDate = DateTime.parse(timestamp);
        } else {
          responseDate = DateTime.now();
        }

        final year = responseDate.year.toString();

        if (yearData.containsKey(year)) {
          yearData[year]!['totalTamizajes'] =
              yearData[year]!['totalTamizajes']! + 1;
        }
      }
    }
  }

  Future<void> _fetchAlertasData(
      Map<String, Map<String, int>> yearData,
      String? filtroColegio,
      String? filtroNivel,
      String? filtroSustancia,
      String? filtroTamizaje) async {
    // Obtener encuestas con filtros
    Query encuestasQuery = FirebaseFirestore.instance
        .collection('Encuestas')
        .where('tipo', isEqualTo: 'Tamizajes')
        .where('Publicado', isEqualTo: true);

    if (filtroTamizaje != null) {
      encuestasQuery =
          encuestasQuery.where('titulo', isEqualTo: filtroTamizaje);
    }

    final encuestasSnapshot = await encuestasQuery.get();

    // Conjuntos para usuarios únicos por año
    final Map<String, Set<String>> usuariosTotalesPorYear = {};
    final Map<String, Set<String>> usuariosConAlertasPorYear = {};

    for (final year in yearData.keys) {
      usuariosTotalesPorYear[year] = Set<String>();
      usuariosConAlertasPorYear[year] = Set<String>();
    }

    for (final encuestaDoc in encuestasSnapshot.docs) {
      final encuestaData = encuestaDoc.data() as Map<String, dynamic>;
      final alertasConfig = encuestaData['alertas'] as List<dynamic>? ?? [];

      // Obtener respuestas
      final respuestasSnapshot = await FirebaseFirestore.instance
          .collection('Encuestas')
          .doc(encuestaDoc.id)
          .collection('Respuestas')
          .get();

      for (final respuestaDoc in respuestasSnapshot.docs) {
        final respuestaData = respuestaDoc.data() as Map<String, dynamic>;
        final userRef = respuestaData['User_respuesta'] as DocumentReference;
        final userId = userRef.id;

        // Obtener datos del usuario
        final userDoc = await userRef.get();
        if (!userDoc.exists) continue;

        final userData = userDoc.data() as Map<String, dynamic>?;
        if (userData == null) continue;

        // Aplicar filtro de colegio
        if (filtroColegio != null) {
          final userColegio = userData['colegio']?.toString() ?? '';
          if (!userColegio
              .toUpperCase()
              .contains(filtroColegio.toUpperCase())) {
            continue;
          }
        }

        // Obtener año de la respuesta
        final timestamp = respuestaDoc['Fecha'] ?? respuestaDoc['Fecha'];
        final DateTime responseDate;

        if (timestamp is Timestamp) {
          responseDate = timestamp.toDate();
        } else if (timestamp is String) {
          responseDate = DateTime.parse(timestamp);
        } else {
          responseDate = DateTime.now();
        }

        final year = responseDate.year.toString();
        if (!yearData.containsKey(year)) continue;

        // Agregar a usuarios totales
        usuariosTotalesPorYear[year]!.add(userId);

        // Calcular puntajes y verificar alertas
        final testData = respuestaData['test'] as List<dynamic>? ?? [];
        bool tieneAlerta = false;

        // Calcular puntajes por sustancia
        final Map<String, double> puntajesPorSustancia = {};

        for (final item in testData) {
          final itemMap = item as Map<String, dynamic>;
          if (itemMap['Tipo'] == 'Tamizaje') {
            final pregunta = itemMap['Pregunta']?.toString() ?? '';
            final respuestas =
                itemMap['RespuestaTamizaje'] as List<dynamic>? ?? [];

            if (respuestas.isNotEmpty) {
              final respuesta = respuestas.first as Map<String, dynamic>;
              final valor = (respuesta['valor'] as num?)?.toDouble() ?? 0.0;

              // Identificar sustancia
              final sustancia = _identificarSustancia(pregunta);
              puntajesPorSustancia[sustancia] =
                  (puntajesPorSustancia[sustancia] ?? 0) + valor;
            }
          }
        }

        // Evaluar alertas para cada sustancia
        for (final sustancia in puntajesPorSustancia.keys) {
          // Aplicar filtro de sustancia - usando comparación sin tildes
          if (filtroSustancia != null) {
            final sustanciaSinTildes = _quitarTildes(sustancia.toUpperCase());
            final sustanciaFiltroSinTildes =
                _quitarTildes(filtroSustancia.toUpperCase());

            if (!sustanciaSinTildes.contains(sustanciaFiltroSinTildes)) {
              continue;
            }
          }

          final puntaje = puntajesPorSustancia[sustancia]!;
          final nivel = _evaluarNivelRiesgo(sustancia, puntaje, alertasConfig);

          // Aplicar filtro de nivel
          if (filtroNivel != null && !_coincideNivel(nivel, filtroNivel)) {
            continue;
          }

          // Si pasa todos los filtros, cuenta como alerta
          tieneAlerta = true;
          break; // Solo necesita una alerta que cumpla los filtros
        }

        if (tieneAlerta) {
          usuariosConAlertasPorYear[year]!.add(userId);
        }
      }
    }

    // Actualizar datos finales
    for (final year in yearData.keys) {
      yearData[year]!['totalTamizajes'] = usuariosTotalesPorYear[year]!.length;
      yearData[year]!['conAlertas'] = usuariosConAlertasPorYear[year]!.length;
    }
  }

  String _identificarSustancia(String pregunta) {
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
      String sustancia, double puntaje, List<dynamic> alertasConfig) {
    // Normalizar la sustancia sin tildes para comparación
    final sustanciaSinTildes = _quitarTildes(sustancia);

    for (final alerta in alertasConfig) {
      final alertaMap = alerta as Map<String, dynamic>;
      final alertaSustancia = alertaMap['sustancia']?.toString() ?? '';
      if (alertaSustancia.isEmpty) continue;

      // Normalizar la sustancia de la alerta sin tildes
      final alertaSustanciaSinTildes = _quitarTildes(alertaSustancia);

      // Comparar sustancias sin tildes
      if (alertaSustanciaSinTildes != sustanciaSinTildes) continue;

      final nivel = alertaMap['nivel']?.toString() ?? '';
      final min = (alertaMap['min'] as num?)?.toDouble() ?? 0;
      final max = (alertaMap['max'] as num?)?.toDouble() ?? 0;

      if (max == 0 && puntaje >= min) {
        return _normalizarNivel(nivel);
      }
      if (puntaje >= min && puntaje <= max) {
        return _normalizarNivel(nivel);
      }
    }
    return 'Bajo';
  }

  bool _coincideNivel(String nivel, String filtro) {
    // Normalizar niveles
    final nivelNormalizado = _normalizarNivel(nivel);
    final filtroNormalizado = _normalizarNivel(filtro);
    return nivelNormalizado == filtroNormalizado;
  }

  String _normalizarNivel(String nivel) {
    final nivelUpper = nivel.toUpperCase();
    if (nivelUpper == 'BAJO') return 'Bajo';
    if (nivelUpper == 'MODERADO' || nivelUpper == 'MEDIO') return 'Moderado';
    if (nivelUpper == 'ALTO' || nivelUpper == 'SEVERO') return 'Alto';
    return nivel;
  }

  void _prepareChartData(
      Map<String, Map<String, int>> yearData, List<String> years) {
    _years = years;
    _chartData = [];

    // Crear barras separadas: cada año tendrá 2 posiciones (x, x+1)
    for (int i = 0; i < years.length; i++) {
      final year = years[i];
      final data = yearData[year]!;

      // Posición base para este año (multiplicar por 2 para separar)
      final baseX = i * 2;

      // Barra 1: Total tamizajes (azul)
      _chartData.add(BarChartGroupData(
        x: baseX,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: data['totalTamizajes']!.toDouble(),
            color: Color(0xff045AA4),
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ));

      // Barra 2: Con alertas (rojo)
      _chartData.add(BarChartGroupData(
        x: baseX + 1,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: data['conAlertas']!.toDouble(),
            color: Color(0xffDF2B19),
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ));
    }
  }

  String _getChartTitle() {
    final hasFilters = widget.nivelRiesgo != null ||
        widget.sustancia != null ||
        widget.tamizaje != null;

    if (hasFilters) {
      final parts = ['Tamizajes vs Alertas'];
      if (widget.sustancia != null) parts.add('de ${widget.sustancia}');
      if (widget.nivelRiesgo != null) parts.add('${widget.nivelRiesgo}');
      if (widget.tamizaje != null) parts.add('en ${widget.tamizaje}');
      if (widget.colegio != null) parts.add('- ${widget.colegio}');

      return parts.join(' ');
    } else {
      return widget.colegio != null
          ? 'Tamizajes Respondidos - ${widget.colegio}'
          : 'Total de Tamizajes Respondidos';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Text(
            "Histórico de tamizajes y alertas",
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Outfit',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
          ),
          const SizedBox(height: 8),

          // Leyenda
          Row(
            children: [
              _buildLegendItem(Color(0xff045AA4), 'Total Tamizajes'),
              const SizedBox(width: 16),
              _buildLegendItem(Color(0xffDF2B19), 'Con Alertas'),
            ],
          ),
          const SizedBox(height: 16),

          // Gráfico o estados de carga/error
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _errorMessage.isNotEmpty
                    ? _buildErrorState()
                    : _chartData.isEmpty
                        ? _buildEmptyState()
                        : _buildBarChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Readex Pro',
                fontSize: 12,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _calculateMaxY(),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              // Determinar el año y tipo de barra
              final yearIndex = group.x ~/ 2;
              final isTotal = group.x % 2 == 0;

              if (yearIndex >= 0 && yearIndex < _years.length) {
                final year = _years[yearIndex];
                final value = rod.toY.toInt();
                final label = isTotal ? 'Total Tamizajes' : 'Con Alertas';

                return BarTooltipItem(
                  '$label: $value\n$year',
                  const TextStyle(color: Colors.white, fontSize: 12),
                );
              }
              return null;
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Mostrar el año solo en la primera barra de cada par
                if (value % 2 == 0) {
                  final yearIndex = value ~/ 2;
                  if (yearIndex >= 0 && yearIndex < _years.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _years[yearIndex.toInt()],
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 11,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  }
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
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 11,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                );
              },
              reservedSize: 40,
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _calculateGridInterval(),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: FlutterFlowTheme.of(context).alternate.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
                color: FlutterFlowTheme.of(context).alternate, width: 1),
            left: BorderSide(
                color: FlutterFlowTheme.of(context).alternate, width: 1),
          ),
        ),
        barGroups: _chartData,
      ),
    );
  }

  double _calculateMaxY() {
    double max = 0;
    for (final group in _chartData) {
      for (final rod in group.barRods) {
        if (rod.toY > max) max = rod.toY;
      }
    }
    return max * 1.2; // Agregar 20% de espacio
  }

  double _calculateGridInterval() {
    final maxY = _calculateMaxY();
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    return 50;
  }

  Widget _buildLoadingState() {
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

  Widget _buildErrorState() {
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
            _errorMessage,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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
            'No se encontraron datos con los filtros aplicados.',
            style: FlutterFlowTheme.of(context).bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
