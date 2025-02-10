import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    required this.child,
    required this.offset,
    required this.opacity,
    this.animate = true,
    this.opacityDuration,
    this.slidCurve = Curves.linear,
    this.duration = KDurations.ms100,
    this.opacityCurve = Curves.linear,
    super.key,
  });

  final Widget child;
  final bool animate;
  final Offset offset;
  final double opacity;
  final Curve slidCurve;
  final Duration duration;
  final Curve opacityCurve;
  final Duration? opacityDuration;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> {
  late var child = widget.child;

  @override
  void didUpdateWidget(covariant FadeSlideIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget == oldWidget) return;
    
    child = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) return child;

    return AnimatedSlide(
      offset: widget.offset,
      curve: widget.slidCurve,
      duration: widget.duration,
      child: AnimatedOpacity(
        opacity: widget.opacity,
        curve: widget.opacityCurve,
        duration: widget.opacityDuration ?? widget.duration,
        child: child,
      ),
    );
  }
}
