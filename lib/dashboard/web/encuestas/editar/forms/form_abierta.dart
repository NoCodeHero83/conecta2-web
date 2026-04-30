import 'package:flutter/material.dart';

import '../editar_encuesta_model.dart';

/// Preview-only input for questions with tipo `abiertas`.
/// The respondent will write a free answer when the survey is taken;
/// here we just show a placeholder so the editor can see the layout.
class FormAbierta extends StatelessWidget {
  final EditarEncuestaModel model;

  const FormAbierta({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: model.abiertaController,
      focusNode: model.abiertaFocus,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Escribe aquí la respuesta (solo vista previa)',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
