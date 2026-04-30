import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'button_vazado_model.dart';
export 'button_vazado_model.dart';

class ButtonVazadoWidget extends StatefulWidget {
  const ButtonVazadoWidget({
    super.key,
    String? btnText,
    required this.btnAction,
  }) : this.btnText = btnText ?? ' ';

  final String btnText;
  final Future Function()? btnAction;

  @override
  State<ButtonVazadoWidget> createState() => _ButtonVazadoWidgetState();
}

class _ButtonVazadoWidgetState extends State<ButtonVazadoWidget> {
  late ButtonVazadoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ButtonVazadoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        await widget.btnAction?.call();
      },
      text: widget.btnText,
      options: FFButtonOptions(
        width: double.infinity,
        height: 57.0,
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: Color(0x00F6BD33),
        textStyle: FlutterFlowTheme.of(context).titleLarge.override(
              font: GoogleFonts.inter(
                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).accent2,
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
            ),
        elevation: 0.0,
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).accent2,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }
}
