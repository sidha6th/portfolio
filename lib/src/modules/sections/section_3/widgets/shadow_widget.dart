import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';

class TimeLineShadowWidget extends StatelessWidget {
  const TimeLineShadowWidget.start({
    required this.height,
    required this.width,
    this.stops = const [0.5, 1],
    this.alignment = Alignment.centerLeft,
    this.colors = const [AppColors.black, Colors.transparent],
    super.key,
  });
  const TimeLineShadowWidget.end({
    required this.height,
    required this.width,
    this.stops = const [0, 0.5],
    this.alignment = Alignment.centerRight,
    this.colors = const [Colors.transparent, AppColors.black],
    super.key,
  });

  final Alignment alignment;
  final List<double> stops;
  final double height;
  final List<Color> colors;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: stops,
            colors: colors,
          ),
        ),
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
    );
  }
}
