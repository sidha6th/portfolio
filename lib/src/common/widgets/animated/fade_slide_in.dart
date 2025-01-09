import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    required this.child,
    required this.offset,
    required this.opacity,
    this.duration = KDurations.ms100,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final double opacity;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: offset,
      duration: duration,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        child: child,
      ),
    );
  }
}
