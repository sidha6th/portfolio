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
  final _careerCardExtend = 100.0;
  late final timeLineController = ScrollController();
  late final listWheelController = ScrollController();
  final careerStartDateTime = KPersonal.careerStartDate;

  double _leftSpacing = 0;
  double _rightSpacing = 0;
  int careerWheelIndex = 0;
  double halfOfWindowWidth = 0;
  double clampedWindowWidth = 0;
  int _leftMonthFillerCount = 0;
  int _rightMonthFillerCount = 0;
  bool _enteredIntoCareerTimeLine = false;
  late var _currentDate = KPersonal.careerStartDate;
  late final _halfOfMonthIndicatorWidth =
      (KDimensions.kMonthTimelineIndicatorWidth / 2);

  @override
  void didUpdateWidget(covariant TimeLineCalendar oldWidget) {
    _updateWidth();
    if (!timeLineController.hasClients) return;
    _scroll();
    final focusPoint = timeLineController.offset -
        (halfOfWindowWidth + _halfOfMonthIndicatorWidth);
    _enteredIntoCareerTimeLine = focusPoint >= 0;

    if (!_enteredIntoCareerTimeLine) return;

    final indicatorPos =
        (focusPoint / KDimensions.kMonthTimelineIndicatorWidth);
    _currentDate = _datetime(indicatorPos);
    _animateCareerCard();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timeLineController.dispose();
    listWheelController.dispose();
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
              clampedWidth: clampedWindowWidth,
              controller: timeLineController,
              leftSpacing: _leftSpacing,
              rightSpacing: _rightSpacing,
              leftMonthFillerCount: _leftMonthFillerCount,
              rightMonthFillerCount: _rightMonthFillerCount,
              careerStartDateTime: careerStartDateTime,
            ),
            YearIndicatorTextWidget(
              enteredIntoCareerTimeLine: _enteredIntoCareerTimeLine,
              year: _currentDate.year,
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListWheelScrollView.useDelegate(
            itemExtent: _careerCardExtend,
            controller: listWheelController,
            physics: const NeverScrollableScrollPhysics(),
            perspective: 0.01,
            overAndUnderCenterOpacity: 0.3,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: KPersonal.careerJourney.length,
              builder: (context, index) {
                final career = KPersonal.careerJourney[index];
                final isCurrent = career.isCurrent(_currentDate);
                final timeToSwitch = isCurrent && careerWheelIndex != index;
                if (timeToSwitch) careerWheelIndex = index;

                return CareerPreviewCard(
                  metrics: widget.metrics,
                  height: _careerCardExtend,
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
    final newOffset = _careerCardExtend * careerWheelIndex;
    if (listWheelController.position.pixels == newOffset) return;
    listWheelController.animateTo(
      newOffset,
      duration: KDurations.ms200,
      curve: Curves.slowMiddle,
    );
  }

  void _updateWidth() {
    final viewPortWidth =
        widget.metrics.windowWidth.clamp(0.0, KDimensions.maxViewPortWidth);
    if (clampedWindowWidth == viewPortWidth) return;
    clampedWindowWidth = viewPortWidth;
    halfOfWindowWidth = clampedWindowWidth / 2;
    _calcLeftFillerCount();
    _calcRightFillerCount();
  }

  Future<void> _calcLeftFillerCount() async {
    final countAsDouble =
        clampedWindowWidth / KDimensions.kMonthTimelineIndicatorWidth;
    _leftMonthFillerCount = countAsDouble.toInt();
    _leftSpacing = (clampedWindowWidth -
            (_leftMonthFillerCount *
                KDimensions.kMonthTimelineIndicatorWidth)) +
        (countAsDouble - _leftMonthFillerCount);
  }

  Future<void> _calcRightFillerCount() async {
    final countAsDouble =
        halfOfWindowWidth / KDimensions.kMonthTimelineIndicatorWidth;
    _rightMonthFillerCount = countAsDouble.toInt();
    _rightSpacing = (halfOfWindowWidth -
            (_rightMonthFillerCount *
                KDimensions.kMonthTimelineIndicatorWidth)) +
        (countAsDouble - _rightMonthFillerCount);
  }

  DateTime _datetime(double indicatorPos) {
    return DateTime(
      careerStartDateTime.year,
      careerStartDateTime.month + indicatorPos.toInt(),
    );
  }

  Future<void> _scroll() async {
    timeLineController.jumpTo(
      (widget.offset - (widget.metrics.windowHeight / 2)).clamp(
        0,
        timeLineController.position.maxScrollExtent,
      ),
    );
  }
}
