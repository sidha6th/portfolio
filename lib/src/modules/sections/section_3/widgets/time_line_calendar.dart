import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/career_details_holding_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/career_preview_card.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/month_arrow_indicator.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/time_line_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/year_indicator_text_widget.dart';

class TimeLineCalendar extends StatefulWidget {
  const TimeLineCalendar({
    required this.offset,
    required this.metrics,
    super.key,
  });

  final double offset;
  final FreezeMetrics metrics;

  @override
  State<TimeLineCalendar> createState() => _TimeLineCalendarState();
}

class _TimeLineCalendarState extends State<TimeLineCalendar> {
  late final controller = ScrollController();
  late final wheelScrollController = ScrollController();

  late final halfOfMonthIndicator =
      (KDimensions.kMonthTimelineIndicatorWidth / 2);
  final careerStartDateTime = KPersonal.careerStartDate;
  late var currentDate = KPersonal.careerStartDate;
  double clampedWidth = 0;
  double halfOfWidth = 0;
  bool enteredIntoCareerTimeLine = false;
  int leftMonthFillerCount = 0;
  int rightMonthFillerCount = 0;
  double leftSpacing = 0;
  double rightSpacing = 0;
  double careerCardExtend = 100;
  int careerWheelIndex = 0;

  @override
  void didUpdateWidget(covariant TimeLineCalendar oldWidget) {
    _updateWidth();
    if (!controller.hasClients) return;
    _scroll();
    final focusPoint = controller.offset - (halfOfWidth + halfOfMonthIndicator);
    enteredIntoCareerTimeLine = focusPoint >= 0;

    if (!enteredIntoCareerTimeLine) return;

    final indicatorPos =
        (focusPoint / KDimensions.kMonthTimelineIndicatorWidth);
    currentDate = _datetime(indicatorPos);
    _animateCareerCard();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    wheelScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHeightLessThanMin = widget.metrics.windowHeight < 500;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: isHeightLessThanMin ? 0 : (widget.metrics.windowHeight * 0.1),
      children: [
        SizedBox(
          height: isHeightLessThanMin
              ? 0
              : (widget.metrics.windowHeight * 0.05).clamp(60, double.infinity),
        ),
        Column(
          children: [
            const MonthArrowIndicator(),
            TimeLineWidget(
              clampedWidth: clampedWidth,
              controller: controller,
              leftSpacing: leftSpacing,
              rightSpacing: rightSpacing,
              leftMonthFillerCount: leftMonthFillerCount,
              rightMonthFillerCount: rightMonthFillerCount,
              careerStartDateTime: careerStartDateTime,
            ),
            YearIndicatorTextWidget(
              enteredIntoCareerTimeLine: enteredIntoCareerTimeLine,
              year: currentDate.year,
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListWheelScrollView.useDelegate(
            itemExtent: careerCardExtend,
            controller: wheelScrollController,
            physics: const NeverScrollableScrollPhysics(),
            perspective: 0.01,
            overAndUnderCenterOpacity: 0.3,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: KPersonal.careerJourney.length,
              builder: (context, index) {
                final career = KPersonal.careerJourney[index];
                final isCurrent = career.isCurrent(currentDate);
                final timeToSwitch = isCurrent && careerWheelIndex != index;
                if (timeToSwitch) careerWheelIndex = index;

                return CareerPreviewCard(
                  metrics: widget.metrics,
                  height: careerCardExtend,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CareerDetailsHoldingWidget(career: career),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _animateCareerCard() {
    final newOffset = careerCardExtend * careerWheelIndex;
    if (wheelScrollController.position.pixels == newOffset) return;
    wheelScrollController.animateTo(
      newOffset,
      duration: KDurations.ms200,
      curve: Curves.slowMiddle,
    );
  }

  void _updateWidth() {
    final viewPortWidth =
        widget.metrics.windowWidth.clamp(0.0, KDimensions.maxViewPortWidth);
    if (clampedWidth == viewPortWidth) return;
    clampedWidth = viewPortWidth;
    halfOfWidth = clampedWidth / 2;
    leftFillerCount();
    rightFillerCount();
  }

  Future<void> leftFillerCount() async {
    final countAsDouble =
        clampedWidth / KDimensions.kMonthTimelineIndicatorWidth;
    leftMonthFillerCount = countAsDouble.toInt();
    leftSpacing = (clampedWidth -
            (leftMonthFillerCount * KDimensions.kMonthTimelineIndicatorWidth)) +
        (countAsDouble - leftMonthFillerCount);
  }

  Future<void> rightFillerCount() async {
    final countAsDouble =
        halfOfWidth / KDimensions.kMonthTimelineIndicatorWidth;
    rightMonthFillerCount = countAsDouble.toInt();
    rightSpacing = (halfOfWidth -
            (rightMonthFillerCount *
                KDimensions.kMonthTimelineIndicatorWidth)) +
        (countAsDouble - rightMonthFillerCount);
  }

  DateTime _datetime(double indicatorPos) {
    return DateTime(
      careerStartDateTime.year,
      careerStartDateTime.month + indicatorPos.toInt(),
    );
  }

  Future<void> _scroll() async {
    unawaited(
      controller.animateTo(
        (widget.offset - (widget.metrics.windowHeight / 2)).clamp(
          0,
          controller.position.maxScrollExtent,
        ),
        duration: KDurations.ms200,
        curve: Curves.linear,
      ),
    );
  }
}
