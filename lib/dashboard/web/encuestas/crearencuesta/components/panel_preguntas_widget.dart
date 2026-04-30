import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '../crearencuesta_model.dart';
import '../pregunta_card_widget.dart';
import '/dashboard/web/encuestas/model/emptytest/emptytest_widget.dart';

class PanelPreguntasWidget extends StatelessWidget {
  final CrearencuestaModel model;
  final VoidCallback onUpdate;

  const PanelPreguntasWidget({
    super.key,
    required this.model,
    required this.onUpdate,
  });

  // EncuestasRecord vacío usado solo como placeholder para la firma requerida
  // de `PreguntaCard`. El delete pasa por `onDelete` y nunca toca este record.
  EncuestasRecord get _placeholderRecord => EncuestasRecord.getDocumentFromData(
        createEncuestasRecordData(),
        EncuestasRecord.collection.doc('__buffer__'),
      );

  @override
  Widget build(BuildContext context) {
    final preguntas = model.preguntasBuffer;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPreguntasList(preguntas),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreguntasList(List<PreguntasEncuestaStruct> preguntas) {
    if (preguntas.isEmpty) {
      return const Center(child: EmptytestWidget());
    }
    final placeholder = _placeholderRecord;
    return ListView.builder(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      itemCount: preguntas.length,
      itemBuilder: (context, index) {
        return PreguntaCard(
          pregunta: preguntas[index],
          encuestasRecord: placeholder,
          index: index,
          onDelete: () {
            model.removeAtIndexFromPreguntasBuffer(index);
            onUpdate();
          },
        );
      },
    );
  }
}
