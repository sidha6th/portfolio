import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';

class ShadowGradient extends StatelessWidget {
  const ShadowGradient.start({
    required this.height,
    required this.width,
    this.colors = const [AppColors.black, Colors.transparent],
    super.key,
  }) : isEnd = false;
  const ShadowGradient.end({
    required this.height,
    required this.width,
    this.colors = const [Colors.transparent, AppColors.black],
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
          stops: isEnd ? [0, 0.8] : [0.2, 1],
        ),
      ),
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
