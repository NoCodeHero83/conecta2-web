import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/form_field_controller.dart';

import '../editar_encuesta_model.dart';
import 'form_tamizaje.dart';

const List<String> kSustanciasOptions = [
  'Tabaco',
  'Bebidas alcohólicas',
  'Cannabis',
  'Anfetaminas',
  'Inhalantes',
  'Tranquilizantes',
  'Alucinógenos',
  'Opiáceos',
  'Otros',
  'Cocaina',
];

/// Form for `Tamizaje (Sustancias)`. Requires the user to choose a substance
/// and then provide the (etiqueta, valor) table shared with autoestima.
class FormSustancias extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormSustancias({
    super.key,
    required this.model,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text('Sustancia: ',
                style: FlutterFlowTheme.of(context).bodyMedium),
            FlutterFlowDropDown<String>(
              textStyle: FlutterFlowTheme.of(context).bodyMedium,
              controller: model.sustanciaController ??=
                  FormFieldController<String>(null),
              options: kSustanciasOptions,
              onChanged: (val) {
                model.sustanciaValue = val;
                onUpdate();
              },
              width: 200,
              height: 40,
              hintText: 'Seleccione',
              fillColor: Colors.white,
              elevation: 2.0,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 8,
              margin:
                  const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
              hidesUnderline: true,
              isSearchable: false,
              isMultiSelect: false,
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Reuse the autoestima-style etiqueta/valor table.
        FormTamizajeAutoestima(model: model, onUpdate: onUpdate),
      ],
    );
  }
}
