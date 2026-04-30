import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'tamizaje_r_q_c_model.dart';
export 'tamizaje_r_q_c_model.dart';

class TamizajeRQCWidget extends StatefulWidget {
  const TamizajeRQCWidget({super.key});

  @override
  State<TamizajeRQCWidget> createState() => _TamizajeRQCWidgetState();
}

class _TamizajeRQCWidgetState extends State<TamizajeRQCWidget> {
  late TamizajeRQCModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TamizajeRQCModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
