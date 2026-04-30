import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state/respuesta_state.dart';
import '../widgets/pregunta_card.dart';

/// Wizard step 3: apply the tamizaje and answer every question.
class PasoFormulario extends StatefulWidget {
  const PasoFormulario({
    super.key,
    required this.encuesta,
    required this.adolescente,
    required this.onFinalizado,
  });

  final EncuestasRecord encuesta;
  final UsersRecord? adolescente;
  final void Function(
    List<RespuestaTestStruct> respuestas,
    int puntajeTotal,
    bool tieneIdeacion,
  ) onFinalizado;

  @override
  State<PasoFormulario> createState() => _PasoFormularioState();
}

class _PasoFormularioState extends State<PasoFormulario> {
  late final List<RespuestaState> _estados;
  bool _enviando = false;

  @override
  void initState() {
    super.initState();
    _estados =
        widget.encuesta.preguntas.map((p) => RespuestaState(p)).toList();
  }

  void _enviar() {
    for (var i = 0; i < _estados.length; i++) {
      final s = _estados[i];
      if (!s.estaCompleto()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falta responder la pregunta ${i + 1}')),
        );
        return;
      }
    }

    setState(() => _enviando = true);

    final respuestas = <RespuestaTestStruct>[];
    var puntaje = 0;
    var ideacion = false;
    for (var i = 0; i < _estados.length; i++) {
      final s = _estados[i];
      final r = s.toStruct(i + 1);
      respuestas.add(r);
      for (final atr in r.respuestaTamizaje) {
        puntaje += atr.valor;
        if (atr.ideacionSuicida) ideacion = true;
      }
    }
    widget.onFinalizado(respuestas, puntaje, ideacion);
  }

  int get _respondidas {
    return _estados.where((s) => s.estaCompleto()).length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final total = _estados.length;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          color: theme.secondaryBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.encuesta.titulo,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: theme.primaryText,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (widget.adolescente != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBE5A1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person,
                              size: 14, color: Color(0xFF265294)),
                          const SizedBox(width: 4),
                          Text(
                            widget.adolescente!.displayName,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF265294),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  Text(
                    '$_respondidas / $total',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: total > 0 ? _respondidas / total : 0,
                  backgroundColor: theme.alternate,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF34A853)),
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            itemCount: _estados.length,
            itemBuilder: (context, i) {
              return MobilePreguntaCard(
                numero: i + 1,
                estado: _estados[i],
                theme: theme,
                onChanged: () => setState(() {}),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _enviando ? null : _enviar,
              icon: _enviando
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.check_circle_outline, size: 20),
              label: Text(
                'Finalizar y guardar',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF265294),
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    const Color(0xFF265294).withValues(alpha: 0.5),
                disabledForegroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
