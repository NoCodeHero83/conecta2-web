import 'package:flutter/material.dart';

import '../editar_encuesta_model.dart';

/// True / False question. Only one option may be "correct" at a time.
class FormVerdaderoFalso extends StatelessWidget {
  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  const FormVerdaderoFalso({
    super.key,
    required this.model,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: model.vfVerdadero,
          onChanged: (val) {
            model.vfVerdadero = val ?? false;
            if (model.vfVerdadero) model.vfFalso = false;
            onUpdate();
          },
        ),
        const Text('Verdadero'),
        const SizedBox(width: 20),
        Checkbox(
          value: model.vfFalso,
          onChanged: (val) {
            model.vfFalso = val ?? false;
            if (model.vfFalso) model.vfVerdadero = false;
            onUpdate();
          },
        ),
        const Text('Falso'),
      ],
    );
  }
}
