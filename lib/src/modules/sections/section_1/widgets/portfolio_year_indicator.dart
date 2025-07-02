import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/animated/animated_fade_slide_in.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class PortfolioYearIndicator extends StatelessWidget {
  const PortfolioYearIndicator({required this.loading, super.key});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: AnimatedFadeSlideIn(
        slidCurve: Curves.fastOutSlowIn,
        duration: KDurations.ms600,
        offset: !loading ? Offset.zero : const Offset(0, -2),
        opacity: !loading ? 1 : 0,
        child: TextWidget(
          KString.portfolio,
          style: const TextStyle(
            fontFamily: FontFamily.cindieMonoD,
            color: AppColors.white,
            fontSize: 7,
          ),
        ),
      ),
    );
  }
}
