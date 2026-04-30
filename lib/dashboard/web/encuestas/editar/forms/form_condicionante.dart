import 'package:flutter/material.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/form_field_controller.dart';

import '../editar_encuesta_model.dart';
import 'form_sustancias.dart' show kSustanciasOptions;

/// Condicionante question: each option has a label and an optional
/// substance that will be triggered if the respondent picks that option.
class FormCondicionante extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormCondicionante({
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
            Expanded(
              child: TextFormField(
                controller: model.condicionanteEtiquetaController,
                focusNode: model.condicionanteEtiquetaFocus,
                decoration: const InputDecoration(
                  hintText: 'Etiqueta (ej. Sí, fumo)',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            FlutterFlowDropDown<String>(
              textStyle: FlutterFlowTheme.of(context).bodyMedium,
              controller: model.condicionanteSustanciaController ??=
                  FormFieldController<String>(null),
              options: kSustanciasOptions,
              onChanged: (val) {
                model.condicionanteSustanciaValue = val;
                onUpdate();
              },
              width: 180,
              height: 40,
              hintText: 'Sustancia',
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
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF265294)),
              onPressed: () {
                final etiqueta =
                    model.condicionanteEtiquetaController.text.trim();
                if (etiqueta.isEmpty) return;
                model.addToRespuestaCondicionante(
                  ValorCondicionanteStruct(
                    etiqueta: etiqueta,
                    sustanciaValor:
                        model.condicionanteSustanciaValue ?? '',
                  ),
                );
                model.condicionanteEtiquetaController.clear();
                onUpdate();
              },
            ),
          ],
        ),
        if (model.respuestaCondicionante.isNotEmpty)
          Column(
            children: model.respuestaCondicionante
                .map(
                  (rc) => ListTile(
                    dense: true,
                    title: Text('${rc.etiqueta} → ${rc.sustanciaValor}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        model.removeFromRespuestaCondicionante(rc);
                        onUpdate();
                      },
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
