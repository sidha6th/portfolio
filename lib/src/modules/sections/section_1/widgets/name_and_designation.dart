import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class NameAndDesignation extends StatelessWidget {
  const NameAndDesignation({required this.metrics, super.key});

  final FreezeMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final fontSize = context.screenWidth * 0.05;
    final designationFontSize = context.screenWidth * 0.03;
    final maxDy = context.screenHeight * 0.25;

    return IgnorePointer(
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSlide(
            duration: KDurations.ms200,
            offset: Offset(0, -_dy(maxDy)),
            child: AnimatedOpacity(
              opacity: _opacity(50),
              duration: KDurations.ms100,
              child: TextWidget(
                KPersonal.name,
                style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.white,
                  fontFamily: FontFamily.cindieMonoD,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          AnimatedSlide(
            duration: KDurations.ms200,
            offset: Offset(0, -_dy(maxDy, delay: 50)),
            child: AnimatedOpacity(
              opacity: _opacity(100),
              duration: KDurations.ms100,
              child: TextWidget(
                KPersonal.designation,
                style: TextStyle(
                  fontSize: designationFontSize,
                  color: AppColors.white,
                  fontFamily: FontFamily.cindieMonoD,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          AnimatedSlide(
            duration: KDurations.ms200,
            offset: Offset(0, -_dy(maxDy, delay: 150)),
            child: AnimatedOpacity(
              opacity: _opacity(150),
              duration: KDurations.ms100,
              child: TextWidget(
                KString.year,
                style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.white,
                  fontFamily: FontFamily.cindieMonoD,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _dy(double max, {double delay = 0}) {
    max = max + delay;
    return (metrics.scrollOffset - delay).clamp(0, max) / 100;
  }

  double _opacity(double speed) {
    return ((100 + speed) - (metrics.scrollOffset)).clamp(0, 100) / 100;
  }
}
