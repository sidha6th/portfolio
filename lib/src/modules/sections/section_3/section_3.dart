import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/date_time.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

final totalMonthsPast = KPersonal.careerStartDate.monthDifference();

final timeLineWidth =
    (totalMonthsPast * KDimensions.kMonthTimelineIndicatorWidth).toDouble();

class ThirdSection extends StatelessWidget {
  const ThirdSection(this.metrics, {super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: metrics.viewPortWidth * 0.1,
      children: [
        TextWidget(
          KString.experience,
          style: TextStyle(
            fontFamily: FontFamily.cindieMonoD,
            color: AppColors.white,
            fontSize: (metrics.viewPortWidth * 0.01).clamp(13, 40),
            height: 2,
            shadows: [
              const Shadow(
                color: Colors.blueGrey,
                blurRadius: 0.3,
                offset: Offset(-2, 2),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.white,
                ),
              ],
            ),
            TimeLineCalendar(
              offset: metrics.origin,
              metrics: metrics,
            ),
          ],
        ),
      ],
    );
  }
}

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
  bool enteredIntoCareerTimeLine = false;
  int currentYearIndex = 0;
  double currentYearStartOffset = 0;
  double? entryPoint;
  late int currentPointingMonth = 0;

  late final width = widget.metrics.viewPortWidth;
  late final monthCountOnCareerYear =
      KPersonal.careerStartDate.calculateMonthsPast();
  late final controller = ScrollController();

  @override
  void didUpdateWidget(covariant TimeLineCalendar oldWidget) {
    if (!controller.hasClients) return;
    _scroll();
    _calculateStartingPoint();
    _setEnteredToTimeLineState();
    _setCurrentYearIndex();
    _trackCurrentPointingMonth();
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
            itemCount: totalMonthsPast,
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
                  value: careerStartDateTime.year + currentYearIndex,
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

  Future<void> _scroll() async {
    controller.jumpTo(
      widget.offset.clamp(0, controller.position.maxScrollExtent),
    );
  }

  void _setEnteredToTimeLineState() {
    final hasEntered = (controller.offset >= entryPoint!);
    if (hasEntered == enteredIntoCareerTimeLine) return;
    enteredIntoCareerTimeLine = hasEntered;
  }

  double _yearLength(index) {
    return KDimensions.kMonthTimelineIndicatorWidth *
        monthCountOnCareerYear[index];
  }

  Future<void> _setCurrentYearIndex() async {
    if (!enteredIntoCareerTimeLine) return;
    final currentYearLength = _yearLength(currentYearIndex);
    final offsetToReachNextYear = currentYearStartOffset + currentYearLength;
    if (controller.offset > offsetToReachNextYear) {
      currentYearStartOffset = offsetToReachNextYear;
      ++currentYearIndex;
      return;
    }

    final previousYearStartOffset = offsetToReachNextYear - currentYearLength;
    if (controller.offset < previousYearStartOffset) {
      currentYearStartOffset =
          previousYearStartOffset - _yearLength(--currentYearIndex);
    }
  }

  Future<void> _trackCurrentPointingMonth() async {
    if (!enteredIntoCareerTimeLine) return;

    final offset = (controller.offset - entryPoint!).clamp(0, double.infinity);
    final month = (offset / KDimensions.kMonthTimelineIndicatorWidth);

    currentPointingMonth = DateTime(
      careerStartDateTime.year,
      careerStartDateTime.month + month.toInt(),
    ).month;
  }

  void _calculateStartingPoint() {
    if (entryPoint != null && width == widget.metrics.viewPortWidth) return;

    entryPoint = (widget.metrics.viewPortWidth / 2) +
        (KDimensions.kMonthTimelineIndicatorWidth / 2);
    currentYearStartOffset = entryPoint!;
  }
}

class MonthIndicatorWidget extends StatelessWidget {
  const MonthIndicatorWidget(this.month, {super.key});

  final int month;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: KDimensions.kMonthTimelineIndicatorWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const ColoredSizedBox(
              height: 50,
              width: 1,
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.white,
              child: TextWidget(
                month,
                style: const TextStyle(
                  fontSize: 5,
                  color: AppColors.black,
                  fontFamily: FontFamily.cindieMonoD,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    required this.child,
    required this.offset,
    required this.opacity,
    this.duration = KDurations.ms100,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final double opacity;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: offset,
      duration: duration,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        child: child,
      ),
    );
  }
}
