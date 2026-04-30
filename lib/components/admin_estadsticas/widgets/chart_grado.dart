import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import '../../admin_estadsticas2_model.dart';

/// Row with the sex/age pyramid next to the grado bar chart.
class ChartGrado extends StatelessWidget {
  const ChartGrado({super.key, required this.model});

  final AdminEstadsticas2Model model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.3,
            height: 450.0,
            child: custom_widgets.PyramidChartSexoEdadWidget(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: 450.0,
              colegio: model.textFieldColegioValue,
              nivelRiesgo: model.dropDownNivelValue,
              sustancia: model.dropDownSustanciaValue,
              tamizaje: model.dropDownTamizajValue,
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.35,
            height: 450.0,
            child: custom_widgets.HorizontalBarChartGradoWidget(
              width: MediaQuery.sizeOf(context).width * 0.35,
              height: 450.0,
              colegio: model.textFieldColegioValue,
              nivelRiesgo: model.dropDownNivelValue,
              sustancia: model.dropDownSustanciaValue,
              tamizaje: model.dropDownTamizajValue,
            ),
          ),
        ],
      ),
    );
  }
}
