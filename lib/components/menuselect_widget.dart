import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menuselect_model.dart';
export 'menuselect_model.dart';

class MenuselectWidget extends StatefulWidget {
  const MenuselectWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.select,
    this.activeKey,
  });

  final Widget? icon;
  final String? text;
  final String? select;

  /// Clave alternativa para determinar si el ítem está activo.
  /// Si se proporciona, se usa en lugar de `text` para comparar con `select`.
  /// Útil cuando el label mostrado ("Tamizajes") difiere de la clave interna
  /// ("ProfesionalTamizajes" / "ProfesionalTamizajesManuales" / etc.).
  /// Puede ser una lista separada por comas para aceptar múltiples keys.
  final String? activeKey;

  bool get isActive {
    final keys = (activeKey ?? text ?? '').split(',').map((s) => s.trim());
    return keys.any((k) => k.isNotEmpty && k == select);
  }

  @override
  State<MenuselectWidget> createState() => _MenuselectWidgetState();
}

class _MenuselectWidgetState extends State<MenuselectWidget> {
  late MenuselectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuselectModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          widget.isActive
              ? FlutterFlowTheme.of(context).alternate
              : FlutterFlowTheme.of(context).menuWeb,
          FlutterFlowTheme.of(context).menuWeb,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Builder(
            builder: (context) {
              if (widget.isActive) {
                return widget.icon!;
              } else {
                return widget.icon!;
              }
            },
          ),
          Text(
            valueOrDefault<String>(
              widget.text,
              'Text',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: valueOrDefault<Color>(
                    widget.isActive
                        ? Color(0xFF265294)
                        : FlutterFlowTheme.of(context).accent1,
                    FlutterFlowTheme.of(context).accent1,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
        ]
            .divide(SizedBox(width: 15.0))
            .addToStart(SizedBox(width: 15.0))
            .addToEnd(SizedBox(width: 10.0)),
      ),
    );
  }
}
