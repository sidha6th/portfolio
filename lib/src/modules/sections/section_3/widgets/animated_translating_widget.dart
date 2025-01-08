import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class AnimatedTranslateWidget extends StatelessWidget {
  const AnimatedTranslateWidget({
    required this.dx,
    required this.opacity,
    required this.child,
    this.dy = 0,
    this.delay = 0,
    this.opacityDelay = 0,
    super.key,
  });

  final double dx;
  final double dy;
  final double delay;
  final double opacityDelay;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final x = (dx - delay).clamp(0.0, double.infinity);
    return Transform.translate(
      offset: Offset(x, dy),
      child: AnimatedOpacity(
        opacity: (opacity - opacityDelay).clamp(0, 1),
        duration: KDurations.ms100,
        child: child,
      ),
    );
  }
}
