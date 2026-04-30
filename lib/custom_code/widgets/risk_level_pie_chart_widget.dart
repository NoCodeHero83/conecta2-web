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

class RiskLevelPieChartWidget extends StatefulWidget {
  const RiskLevelPieChartWidget({
    Key? key,
    this.width,
    this.height,
    this.colegio,
    this.sustancia,
    this.tamizaje,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? colegio;
  final String? sustancia;
  final String? tamizaje;

  @override
  State<RiskLevelPieChartWidget> createState() =>
      _RiskLevelPieChartWidgetState();
}

class _RiskLevelPieChartWidgetState extends State<RiskLevelPieChartWidget> {
  bool isLoading = true;
  String errorMessage = '';
  int totalAlertas = 0;
  int alertasBajo = 0;
  int alertasModerado = 0;
  int alertasAlto = 0;
  double porcentajeBajo = 0.0;
  double porcentajeModerado = 0.0;
  double porcentajeAlto = 0.0;

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
  void didUpdateWidget(RiskLevelPieChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colegio != widget.colegio ||
        oldWidget.sustancia != widget.sustancia ||
        oldWidget.tamizaje != widget.tamizaje) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      fetchChartData();
    }
  }

  // Normalizar filtros
  String? _normalizeFilter(String? filter) {
    if (filter == null || filter.trim().isEmpty) return null;
    final normalized = filter.trim().toUpperCase();
    if (normalized == 'TODOS' || normalized == 'TODAS') return null;
    return filter.trim();
  }

  Future<void> fetchChartData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Normalizar filtros
      final filtroColegio = _normalizeFilter(widget.colegio);
      final filtroSustancia = _normalizeFilter(widget.sustancia);
      final filtroTamizaje = _normalizeFilter(widget.tamizaje);

      debugPrint('=== FILTROS PIE CHART (ALERTAS) ===');
      debugPrint('Colegio: ${filtroColegio ?? "TODOS"}');
      debugPrint('Sustancia: ${filtroSustancia ?? "TODAS"}');
      debugPrint('Tamizaje: ${filtroTamizaje ?? "TODOS"}');

      // VALIDACIÓN: Si no hay tamizaje específico seleccionado
      if (filtroTamizaje == null) {
        setState(() {
          isLoading = false;
          errorMessage =
              'Seleccione un tamizaje para ver el gráfico de niveles de riesgo';
          totalAlertas = 0;
          alertasBajo = 0;
          alertasModerado = 0;
          alertasAlto = 0;
          porcentajeBajo = 0.0;
          porcentajeModerado = 0.0;
          porcentajeAlto = 0.0;
        });
        return;
      }

      // Contadores para cada nivel - CONTAR ALERTAS, NO USUARIOS
      int contadorBajo = 0;
      int contadorModerado = 0;
      int contadorAlto = 0;

      // Obtener encuestas
      Query encuestasQuery = FirebaseFirestore.instance
          .collection('Encuestas')
          .where('tipo', isEqualTo: 'Tamizajes')
          .where('Publicado', isEqualTo: true);

      if (filtroTamizaje != null) {
        encuestasQuery =
            encuestasQuery.where('titulo', isEqualTo: filtroTamizaje);
      }

      final encuestasSnapshot = await encuestasQuery.get();

      debugPrint(
          'Total encuestas encontradas: ${encuestasSnapshot.docs.length}');

