import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    required this.child,
    required this.offset,
    required this.opacity,
    this.animate = true,
    this.slidCurve = Curves.linear,
    this.duration = KDurations.ms100,
    this.opacityCurve = Curves.linear,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final double opacity;
  final Offset offset;
  final bool animate;
  final Curve opacityCurve;
  final Curve slidCurve;

  @override
  Widget build(BuildContext context) {
    if (!animate) return child;

    return AnimatedSlide(
      offset: offset,
      curve: slidCurve,
      duration: duration,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        curve: opacityCurve,
        child: child,
      ),
    );
  }
}
