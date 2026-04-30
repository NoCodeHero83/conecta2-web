import 'package:flutter/material.dart';

import '../editar_encuesta_model.dart';

/// Descriptiva: a read-only informational block inside a survey. The editor
/// writes the text that the respondent will see; there is no answer.
class FormDescriptiva extends StatelessWidget {
  final EditarEncuestaModel model;

  const FormDescriptiva({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: model.abiertaController,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Escribe aquí el texto informativo o descriptivo...',
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