      for (var encuestaDoc in encuestasSnapshot.docs) {
        final encuestaData = encuestaDoc.data() as Map<String, dynamic>;
        final alertas = encuestaData['alertas'] as List<dynamic>? ?? [];

        // Obtener respuestas de esta encuesta
        final respuestasSnapshot = await FirebaseFirestore.instance
            .collection('Encuestas')
            .doc(encuestaDoc.id)
            .collection('Respuestas')
            .get();

        for (var respuestaDoc in respuestasSnapshot.docs) {
          try {
            final respuestaData = respuestaDoc.data();
            final userRef =
                respuestaData['User_respuesta'] as DocumentReference?;

            if (userRef == null) continue;

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

            // Calcular puntajes por sustancia
            final test = respuestaData['test'] as List<dynamic>? ?? [];
            Map<String, double> puntajesPorSustancia = {};

            for (var item in test) {
              if (item is! Map<String, dynamic>) continue;

              final tipo = item['Tipo'] as String?;
              if (tipo != 'Tamizaje') continue;

              final pregunta = item['Pregunta']?.toString() ?? '';
              final sustanciaItem = _extraerSustancia(pregunta);

              final respuestaTamizaje =
                  item['RespuestaTamizaje'] as List<dynamic>? ?? [];
              if (respuestaTamizaje.isNotEmpty) {
                final valor = respuestaTamizaje[0]['valor'];
                final valorDouble = (valor is int)
                    ? valor.toDouble()
                    : (valor as double? ?? 0.0);
                puntajesPorSustancia[sustanciaItem] =
                    (puntajesPorSustancia[sustanciaItem] ?? 0.0) + valorDouble;
              }
            }

            // Evaluar cada sustancia contra las alertas y CONTAR CADA ALERTA
            for (var sustanciaItem in puntajesPorSustancia.keys) {
              // Aplicar filtro de sustancia - usando comparación sin tildes
              if (filtroSustancia != null) {
                final sustanciaItemSinTildes =
                    _quitarTildes(sustanciaItem.toUpperCase());
                final sustanciaFiltroSinTildes =
                    _quitarTildes(filtroSustancia.toUpperCase());

                if (!sustanciaItemSinTildes
                    .contains(sustanciaFiltroSinTildes)) {
                  continue;
                }
              }

              final puntaje = puntajesPorSustancia[sustanciaItem] ?? 0.0;

              // Determinar nivel de riesgo para esta combinación usuario-sustancia
              final nivel =
                  _evaluarNivelRiesgo(sustanciaItem, puntaje, alertas);

              // Contar la alerta según su nivel
              if (nivel == 'Bajo') {
                contadorBajo++;
              } else if (nivel == 'Moderado') {
                contadorModerado++;
              } else if (nivel == 'Alto') {
                contadorAlto++;
              }
            }
          } catch (e) {
            debugPrint('Error procesando respuesta: $e');
            continue;
          }
        }
      }

      // Calcular totales
      alertasBajo = contadorBajo;
      alertasModerado = contadorModerado;
      alertasAlto = contadorAlto;
      totalAlertas = alertasBajo + alertasModerado + alertasAlto;

      debugPrint('=== RESULTADO PIE CHART ===');
      debugPrint('Bajo: $alertasBajo');
      debugPrint('Moderado: $alertasModerado');
      debugPrint('Alto: $alertasAlto');
      debugPrint('Total: $totalAlertas');

      // Calcular porcentajes
      if (totalAlertas > 0) {
        porcentajeBajo = (alertasBajo / totalAlertas) * 100;
        porcentajeModerado = (alertasModerado / totalAlertas) * 100;
        porcentajeAlto = (alertasAlto / totalAlertas) * 100;
      } else {
        porcentajeBajo = 0.0;
        porcentajeModerado = 0.0;
        porcentajeAlto = 0.0;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error en fetchChartData: $e');
      setState(() {
        errorMessage = 'Error al cargar datos';
        isLoading = false;
      });
    }
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

      final alertaSustancia = alerta['sustancia']?.toString() ?? '';
      if (alertaSustancia.isEmpty) continue;

      // Normalizar la sustancia de la alerta sin tildes
      final alertaSustanciaSinTildes = _quitarTildes(alertaSustancia);

      // Comparar sustancias sin tildes
      if (alertaSustanciaSinTildes != sustanciaSinTildes) continue;

      final alertaNivel = alerta['nivel']?.toString() ?? '';
      final minValue = (alerta['min'] is int)
          ? (alerta['min'] as int).toDouble()
          : (alerta['min'] as double? ?? 0.0);
      final maxValue = (alerta['max'] is int)
          ? (alerta['max'] as int).toDouble()
          : (alerta['max'] as double? ?? 0.0);

