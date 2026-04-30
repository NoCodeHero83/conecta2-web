import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registartion_button_model.dart';
export 'registartion_button_model.dart';

class RegistartionButtonWidget extends StatefulWidget {
  const RegistartionButtonWidget({
    super.key,
    String? btnText,
    required this.btnAction,
  }) : this.btnText = btnText ?? ' ';

  final String btnText;
  final Future Function()? btnAction;

  @override
  State<RegistartionButtonWidget> createState() =>
      _RegistartionButtonWidgetState();
}

class _RegistartionButtonWidgetState extends State<RegistartionButtonWidget> {
  late RegistartionButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistartionButtonModel());

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
        color: FlutterFlowTheme.of(context).accent2,
        textStyle: FlutterFlowTheme.of(context).titleLarge.override(
              font: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
              ),
              color: FlutterFlowTheme.of(context).primaryBackground,
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }
}
