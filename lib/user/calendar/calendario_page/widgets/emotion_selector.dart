import '/flutter_flow/flutter_flow_animations.dart';
import 'package:flutter/material.dart';

/// The 5-emotion picker row shown in the "Start" state of the calendar.
///
/// The parent owns the [AnimationInfo] map and is notified via [onEmotionPicked]
/// with the numeric emotion value (1..5).
class EmotionSelector extends StatelessWidget {
  const EmotionSelector({
    super.key,
    required this.animationsMap,
    required this.onEmotionPicked,
  });

  /// Map of animation keys, expected to contain keys:
  /// containerOnActionTriggerAnimation1..10
  final Map<String, AnimationInfo> animationsMap;

  /// Called with the picked emotion value (5=happy..1=angry).
  final ValueChanged<int> onEmotionPicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _decoration(
                width: 41.0,
                child: _asset('assets/images/free-plus-icon-321-thumb.png'),
                animation: animationsMap['containerOnActionTriggerAnimation1'],
              ),
              _decoration(
                animation: animationsMap['containerOnActionTriggerAnimation2'],
              ),
              _decoration(
                animation: animationsMap['containerOnActionTriggerAnimation3'],
              ),
              _decoration(
                animation: animationsMap['containerOnActionTriggerAnimation4'],
              ),
              _decoration(
                width: 31.0,
                child: _asset('assets/images/min.png'),
                animation: animationsMap['containerOnActionTriggerAnimation5'],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(5, (i) {
              // Order in the UI is 5 (happy), 4, 3, 2, 1 (angry).
              // Animation indexes are 6..10 in the same order.
              final emotion = 5 - i;
              final animKey = 'containerOnActionTriggerAnimation${6 + i}';
              return _emotionTile(
                context: context,
                emotion: emotion,
                asset: _emotionAsset(emotion),
                activeKey: animKey,
              );
            }),
          ),
        ),
      ],
    );
  }

  String _emotionAsset(int emotion) {
    switch (emotion) {
      case 5:
        return 'assets/images/caritasRecurso_2Plantilla.png';
      case 4:
        return 'assets/images/caritasRecurso_3Plantilla.png';
      case 3:
        return 'assets/images/caritasRecurso_4Plantilla.png';
      case 2:
        return 'assets/images/caritasRecurso_5Plantilla.png';
      default:
        return 'assets/images/04CARA_TAMAO_CALENDARIORecurso_17Plantilla.png';
    }
  }

  Widget _asset(String path) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(path, fit: BoxFit.contain),
        ),
      );

  Widget _decoration({
    double width = 81.0,
    Widget? child,
    AnimationInfo? animation,
  }) {
    Widget w = Container(
      width: width,
      height: 81.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
    if (animation != null) {
      w = w.animateOnActionTrigger(animation);
    }
    return w;
  }

  Widget _emotionTile({
    required BuildContext context,
    required int emotion,
    required String asset,
    required String activeKey,
  }) {
    final allKeys = [
      'containerOnActionTriggerAnimation6',
      'containerOnActionTriggerAnimation7',
      'containerOnActionTriggerAnimation8',
      'containerOnActionTriggerAnimation9',
      'containerOnActionTriggerAnimation10',
    ];

    final tile = InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        onEmotionPicked(emotion);
        await Future.wait(
          allKeys.map((key) async {
            final anim = animationsMap[key];
            if (anim == null) return;
            if (key == activeKey) {
              await anim.controller.forward(from: 0.0);
            } else {
              anim.controller.reset();
            }
          }),
        );
      },
      child: Container(
        width: 81.0,
        height: 81.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: _asset(asset),
      ),
    );
    final animation = animationsMap[activeKey];
    return animation != null ? tile.animateOnActionTrigger(animation) : tile;
  }
}
