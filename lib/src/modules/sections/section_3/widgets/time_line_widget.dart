import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/month_indicator.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/shadow_widget.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({
    required this.clampedWidth,
    required this.controller,
    required this.leftSpacing,
    required this.rightSpacing,
    required this.leftMonthFillerCount,
    required this.rightMonthFillerCount,
    required this.careerStartDateTime,
    super.key,
  });

  final double clampedWidth;
  final ScrollController controller;
  final double leftSpacing;
  final double rightSpacing;
  final int leftMonthFillerCount;
  final int rightMonthFillerCount;
  final DateTime careerStartDateTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: clampedWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controller,
            padding: EdgeInsets.only(
              left: leftSpacing,
              right: rightSpacing,
            ),
            itemCount: leftMonthFillerCount +
                rightMonthFillerCount +
                KDimensions.totalMonthsPast,
            itemBuilder: (context, index) {
              final dateTime = DateTime(
                careerStartDateTime.year,
                (careerStartDateTime.month - leftMonthFillerCount) + index,
              );
              return MonthIndicatorWidget(
                dateTime.month,
                height: 50,
              );
            },
          ),
          const TimeLineShadowWidget.start(height: 71),
          const TimeLineShadowWidget.end(height: 71),
        ],
      ),
    );
  }
}
