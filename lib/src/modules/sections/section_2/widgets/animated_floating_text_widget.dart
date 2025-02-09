import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/blue_gradient_text_box_widget.dart';

class AnimatedFloatingTextWidget extends StatefulWidget {
  const AnimatedFloatingTextWidget({
    required this.dy,
    required this.dx,
    required this.text,
    required this.angle,
    required this.metrics,
    this.initialDy = 0,
    this.initialDx = 0,
    this.initialAngle = 0,
    this.alignment = Alignment.center,
    super.key,
  });

  final double dy;
  final double dx;
  final String text;
  final double angle;
  final double initialDy;
  final double initialDx;
  final double initialAngle;
  final Alignment alignment;
  final FreezeMetrics metrics;

  @override
  State<AnimatedFloatingTextWidget> createState() =>
      _AnimatedFloatingTextWidgetState();
}

class _AnimatedFloatingTextWidgetState
    extends State<AnimatedFloatingTextWidget> {
  late var size = widget.metrics.windowSize;
  late var child = BlueGradientTextBoxWidget(widget.text);
  @override
  void didUpdateWidget(covariant AnimatedFloatingTextWidget oldWidget) {
    widget.metrics.whenWindowResized(
      size,
      (windowsSize) {
        size = windowsSize;
        child = BlueGradientTextBoxWidget(widget.text);
      },
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final offset =
        Offset(widget.initialDx + widget.dx, widget.initialDy + widget.dy);
    final turns = widget.initialAngle + widget.angle;
    final curve = Curves.ease;

    return AnimatedSlide(
      curve: curve,
      offset: offset,
      duration: KDurations.mi50,
      child: AnimatedRotation(
        turns: turns,
        curve: curve,
        alignment: widget.alignment,
        duration: KDurations.mi50,
        filterQuality: FilterQuality.none,
        child: child,
      ),
    );
  }
}
