import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'resultado_respuesta_view.dart';

/// The right-hand sidebar of the Resultados screen. Shows a sticky header
/// with the currently focused question (or the default "n usuarios" count
/// when none is selected) and the list of answers below it.
class ResultadoNotas extends StatelessWidget {
  const ResultadoNotas({
    super.key,
    required this.respuestas,
    required this.pregunta,
    required this.tipo,
    required this.itemIndex,
  });

  final List<RespuestasRecord> respuestas;
  final String? pregunta;
  final String? tipo;
  final int? itemIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 50.0,
              color: Color(0x26000000),
              offset: Offset(20.0, 20.0),
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StickyHeader(
                        overlapHeaders: false,
                        header: _Header(
                          respuestas: respuestas,
                          pregunta: pregunta,
                        ),
                        content: ResultadoRespuestaView(
                          respuestas: respuestas,
                          tipo: tipo,
                          itemIndex: itemIndex,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.respuestas, required this.pregunta});

  final List<RespuestasRecord> respuestas;
  final String? pregunta;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    final hasPregunta = pregunta != null && pregunta!.isNotEmpty;
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 15),
            child: Text(
              'Repuestas por: ',
              style: bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle: bodyMedium.fontStyle,
                ),
                fontSize: 30.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (!hasPregunta)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 15),
              child: Text(
                '${functions.countEncuesta(respuestas.map((e) => e.userRespuesta?.id).withoutNulls.toList())} usuarios',
                style: bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle: bodyMedium.fontStyle,
                  ),
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 15),
              child: Text(
                valueOrDefault<String>(pregunta, '123'),
                style: bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle: bodyMedium.fontStyle,
                  ),
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
