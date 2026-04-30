import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'emptytest_model.dart';
export 'emptytest_model.dart';

class EmptytestWidget extends StatefulWidget {
  const EmptytestWidget({super.key});

  @override
  State<EmptytestWidget> createState() => _EmptytestWidgetState();
}

class _EmptytestWidgetState extends State<EmptytestWidget> {
  late EmptytestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptytestModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Lottie.asset(
          'assets/jsons/Animation_-_1718470289273.json',
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: 200.0,
          fit: BoxFit.contain,
          animate: true,
        ),
      ],
    );
  }
}
