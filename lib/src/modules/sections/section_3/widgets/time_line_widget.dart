import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/constants/personal.dart';
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
    required this.now,
    super.key,
  });

  final double clampedWidth;
  final ScrollController controller;
  final double leftSpacing;
  final double rightSpacing;
  final int leftMonthFillerCount;
  final int rightMonthFillerCount;
  final DateTime careerStartDateTime;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: clampedWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: leftSpacing, right: rightSpacing),
            itemCount: leftMonthFillerCount +
                rightMonthFillerCount +
                Misc.monthsElapsedInCareer,
            itemBuilder: (context, index) {
              final dateTime = DateTime(
                careerStartDateTime.year,
                (careerStartDateTime.month - leftMonthFillerCount) + index,
              );
              final dateTimeWithPreviousMonth = DateTime(
                KPersonal.careerStartDate.year,
                KPersonal.careerStartDate.month - 1,
              );
              final isInCareerTimeLine =
                  dateTime.isAfter(dateTimeWithPreviousMonth) &&
                      dateTime.isBefore(now);

              return MonthIndicatorWidget(
                height: 50,
                dateTime.month,
                indicate: KPersonal.milestoneStartDates.contains(dateTime),
                color: isInCareerTimeLine ? AppColors.white : AppColors.grey,
              );
            },
          ),
          TimeLineShadowWidget.start(height: 71, width: clampedWidth * 0.3),
          TimeLineShadowWidget.end(height: 71, width: clampedWidth * 0.3),
        ],
      ),
    );
  }
}
