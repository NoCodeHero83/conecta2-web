import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'radios_button_vista_previa_model.dart';
export 'radios_button_vista_previa_model.dart';

class RadiosButtonVistaPreviaWidget extends StatefulWidget {
  const RadiosButtonVistaPreviaWidget({
    super.key,
    this.parameter1,
    this.parameter2,
  });

  final String? parameter1;
  final List<String>? parameter2;

  @override
  State<RadiosButtonVistaPreviaWidget> createState() =>
      _RadiosButtonVistaPreviaWidgetState();
}

class _RadiosButtonVistaPreviaWidgetState
    extends State<RadiosButtonVistaPreviaWidget> {
  late RadiosButtonVistaPreviaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadiosButtonVistaPreviaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowRadioButton(
      options: widget.parameter2!.toList(),
      onChanged: (currentUserEmail != '')
          ? null
          : (val) => safeSetState(() {}),
      controller: _model.radioButtonValueController ??=
          FormFieldController<String>(widget.parameter1!),
      optionHeight: 32.0,
      optionWidth: MediaQuery.sizeOf(context).width * 1.0,
      textStyle: FlutterFlowTheme.of(context).labelMedium.override(
            font: GoogleFonts.inter(
              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
            ),
            fontSize: 14.0,
            letterSpacing: 0.0,
            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
          ),
      buttonPosition: RadioButtonPosition.left,
      direction: Axis.vertical,
      radioButtonColor: FlutterFlowTheme.of(context).primary,
      inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
      toggleable: false,
      horizontalAlignment: WrapAlignment.start,
      verticalAlignment: WrapCrossAlignment.start,
    );
  }
}
