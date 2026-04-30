import 'package:flutter/material.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/form_field_controller.dart';

import '../editar_encuesta_model.dart';

/// Generic "(etiqueta, valor)" capture used by Tamizaje and Tamizaje autoestima.
class FormTamizajeAutoestima extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormTamizajeAutoestima({
    super.key,
    required this.model,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: model.tamizajeEtiquetaController,
                focusNode: model.tamizajeEtiquetaFocus,
                decoration: const InputDecoration(
                  hintText: 'Etiqueta (ej. Muy en desacuerdo)',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: model.tamizajeValorController,
                focusNode: model.tamizajeValorFocus,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Puntaje',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF265294)),
              onPressed: () {
                final etiqueta =
                    model.tamizajeEtiquetaController.text.trim();
                if (etiqueta.isEmpty) return;
                model.addToRespuestaTamizaje(AtributosStruct(
                  etiqueta: etiqueta,
                  valor: int.tryParse(model.tamizajeValorController.text) ?? 0,
                ));
                model.tamizajeEtiquetaController.clear();
                model.tamizajeValorController.clear();
                onUpdate();
              },
            ),
          ],
        ),
        if (model.respuestaTamizaje.isNotEmpty)
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              final item =
                  model.respuestaTamizaje.removeAt(oldIndex);
              model.respuestaTamizaje.insert(newIndex, item);
              for (var i = 0;
                  i < model.respuestaTamizaje.length;
                  i++) {
                model.respuestaTamizaje[i].orden = i;
              }
              onUpdate();
            },
            children: model.respuestaTamizaje
                .asMap()
                .entries
                .map((e) => ListTile(
                      key: ValueKey(e.key),
                      dense: true,
                      leading: const Icon(Icons.drag_handle,
                          color: Colors.grey, size: 18),
                      title: Text(
                          '${e.key + 1}. ${e.value.etiqueta} (${e.value.valor})'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red),
                        onPressed: () {
                          model.removeAtIndexFromRespuestaTamizaje(
                              e.key);
                          for (var i = 0;
                              i < model.respuestaTamizaje.length;
                              i++) {
                            model.respuestaTamizaje[i].orden = i;
                          }
                          onUpdate();
                        },
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

/// CDI / Beck style form: adds a "variable" dropdown and an "ideación suicida"
/// checkbox for each added option.
class FormTamizajeCDI extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormTamizajeCDI({
    super.key,
    required this.model,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Variable: '),
            const SizedBox(width: 10),
            FlutterFlowDropDown<String>(
              textStyle: FlutterFlowTheme.of(context).bodyMedium,
              controller: model.variableCDIController ??=
                  FormFieldController<String>(null),
              options: model.tipoValue == 'Tamizaje CDI'
                  ? const ['Disforia', 'Autoestima Negativa']
                  : const ['Cognitivo', 'Afectivo', 'Somático'],
              onChanged: (val) {
                model.variableCDIValue = val;
                onUpdate();
              },
              width: 180,
              height: 40,
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: model.cdiEtiquetaController,
                focusNode: model.cdiEtiquetaFocus,
                decoration: const InputDecoration(
                  hintText: 'Opciones de respuesta',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 80,
              child: TextFormField(
                controller: model.cdiValorController,
                focusNode: model.cdiValorFocus,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Puntaje',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Checkbox(
              value: model.ideacionSuicidaValue,
              onChanged: (val) {
                model.ideacionSuicidaValue = val ?? false;
                onUpdate();
              },
            ),
            const Text('IS',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF265294)),
              onPressed: () {
                final etiqueta = model.cdiEtiquetaController.text.trim();
                if (etiqueta.isEmpty) return;
                model.addToRespuestaCDI(AtributosStruct(
                  etiqueta: etiqueta,
                  valor: int.tryParse(model.cdiValorController.text) ?? 0,
                  ideacionSuicida: model.ideacionSuicidaValue,
                ));
                model.cdiEtiquetaController.clear();
                model.cdiValorController.clear();
                model.ideacionSuicidaValue = false;
                onUpdate();
              },
            ),
          ],
        ),
        if (model.respuestaCDI.isNotEmpty)
          Column(
            children: model.respuestaCDI.asMap().entries.map((e) {
              final suffix = e.value.ideacionSuicida ? ' [IS]' : '';
              return ListTile(
                dense: true,
                title: Text(
                    '${e.key + 1}. ${e.value.etiqueta} (${e.value.valor})$suffix'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    model.removeAtIndexFromRespuestaCDI(e.key);
                    onUpdate();
                  },
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

/// CRQ / SRQ form: a Yes/No question where each answer has its own puntaje
/// and the original question number is preserved.
class FormTamizajeCRQ extends StatelessWidget {
  final EditarEncuestaModel model;

  const FormTamizajeCRQ({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: model.crqNumeroPreguntaController,
          focusNode: model.crqNumeroPreguntaFocus,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Número de pregunta original (ej. 17)',
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: model.crqSiScoreController,
                focusNode: model.crqSiScoreFocus,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Puntaje SI',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: model.crqNoScoreController,
                focusNode: model.crqNoScoreFocus,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Puntaje NO',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