      bool cumpleRango = false;
      if (maxValue == 0 && puntaje >= minValue) {
        cumpleRango = true;
      } else if (puntaje >= minValue && puntaje <= maxValue) {
        cumpleRango = true;
      }

      if (cumpleRango) {
        return _normalizarNivel(alertaNivel);
      }
    }

    return 'Bajo';
  }

  String _normalizarNivel(String nivel) {
    final nivelUpper = nivel.toUpperCase();
    if (nivelUpper == 'BAJO') return 'Bajo';
    if (nivelUpper == 'MODERADO' || nivelUpper == 'MEDIO') return 'Moderado';
    if (nivelUpper == 'ALTO' || nivelUpper == 'SEVERO') return 'Alto';
    return nivel;
  }

  String _buildTitle() {
    List<String> filtrosActivos = [];

    if (widget.colegio != null &&
        widget.colegio!.trim().isNotEmpty &&
        !['TODOS', 'TODAS', 'TODO', 'TODA']
            .contains(widget.colegio!.trim().toUpperCase())) {
      filtrosActivos.add(widget.colegio!);
    }

    if (widget.sustancia != null &&
        widget.sustancia!.trim().isNotEmpty &&
        !['TODOS', 'TODAS', 'TODO', 'TODA']
            .contains(widget.sustancia!.trim().toUpperCase())) {
      filtrosActivos.add(widget.sustancia!);
    }

    if (widget.tamizaje != null &&
        widget.tamizaje!.trim().isNotEmpty &&
        !['TODOS', 'TODAS', 'TODO', 'TODA']
            .contains(widget.tamizaje!.trim().toUpperCase())) {
      filtrosActivos.add(widget.tamizaje!);
    }

    String titulo = 'DISTRIBUCIÓN DE ALERTAS POR NIVEL DE RIESGO';
    if (filtrosActivos.isNotEmpty) {
      titulo += ' - ${filtrosActivos.join(' • ')}';
    }

    return titulo;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: widget.width ?? 400,
        height: widget.height ?? 400,
        padding: const EdgeInsets.all(20),
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
        width: widget.width ?? 400,
        height: widget.height ?? 400,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pie_chart,
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

    if (totalAlertas == 0) {
      return Container(
        width: widget.width ?? 400,
        height: widget.height ?? 400,
        padding: const EdgeInsets.all(20),
        child: Center(
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
        ),
      );
    }

    return Container(
      width: widget.width ?? 400,
      height: widget.height ?? 400,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título dinámico
          Row(
            children: [
              Icon(
                Icons.pie_chart_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _buildTitle(),
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
          const SizedBox(height: 20),

          // Leyenda
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 15,
            runSpacing: 10,
            children: [
              // Riesgo Bajo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xff045AA4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Bajo ${porcentajeBajo.toStringAsFixed(1)}% ($alertasBajo)',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ],
              ),
              // Riesgo Moderado
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7B900),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Moderado ${porcentajeModerado.toStringAsFixed(1)}% ($alertasModerado)',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ],
              ),
              // Riesgo Alto
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xffDF2B19),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Alto ${porcentajeAlto.toStringAsFixed(1)}% ($alertasAlto)',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Total de alertas
          Text(
            'Total: $totalAlertas alertas',
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 20),

          // Gráfico
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 70,
                  startDegreeOffset: 270, // Comenzar desde arriba
                  sections: [
                    // Bajo
                    if (porcentajeBajo > 0)
                      PieChartSectionData(
                        value: porcentajeBajo,
                        color: const Color(0xff045AA4),
                        radius: 55,
                        title: '${porcentajeBajo.toStringAsFixed(1)}%',
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    // Moderado
                    if (porcentajeModerado > 0)
                      PieChartSectionData(
                        value: porcentajeModerado,
                        color: const Color(0xffF7B900),
                        radius: 55,
                        title: '${porcentajeModerado.toStringAsFixed(1)}%',
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    // Alto
                    if (porcentajeAlto > 0)
                      PieChartSectionData(
                        value: porcentajeAlto,
                        color: const Color(0xffDF2B19),
                        radius: 55,
                        title: '${porcentajeAlto.toStringAsFixed(1)}%',
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                  ],
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
