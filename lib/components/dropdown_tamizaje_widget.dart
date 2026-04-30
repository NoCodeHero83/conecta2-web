import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dropdown_tamizaje_model.dart';
export 'dropdown_tamizaje_model.dart';

class DropdownTamizajeWidget extends StatefulWidget {
  const DropdownTamizajeWidget({
    super.key,
    this.parameter1,
    required this.accion,
  });

  final String? parameter1;
  final Future Function(String nuevoTexto)? accion;

  @override
  State<DropdownTamizajeWidget> createState() => _DropdownTamizajeWidgetState();
}

class _DropdownTamizajeWidgetState extends State<DropdownTamizajeWidget> {
  late DropdownTamizajeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropdownTamizajeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowDropDown<String>(
      controller: _model.dropDownSustanciaValueController ??=
          FormFieldController<String>(
        _model.dropDownSustanciaValue ??= widget.parameter1,
      ),
      options: [
        'Tabaco',
        'Bebidas alcohólicas',
        'Cannabis',
        'Anfetaminas',
        'Inhalantes',
        'Tranquilizantes',
        'Alucinógenos',
        'Opiáceos',
        'Otros',
        'Cocaina'
      ],
      onChanged: (val) async {
        safeSetState(() => _model.dropDownSustanciaValue = val);
        await widget.accion?.call(
          _model.dropDownSustanciaValue!,
        );
      },
      width: 200.0,
      height: 40.0,
      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.inter(
              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
            letterSpacing: 0.0,
            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
          ),
      hintText: 'Seleccione',
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: FlutterFlowTheme.of(context).secondaryText,
        size: 24.0,
      ),
      fillColor: FlutterFlowTheme.of(context).primaryBackground,
      elevation: 2.0,
      borderColor: Colors.transparent,
      borderWidth: 0.0,
      borderRadius: 8.0,
      margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
      hidesUnderline: true,
      isOverButton: false,
      isSearchable: false,
      isMultiSelect: false,
    );
  }
}
