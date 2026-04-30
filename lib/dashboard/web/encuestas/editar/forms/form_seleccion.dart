import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/form_field_controller.dart';

import '../editar_encuesta_model.dart';

/// Multi-option selection (tipo `selección`).
/// The editor adds options one by one; all options are stored in
/// [EditarEncuestaModel.respuestaSelection].
class FormSeleccion extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormSeleccion({
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
                controller: model.seleccionOpcionController,
                focusNode: model.seleccionOpcionFocus,
                decoration: const InputDecoration(
                  hintText: 'Agregar opción...',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF265294)),
              onPressed: () {
                final text = model.seleccionOpcionController.text.trim();
                if (text.isEmpty) return;
                model.addToRespuestaSelection(text);
                model.seleccionOpcionController.clear();
                onUpdate();
              },
            ),
          ],
        ),
        if (model.respuestaSelection.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: model.respuestaSelection
                  .map(
                    (s) => Chip(
                      label: Text(s),
                      onDeleted: () {
                        model.removeFromRespuestaSelection(s);
                        onUpdate();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}

/// Single-choice selection (tipo `Selección única`).
/// User adds options, then picks the one that is the "correct" answer.
class FormSeleccionUnica extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormSeleccionUnica({
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
                controller: model.seleccionUnicaController,
                focusNode: model.seleccionUnicaFocus,
                decoration: const InputDecoration(
                  hintText: 'Agregar opción...',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF265294)),
              onPressed: () {
                final text = model.seleccionUnicaController.text.trim();
                if (text.isEmpty) return;
                model.addToSeleccionUnica(text);
                model.seleccionUnicaController.clear();
                onUpdate();
              },
            ),
          ],
        ),
        if (model.seleccionUnica.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FlutterFlowRadioButton(
              options: model.seleccionUnica.toList(),
              onChanged: (val) {
                model.seleccionUnicaCorrectaValue = val;
                onUpdate();
              },
              controller: model.seleccionUnicaCorrectaController ??=
                  FormFieldController<String>(null),
              optionHeight: 32.0,
              textStyle: FlutterFlowTheme.of(context).bodyMedium,
              radioButtonColor: const Color(0xFF265294),
              inactiveRadioButtonColor: Colors.grey,
              toggleable: false,
              horizontalAlignment: WrapAlignment.start,
              verticalAlignment: WrapCrossAlignment.start,
            ),
          ),
      ],
    );
  }
}
