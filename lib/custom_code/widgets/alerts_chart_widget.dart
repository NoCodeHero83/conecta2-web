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

class AlertsChartWidget extends StatefulWidget {
  const AlertsChartWidget({
    Key? key,
    this.width,
    this.height,
    this.colegio,
    this.nivelRiesgo,
    this.sustancia,
    this.tamizaje,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? colegio;
  final String? nivelRiesgo;
  final String? sustancia;
  final String? tamizaje;

  @override
  State<AlertsChartWidget> createState() => _AlertsChartWidgetState();
}

class _AlertsChartWidgetState extends State<AlertsChartWidget> {
  bool isLoading = true;
  bool mostrarGrafico = true;
  int totalUsuarios = 0;
  int usuariosConAlertas = 0;
  int usuariosSinAlertas = 0;
  double porcentajeAfectados = 0.0;
  double porcentajeResilientes = 0.0;

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  @override
  void didUpdateWidget(AlertsChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colegio != widget.colegio ||
        oldWidget.nivelRiesgo != widget.nivelRiesgo ||
        oldWidget.sustancia != widget.sustancia ||
        oldWidget.tamizaje != widget.tamizaje) {
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
      mostrarGrafico = true;
    });

    try {
      // Normalizar filtros
      final filtroColegio = _normalizeFilter(widget.colegio);
      final filtroNivel = _normalizeFilter(widget.nivelRiesgo);
      final filtroSustancia = _normalizeFilter(widget.sustancia);
      final filtroTamizaje = _normalizeFilter(widget.tamizaje);

      debugPrint('=== FILTROS PORCENTAJE ALERTAS ===');
      debugPrint('Colegio: ${filtroColegio ?? "TODOS"}');
      debugPrint('Nivel: ${filtroNivel ?? "TODOS"}');
      debugPrint('Sustancia: ${filtroSustancia ?? "TODAS"}');
      debugPrint('Tamizaje: ${filtroTamizaje ?? "TODOS"}');

      // VALIDACIÓN: Si no hay tamizaje específico, no mostrar gráfico
      if (filtroTamizaje == null) {
        debugPrint('⚠️ No hay tamizaje específico - No se muestra gráfico');
        setState(() {
          mostrarGrafico = false;
          isLoading = false;
        });
        return;
      }

      // Sets para usuarios únicos
      Set<String> todosLosUsuarios = {};
      Set<String> usuariosConAlertasFiltradas = {};

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

            final userId = userDoc.id;

            // Aplicar filtro de colegio
            if (filtroColegio != null) {
              final userColegio = userData['colegio']?.toString() ?? '';
              if (!userColegio
                  .toUpperCase()
                  .contains(filtroColegio.toUpperCase())) {
                continue;
              }
            }

            // Agregar a todos los usuarios que respondieron (después de filtro de colegio)
            todosLosUsuarios.add(userId);

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

            // Evaluar cada sustancia contra las alertas
            bool usuarioTieneAlertaFiltrada = false;

            for (var sustanciaItem in puntajesPorSustancia.keys) {
              // Aplicar filtro de sustancia
              if (filtroSustancia != null &&
                  !sustanciaItem
                      .toUpperCase()
                      .contains(filtroSustancia.toUpperCase())) {
                continue;
              }

              final puntaje = puntajesPorSustancia[sustanciaItem] ?? 0.0;
              final nivel =
                  _evaluarNivelRiesgo(sustanciaItem, puntaje, alertas);

              // Aplicar filtro de nivel de riesgo
              if (filtroNivel != null &&
                  nivel.toUpperCase() != filtroNivel.toUpperCase()) {
                continue;
              }

              // Si llegó aquí y el nivel NO es 'Bajo', tiene una alerta que cumple los filtros
              if (nivel != 'Bajo') {
                usuarioTieneAlertaFiltrada = true;
                break;
              }
            }

            if (usuarioTieneAlertaFiltrada) {
              usuariosConAlertasFiltradas.add(userId);
            }
          } catch (e) {
            debugPrint('Error procesando respuesta: $e');
            continue;
          }
        }
      }

      // Calcular resultados
      totalUsuarios = todosLosUsuarios.length;
      usuariosConAlertas = usuariosConAlertasFiltradas.length;
      usuariosSinAlertas = totalUsuarios - usuariosConAlertas;

      debugPrint('=== RESULTADO PORCENTAJE ===');
      debugPrint('Total usuarios: $totalUsuarios');
      debugPrint('Con alertas: $usuariosConAlertas');
      debugPrint('Sin alertas: $usuariosSinAlertas');

      if (totalUsuarios > 0) {
        porcentajeAfectados = (usuariosConAlertas / totalUsuarios) * 100;
        porcentajeResilientes = (usuariosSinAlertas / totalUsuarios) * 100;
      } else {
        porcentajeAfectados = 0.0;
        porcentajeResilientes = 0.0;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error en fetchChartData: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String _extraerSustancia(String pregunta) {
    final preguntaLower = pregunta.toLowerCase();

    if (preguntaLower.contains('tabaco')) return 'Tabaco';
    if (preguntaLower.contains('alcohol') || preguntaLower.contains('bebidas'))
      return 'Bebidas alcoholicas';
    if (preguntaLower.contains('cannabis') ||
        preguntaLower.contains('marihuana')) return 'Cannabis';
    if (preguntaLower.contains('cocaina') || preguntaLower.contains('coca'))
      return 'Cocaina';
    if (preguntaLower.contains('anfetamina') ||
        preguntaLower.contains('estimulante')) return 'Anfetaminas';
    if (preguntaLower.contains('inhalante')) return 'Inhalantes';
    if (preguntaLower.contains('tranquilizante')) return 'Tranquilizantes';
    if (preguntaLower.contains('alucinogeno')) return 'Alucinogenos';
    if (preguntaLower.contains('opiaceo') || preguntaLower.contains('heroina'))
      return 'Opiaceos';

    return 'Otros';
  }

  String _evaluarNivelRiesgo(
      String sustancia, double puntaje, List<dynamic> alertas) {
    for (var alerta in alertas) {
      if (alerta is! Map<String, dynamic>) continue;

      final alertaSustancia = alerta['sustancia']?.toString() ?? '';
      if (alertaSustancia != sustancia) continue;

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

    if (widget.nivelRiesgo != null &&
        widget.nivelRiesgo!.trim().isNotEmpty &&
        !['TODOS', 'TODAS', 'TODO', 'TODA']
            .contains(widget.nivelRiesgo!.trim().toUpperCase())) {
      filtrosActivos.add('Riesgo ${widget.nivelRiesgo}');
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

    String titulo = 'PORCENTAJE DE POBLACIÓN CON ALERTAS';
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
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Si no debe mostrar gráfico (sin tamizaje específico)
    if (!mostrarGrafico) {
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
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Seleccione un tamizaje específico\npara ver el gráfico de porcentaje',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (totalUsuarios == 0) {
      return Container(
        width: widget.width ?? 400,
        height: widget.height ?? 400,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'No hay datos disponibles',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
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
                Icons.pie_chart_outline,
                color: Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _buildTitle(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
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
            spacing: 20,
            runSpacing: 10,
            children: [
              // Población Afectada
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xffDF2B19), // Rojo
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Con Alertas ${porcentajeAfectados.toStringAsFixed(1)}% ($usuariosConAlertas)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              // Población Resiliente
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Color(0xff045AA4), // Azul
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Sin Alertas ${porcentajeResilientes.toStringAsFixed(1)}% ($usuariosSinAlertas)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Total
          Text(
            'Total: $totalUsuarios usuarios',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
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
                  sectionsSpace: 0,
                  centerSpaceRadius: 80,
                  startDegreeOffset: 270, // Comenzar desde arriba
                  sections: [
                    PieChartSectionData(
                      value: porcentajeAfectados,
                      color: const Color(0xffDF2B19), // Rojo
                      radius: 50,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: porcentajeResilientes,
                      color: const Color(0xff045AA4), // Azul
                      radius: 50,
                      showTitle: false,
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
