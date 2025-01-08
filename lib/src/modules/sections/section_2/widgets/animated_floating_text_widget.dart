import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/blue_gradient_text_box_widget.dart';

class AnimatedFloatingTextWidget extends StatefulWidget {
  const AnimatedFloatingTextWidget({
    required this.metrics,
    required this.text,
    required this.angle,
    required this.dx,
    required this.dy,
    this.initialDy = 0,
    this.initialDx = 0,
    this.initialAngle = 0,
    this.alignment = Alignment.center,
    super.key,
  });

  final FreezedMetrics metrics;
  final String text;
  final double angle;
  final double dy;
  final double dx;
  final double initialDy;
  final double initialDx;
  final double initialAngle;
  final Alignment alignment;

  @override
  State<AnimatedFloatingTextWidget> createState() =>
      _AnimatedFloatingTextWidgetState();
}

class _AnimatedFloatingTextWidgetState
    extends State<AnimatedFloatingTextWidget> {
  late final child = BlueGradientTextBoxWidget(widget.text);

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: Offset(
        widget.initialDx + widget.dx,
        widget.initialDy + widget.dy,
      ),
      duration: KDurations.ms50,
      child: AnimatedRotation(
        turns: widget.initialAngle + widget.angle,
        alignment: widget.alignment,
        duration: KDurations.ms50,
        filterQuality: FilterQuality.low,
        child: child,
      ),
    );
  }
}
