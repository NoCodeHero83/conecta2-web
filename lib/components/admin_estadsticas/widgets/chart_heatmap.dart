import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import '../../admin_estadsticas2_model.dart';

/// Shows the combined risk-level pie chart and the comparative bar chart.
class ChartHeatmap extends StatelessWidget {
  const ChartHeatmap({super.key, required this.model});

  final AdminEstadsticas2Model model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.3,
                height: 450.0,
                child: custom_widgets.RiskLevelPieChartWidget(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: 450.0,
                  colegio: model.textFieldColegioValue,
                  sustancia: model.dropDownSustanciaValue,
                  tamizaje: model.dropDownTamizajValue,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: 450.0,
                child: custom_widgets.ComparativeBarChartWidget(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  height: 450.0,
                  colegio: model.textFieldColegioValue,
                  nivelRiesgo: model.dropDownNivelValue,
                  sustancia: model.dropDownSustanciaValue,
                  tamizaje: model.dropDownTamizajValue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
