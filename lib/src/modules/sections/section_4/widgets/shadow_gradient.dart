import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';

class ShadowGradient extends StatelessWidget {
  const ShadowGradient.start({
    required this.height,
    required this.width,
    this.colors = AppColors.shadow,
    super.key,
  }) : isEnd = false;
  const ShadowGradient.end({
    required this.height,
    required this.width,
    this.colors = AppColors.shadowInverse,
    super.key,
  }) : isEnd = true;

  final double height;
  final double width;
  final List<Color> colors;
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: isEnd ? AppColors.inverseShadowStops : AppColors.shadowStops,
        ),
      ),
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
