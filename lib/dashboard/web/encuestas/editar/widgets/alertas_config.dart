import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/backend/schema/structs/alerta_struct.dart';
import '/backend/backend.dart';
import '/components/text_field_alerta_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';

import '../editar_encuesta_model.dart';
import '../forms/form_sustancias.dart' show kSustanciasOptions;

/// Sidebar panel to configure alert thresholds for the encuesta.
///
/// - For "Tamizaje (Sustancias)": shows the per-substance min/max editor
///   backed by [FFAppState().listaAlertasEnvio] (unchanged behaviour).
/// - For CDI / Depresión Beck / Escala autoestima: shows fixed nivel rows
///   with editable min/max that are saved directly to the encuesta document.
class AlertasConfig extends StatefulWidget {
  const AlertasConfig({
    super.key,
    required this.model,
    required this.onUpdate,
    this.encuesta,
  });

  final EditarEncuestaModel model;
  final VoidCallback onUpdate;

  /// Required for CDI/Beck/Autoestima so values can be saved to Firestore.
  final EncuestasRecord? encuesta;

  @override
  State<AlertasConfig> createState() => _AlertasConfigState();
}

class _AlertasConfigState extends State<AlertasConfig> {
  // nivel → (minController, maxController)
  final Map<String, _NivelControllers> _ctrl = {};
  String? _categoriaActual;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(AlertasConfig old) {
    super.didUpdateWidget(old);
    final cat = _resolveCategoria();
    if (cat != _categoriaActual) _initControllers();
  }

  @override
  void dispose() {
    for (final c in _ctrl.values) {
      c.min.dispose();
      c.max.dispose();
    }
    super.dispose();
  }

  String? _resolveCategoria() =>
      widget.model.categoriaValue ?? widget.encuesta?.categoria;

  List<String> _nivelesParaCategoria(String? cat) {
    switch (cat) {
      case 'CDI':
        return const ['Sin sintomatología', 'Leve', 'Severo'];
      case 'Depresión Beck':
        return const ['Mínima', 'Leve', 'Moderada', 'Grave'];
      case 'Escala autoestima':
        return const ['Baja', 'Media', 'Elevada'];
      default:
        return const [];
    }
  }

  void _initControllers() {
    for (final c in _ctrl.values) {
      c.min.dispose();
      c.max.dispose();
    }
    _ctrl.clear();

    final cat = _resolveCategoria();
    _categoriaActual = cat;
    final niveles = _nivelesParaCategoria(cat);
    if (niveles.isEmpty) return;

    final existentes = widget.encuesta?.alertas ?? [];
    for (final nivel in niveles) {
      final existing =
          existentes.firstWhereOrNull((a) => a.nivel == nivel);
      _ctrl[nivel] = _NivelControllers(
        min: TextEditingController(
            text: (existing?.min ?? 0).toString()),
        max: TextEditingController(
            text: (existing?.max ?? 0).toString()),
      );
    }
  }

  Future<void> _guardarNiveles() async {
    final encuesta = widget.encuesta;
    if (encuesta == null) return;
    final niveles = _nivelesParaCategoria(_resolveCategoria());
    final alertas = niveles.map((nivel) {
      final c = _ctrl[nivel]!;
      return AlertaStruct(
        nivel: nivel,
        min: int.tryParse(c.min.text) ?? 0,
        max: int.tryParse(c.max.text) ?? 0,
      );
    }).toList();
    await encuesta.reference.update({
      ...mapToFirestore({'alertas': getAlertaListFirestoreData(alertas)}),
    });
    widget.onUpdate();
  }

  bool get _esSPA =>
      widget.model.tipoValue == 'Tamizaje (Sustancias)';

