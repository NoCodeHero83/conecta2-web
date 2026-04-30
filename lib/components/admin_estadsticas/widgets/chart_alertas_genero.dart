import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import '../../admin_estadsticas2_model.dart';

/// Two-column row showing alerts distribution by gender (AlertsChart) next
/// to alerts by age (AgeAlertsChart).
class ChartAlertasGenero extends StatelessWidget {
  const ChartAlertasGenero({super.key, required this.model});

  final AdminEstadsticas2Model model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AuthUserStreamWidget(
            builder: (context) => Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: 450.0,
              child: custom_widgets.AlertsChartWidget(
                width: MediaQuery.sizeOf(context).width * 0.3,
                height: 450.0,
                colegio: valueOrDefault(currentUserDocument?.colegio, ''),
                nivelRiesgo: model.dropDownNivelValue,
                sustancia: model.dropDownSustanciaValue,
                tamizaje: model.dropDownTamizajValue,
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.3,
            height: 450.0,
            child: custom_widgets.AgeAlertsChartWidget(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: 450.0,
              colegio: model.filtroColegio,
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
