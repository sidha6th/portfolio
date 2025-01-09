import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/animated/fade_slide_in.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/month_indicator.dart';

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
  final careerStartDateTime = KPersonal.careerStartDate;
  late final halfOfMonthIndicator =
      (KDimensions.kMonthTimelineIndicatorWidth / 2);
  bool enteredIntoCareerTimeLine = false;
  double focusOffset = 0;
  late double width = widget.metrics.viewPortWidth;
  late double halfOfWidth = width / 2;
  late int year = careerStartDateTime.year;
  late int month = careerStartDateTime.month;
  late final controller = ScrollController();

  @override
  void didUpdateWidget(covariant TimeLineCalendar oldWidget) {
    _updateWidth();
    if (!controller.hasClients) return;
    _scroll();
    final startingPoint = controller.offset - halfOfWidth;
    focusOffset = startingPoint.clamp(0, double.infinity);
    enteredIntoCareerTimeLine = focusOffset > 0;
    if (enteredIntoCareerTimeLine) _calculateFocusingDateTime();
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
        SizedBox(
          height: 70,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controller,
            padding: EdgeInsets.only(
              left: widget.metrics.viewPortWidth,
              right: widget.metrics.viewPortWidth * 0.5,
            ),
            itemCount: KDimensions.totalMonthsPast,
            itemBuilder: (context, index) {
              return MonthIndicatorWidget(
                DateTime(
                  careerStartDateTime.year,
                  careerStartDateTime.month + index,
                ).month,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FadeSlideIn(
                offset: Offset(0, enteredIntoCareerTimeLine ? 0 : 1),
                opacity: enteredIntoCareerTimeLine ? 1 : 0,
                child: AnimatedFlipCounter(
                  value: year,
                  textStyle: const TextStyle(
                    fontSize: 10,
                    color: AppColors.white,
                    fontFamily: FontFamily.cindieMonoD,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _calculateFocusingDateTime() {
    final indicatorPos = (focusOffset + halfOfMonthIndicator) /
        KDimensions.kMonthTimelineIndicatorWidth;
    final currentDate = DateTime(
      careerStartDateTime.year,
      (careerStartDateTime.month - 1) + indicatorPos.toInt(),
    );
    year = currentDate.year;
    month = currentDate.month;
  }

  void _updateWidth() {
    if (width != widget.metrics.viewPortWidth) {
      width = widget.metrics.viewPortWidth;
      halfOfWidth = width / 2;
    }
  }

  Future<void> _scroll() async {
    controller.jumpTo(
      widget.offset.clamp(0, controller.position.maxScrollExtent),
    );
  }
}
