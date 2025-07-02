import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/blue_gradient_text_box_widget.dart';

class AnimatedFloatingTextWidget extends StatefulWidget {
  const AnimatedFloatingTextWidget({
    required this.dy,
    required this.dx,
    required this.text,
    required this.angle,
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

  @override
  State<AnimatedFloatingTextWidget> createState() =>
      _AnimatedFloatingTextWidgetState();
}

class _AnimatedFloatingTextWidgetState
    extends State<AnimatedFloatingTextWidget> {
  late var _size = context.screenSize;
  late var _child = BlueGradientTextBoxWidget(widget.text, screenSize: _size);

  @override
  void didUpdateWidget(covariant AnimatedFloatingTextWidget oldWidget) {
    _whenResized(context.screenSize);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final offset = Offset(
      (widget.initialDx + widget.dx),
      (widget.initialDy + widget.dy),
    );

    final turns = (widget.initialAngle + widget.angle);

    return FractionalTranslation(
      translation: offset,
      transformHitTests: false,
      child: Transform.rotate(
        angle: turns * pi,
        transformHitTests: false,
        alignment: widget.alignment,
        filterQuality: FilterQuality.low,
        child: _child,
      ),
    );
  }

  void _whenResized(Size windowsSize) {
    if (_size == windowsSize) return;
    _size = windowsSize;
    _child = BlueGradientTextBoxWidget(widget.text, screenSize: _size);
  }
}