  bool get _esNiveles =>
      _nivelesParaCategoria(_resolveCategoria()).isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!_esSPA && !_esNiveles) return const SizedBox.shrink();

    final tema = FlutterFlowTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 50.0,
            color: Color(0x26000000),
            offset: Offset(20.0, 20.0),
          )
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alertas',
            style: tema.bodyMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w600),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(height: 8.0),
          if (_esSPA) _buildSPASection(tema),
          if (_esNiveles && !_esSPA) _buildNivelesSection(tema),
        ],
      ),
    );
  }

  // ── SPA section (original behaviour) ─────────────────────────────────────

  Widget _buildSPASection(FlutterFlowTheme tema) {
    final alertas = FFAppState().listaAlertasEnvio.toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Sustancia: ', style: tema.bodyMedium),
            FlutterFlowDropDown<String>(
              textStyle: tema.bodyMedium,
              controller: widget.model.sustanciaAlertasController ??=
                  FormFieldController<String>(null),
              options: kSustanciasOptions,
              onChanged: (val) {
                widget.model.sustanciaAlertasValue = val;
                widget.onUpdate();
              },
              width: 200.0,
              height: 40.0,
              hintText: 'Seleccione',
              fillColor: tema.secondaryBackground,
              elevation: 2.0,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 8.0,
              margin:
                  const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              hidesUnderline: true,
              isSearchable: false,
              isMultiSelect: false,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (int i = 0; i < alertas.length; i++)
          if (alertas[i].sustancia == widget.model.sustanciaAlertasValue)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  8.0, 20.0, 8.0, 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      alertas[i].nivel,
                      style: tema.bodyMedium.override(
                        font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Min', style: tema.bodyMedium),
                        TextFieldAlertaWidget(
                          key: Key(
                              'editAlertaMin_${i}_${alertas.length}'),
                          parameter1: alertas[i].min,
                          accion: (nuevo) async {
                            FFAppState()
                                .updateListaAlertasEnvioAtIndex(
                              i,
                              (e) => e..min = nuevo,
                            );
                            widget.onUpdate();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Max', style: tema.bodyMedium),
                        TextFieldAlertaWidget(
                          key: Key(
                              'editAlertaMax_${i}_${alertas.length}'),
                          parameter1: alertas[i].max,
                          accion: (nuevo) async {
                            FFAppState()
                                .updateListaAlertasEnvioAtIndex(
                              i,
                              (e) => e..max = nuevo,
                            );
                            widget.onUpdate();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  // ── CDI / Beck / Autoestima section ──────────────────────────────────────

  Widget _buildNivelesSection(FlutterFlowTheme tema) {
    final niveles = _nivelesParaCategoria(_resolveCategoria());
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Define los rangos de puntaje para cada nivel.',
          style: tema.bodySmall.override(
            font: GoogleFonts.inter(),
            color: tema.secondaryText,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 4),
        // Header row
        Padding(
          padding:
              const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
          child: Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                flex: 2,
                child: Text('Min',
                    style: tema.bodySmall.override(
                      font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600),
                      letterSpacing: 0.0,
                    )),
              ),
              Expanded(
                flex: 2,
                child: Text('Max',
                    style: tema.bodySmall.override(
                      font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600),
                      letterSpacing: 0.0,
                    )),
              ),
            ],
          ),
        ),
        for (final nivel in niveles)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                8.0, 12.0, 8.0, 0.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    nivel,
                    style: tema.bodyMedium.override(
                      font: GoogleFonts.inter(
                          fontWeight: FontWeight.w500),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _ctrl[nivel]!.min,
                    keyboardType: TextInputType.number,
                    onEditingComplete: _guardarNiveles,
                    onTapOutside: (_) => _guardarNiveles(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: tema.secondaryBackground,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _ctrl[nivel]!.max,
                    keyboardType: TextInputType.number,
                    onEditingComplete: _guardarNiveles,
                    onTapOutside: (_) => _guardarNiveles(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: tema.secondaryBackground,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _guardarNiveles,
            icon: const Icon(Icons.save_outlined, size: 16),
            label: const Text('Guardar'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF265294),
              textStyle:
                  GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _NivelControllers {
  const _NivelControllers({required this.min, required this.max});
  final TextEditingController min;
  final TextEditingController max;
}
