import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/month_arrow_indicator.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/month_indicator.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/year_indicator_text_widget.dart';

class TimeLineCalendar extends StatefulWidget {
  const TimeLineCalendar({
    required this.offset,
    required this.metrics,
    super.key,
  });

  final double offset;
  final FreezedMetrics metrics;

  @override
  State<TimeLineCalendar> createState() => _TimeLineCalendarState();
}

class _TimeLineCalendarState extends State<TimeLineCalendar> {
  late final controller = ScrollController();
  late final halfOfMonthIndicator =
      (KDimensions.kMonthTimelineIndicatorWidth / 2);
  final careerStartDateTime = KPersonal.careerStartDate;
  late int year = careerStartDateTime.year;
  late int pointingMonth = careerStartDateTime.month;
  double clampedWidth = 0;
  double halfOfWidth = 0;
  bool enteredIntoCareerTimeLine = false;
  int leftMonthFillerCount = 0;
  int rightMonthFillerCount = 0;
  double leftSpacing = 0;
  double rightSpacing = 0;

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
    final dateTime = _datetime(indicatorPos);
    year = dateTime.year;
    pointingMonth = dateTime.month;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthArrowIndicator(
          enteredIntoCareerTimeLine: enteredIntoCareerTimeLine,
        ),
        SizedBox(
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
                  return MonthIndicatorWidget(dateTime.month);
                },
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.8, 1],
                      colors: [AppColors.black, Colors.transparent],
                    ),
                  ),
                  child: SizedBox(
                    height: 71,
                    width: 50,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, 0.2],
                      colors: [
                        Colors.transparent,
                        AppColors.black,
                      ],
                    ),
                  ),
                  child: SizedBox(
                    height: 71,
                    width: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        YearIndicatorTextWidget(
          enteredIntoCareerTimeLine: enteredIntoCareerTimeLine,
          year: year,
        ),
      ],
    );
  }

  void _updateWidth() {
    final viewPortWidth =
        widget.metrics.viewPortWidth.clamp(0.0, KDimensions.maxViewPortWidth);
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
    controller.jumpTo(
      (widget.offset - (widget.metrics.viewPortHeight / 2)).clamp(
        0,
        controller.position.maxScrollExtent,
      ),
    );
  }
}
