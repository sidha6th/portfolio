import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/blue_gradient_text_box_widget.dart';

class AnimatedFloatingTextWidget extends StatelessWidget {
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

  final FreezeMetrics metrics;
  final String text;
  final double angle;
  final double dy;
  final double dx;
  final double initialDy;
  final double initialDx;
  final double initialAngle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: Offset(
        initialDx + dx,
        initialDy + dy,
      ),
      duration: KDurations.ms50,
      child: AnimatedRotation(
        turns: initialAngle + angle,
        alignment: alignment,
        duration: KDurations.ms50,
        filterQuality: FilterQuality.low,
        child: BlueGradientTextBoxWidget(text),
      ),
    );
  }
}
