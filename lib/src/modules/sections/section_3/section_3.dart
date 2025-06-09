import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/experience_wheel_card_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/time_line_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/year_indicator_text_widget.dart';

class ThirdSection extends StatefulWidget {
  const ThirdSection(
    this._metrics, {
    super.key,
  });

  final FreezeMetrics _metrics;

  static double freezedHeight(Size screenSize) {
    return (Misc.careerTimeLineStickHeight +
        (screenSize.height / 2) +
        (screenSize.width.clamp(0, Misc.maxViewPortWidth) / 2));
  }

  @override
  State<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection> {
  late final _arrow = const Icon(
    Icons.arrow_drop_down,
    color: AppColors.offWhite,
  );

  final _careerCardExtend = 100.0;
  late final _now = DateTime.now();
  late var _size = widget._metrics.windowSize;
  late var _currentDate = KPersonal.careerStartDate;
  late final _timeLineController = ScrollController();
  late final _listWheelController = ScrollController();
  final _careerStartDateTime = KPersonal.careerStartDate;
  late var halfOfScreenHeight = widget._metrics.windowHeight / 2;
  late final _halfOfMonthIndicatorWidth = Misc.kMonthIndicatorWidth / 2;

  double _leftSpacing = 0;
  double _rightSpacing = 0;
  double _halfOfWindowWidth = 0;
  double _clampedWindowWidth = 0;
  int _careerWheelIndex = 0;
  int _leftMonthFillerCount = 0;
  int _rightMonthFillerCount = 0;
  bool _enteredIntoCareerTimeLine = false;

  @override
  void initState() {
    _updateWidth(_size);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ThirdSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._metrics.whenWindowResized(_size, _updateWidth);
    if (!_timeLineController.hasClients) return;
    _scroll();

    final focusPoint = _timeLineController.offset -
        (_halfOfWindowWidth + _halfOfMonthIndicatorWidth);
    _enteredIntoCareerTimeLine = focusPoint >= 0;

    if (!_enteredIntoCareerTimeLine) return;

    final indicatorPos = (focusPoint / Misc.kMonthIndicatorWidth);
    _currentDate = _datetime(indicatorPos);
    _animateCareerCard();
  }

  @override
  void dispose() {
    _timeLineController.dispose();
    _listWheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHeightLessThanMin = widget._metrics.windowHeight < 500;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: isHeightLessThanMin ? 0 : (widget._metrics.windowHeight * 0.1),
      children: [
        SizedBox(
          height: isHeightLessThanMin
              ? 20
              : (widget._metrics.windowHeight * 0.05)
                  .clamp(20, double.infinity),
        ),
        Column(
          children: [
            _arrow,
            TimeLineWidget(
              now: _now,
              leftSpacing: _leftSpacing,
              rightSpacing: _rightSpacing,
              controller: _timeLineController,
              clampedWidth: _clampedWindowWidth,
              careerStartDateTime: _careerStartDateTime,
              leftMonthFillerCount: _leftMonthFillerCount,
              rightMonthFillerCount: _rightMonthFillerCount,
            ),
            YearIndicatorTextWidget(
              year: _currentDate.year,
              enteredIntoCareerTimeLine: _enteredIntoCareerTimeLine,
            ),
          ],
        ),
        ExperienceWheelCard(
          metrics: widget._metrics,
          currentDate: _currentDate,
          careerCardExtend: _careerCardExtend,
          careerWheelIndex: _careerWheelIndex,
          listWheelController: _listWheelController,
          changeWheelIndex: changeCurrentCareerCardIndex,
        ),
      ],
    );
  }

  void changeCurrentCareerCardIndex(int newIndex) {
    _careerWheelIndex = newIndex;
  }

  Future<void> _animateCareerCard() async {
    final newOffset = _careerCardExtend * _careerWheelIndex;
    if (_listWheelController.position.pixels == newOffset) return;
    unawaited(
      _listWheelController.animateTo(
        newOffset,
        duration: KDurations.ms200,
        curve: Curves.slowMiddle,
      ),
    );
  }

  Future<void> _updateWidth(Size size) async {
    _size = size;
    _clampedWindowWidth = size.width.clamp(0.0, Misc.maxViewPortWidth);
    _halfOfWindowWidth = _clampedWindowWidth / 2;
    halfOfScreenHeight = widget._metrics.windowHeight / 2;
    unawaited(Future.any([_calcLeftFillerCount(), _calcRightFillerCount()]));
  }

  Future<void> _calcLeftFillerCount() async {
    final countAsDouble = _clampedWindowWidth / Misc.kMonthIndicatorWidth;
    _leftMonthFillerCount = countAsDouble.toInt();
    _leftSpacing = (_clampedWindowWidth -
            (_leftMonthFillerCount * Misc.kMonthIndicatorWidth)) +
        (countAsDouble - _leftMonthFillerCount);
  }

  Future<void> _calcRightFillerCount() async {
    final countAsDouble = _halfOfWindowWidth / Misc.kMonthIndicatorWidth;
    _rightMonthFillerCount = countAsDouble.toInt();
    _rightSpacing = (_halfOfWindowWidth -
            (_rightMonthFillerCount * Misc.kMonthIndicatorWidth)) +
        (countAsDouble - _rightMonthFillerCount);
  }

  DateTime _datetime(double indicatorPos) {
    return DateTime(
      _careerStartDateTime.year,
      _careerStartDateTime.month + indicatorPos.toInt(),
    );
  }

  Future<void> _scroll() async {
    _timeLineController.jumpTo(
      (widget._metrics.bottomDy - halfOfScreenHeight).clamp(
        0,
        _timeLineController.position.maxScrollExtent,
      ),
    );
  }
}
