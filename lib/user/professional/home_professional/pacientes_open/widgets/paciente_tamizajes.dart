import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

/// Choice-chip selector between "Encuestas" and "Tamizajes" plus the resulting
/// list of surveys/screenings for the given patient.
class PacienteTamizajesSection extends StatelessWidget {
  const PacienteTamizajesSection({
    super.key,
    required this.user,
    required this.pacienteRef,
    required this.choiceChipsController,
    required this.onChipChanged,
  });

  final UsersRecord user;
  final DocumentReference pacienteRef;
  final FormFieldController<List<String>> choiceChipsController;
  final ValueChanged<String?> onChipChanged;

  String? get _currentChoice => choiceChipsController.value?.firstOrNull;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
          child: FlutterFlowChoiceChips(
            options: const [
              ChipData('Encuestas'),
              ChipData('Tamizajes'),
            ],
            onChanged: (val) => onChipChanged(val?.firstOrNull),
            selectedChipStyle: ChipStyle(
              backgroundColor: const Color(0xFF265294),
              textStyle: bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontStyle: bodyMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryBackground,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                fontStyle: bodyMedium.fontStyle,
              ),
              iconColor: FlutterFlowTheme.of(context).primaryText,
              iconSize: 18.0,
              elevation: 4.0,
              borderRadius: BorderRadius.circular(16.0),
            ),
            unselectedChipStyle: ChipStyle(
              backgroundColor: FlutterFlowTheme.of(context).alternate,
              textStyle: bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: bodyMedium.fontWeight,
                  fontStyle: bodyMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: bodyMedium.fontWeight,
                fontStyle: bodyMedium.fontStyle,
              ),
              iconColor: FlutterFlowTheme.of(context).secondaryText,
              iconSize: 18.0,
              elevation: 0.0,
              borderRadius: BorderRadius.circular(16.0),
            ),
            chipSpacing: 0.0,
            rowSpacing: 12.0,
            multiselect: false,
            initialized: _currentChoice != null,
            alignment: WrapAlignment.spaceEvenly,
            controller: choiceChipsController,
            wrapped: true,
          ),
        ),
        StreamBuilder<List<EncuestasRecord>>(
          stream: queryEncuestasRecord(
            queryBuilder: (encuestasRecord) => encuestasRecord
                .where('user_Ref', arrayContains: pacienteRef)
                .where('tipo', isEqualTo: _currentChoice),
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }
            final records = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: records.length,
              itemBuilder: (context, index) =>
                  _EncuestaTile(record: records[index], pacienteRef: pacienteRef, choice: _currentChoice),
            );
          },
        ),
      ],
    );
  }
}

class _EncuestaTile extends StatelessWidget {
  const _EncuestaTile({
    required this.record,
    required this.pacienteRef,
    required this.choice,
  });

  final EncuestasRecord record;
  final DocumentReference pacienteRef;
  final String? choice;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = FlutterFlowTheme.of(context).bodyMedium;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidFileLines,
                      color: Color(0xFF265294),
                      size: 24.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.titulo,
                              overflow: TextOverflow.ellipsis,
                              style: bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: bodyMedium.fontStyle,
                                ),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: bodyMedium.fontStyle,
                              ),
                            ),
                            Text(
                              dateTimeFormat(
                                "yMMMd",
                                record.createAt!,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
                              style: bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: bodyMedium.fontStyle,
                                ),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: bodyMedium.fontStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF265294),
                  size: 24.0,
                ),
                onPressed: () async {
                  final getEncuestas = await queryRespuestasRecordOnce(
                    parent: record.reference,
                    queryBuilder: (r) => r.where(
                      'User_respuesta',
                      isEqualTo: pacienteRef,
                    ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);

                  if (!context.mounted) return;

                  context.pushNamed(
                    PacientRespuestaWidget.routeName,
                    queryParameters: {
                      'choice': serializeParam(choice, ParamType.String),
                      'encuesta':
                          serializeParam(getEncuestas, ParamType.Document),
                    }.withoutNulls,
                    extra: <String, dynamic>{'encuesta': getEncuestas},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
