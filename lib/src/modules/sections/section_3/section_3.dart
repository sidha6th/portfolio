import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/extensions/date_time.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/state_management/notifier_builder.dart';
import 'package:sidharth/src/common/state_management/notifier_listener.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/experience_wheel_card_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/time_line_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/year_indicator_text_widget.dart';

class ThirdSection extends StatefulWidget implements StickableDelegate {
  const ThirdSection(this.index, {super.key});

  final int index;

  @override
  Widget get child => this;

  @override
  double minStickableHeight(Size windowSize) {
    return (Misc.careerTimeLineStickHeight +
        (windowSize.height / 2) +
        (windowSize.width.clamp(0, Misc.maxViewPortWidth) / 2));
  }

  @override
  bool get stick => true;

  @override
  bool get transformHitTests => false;

  @override
  State<ThirdSection> createState() => _ThirdSectionState();

  @override
  bool notifyOnlyWhen(StickyMetricsState prev, StickyMetricsState curr) {
    return curr.currentIndex < 3 && curr.currentIndex >= 1;
  }
}

class _ThirdSectionState extends State<ThirdSection> {
  late final _arrow = SvgPicture.asset(Assets.images.svg.arrowDown);

  final _careerCardExtend = 100.0;
  late final _now = DateTime.now();
  late var _size = context.screenSize;
  late var _currentDate = KPersonal.careerStartDate;
  late final _timeLineController = ScrollController();
  late final _listWheelController = ScrollController();
  final _careerStartDateTime = KPersonal.careerStartDate;
  late var _halfOfScreenHeight = _size.height / 2;
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
  void didChangeDependencies() {
    _updateWidth();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirdSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_size == context.screenSize) return;
    _updateWidth();
  }

  @override
  void dispose() {
    _timeLineController.dispose();
    _listWheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHeightLessThanMin = _size.height < 500;

    return NotifierListener<StickyMetricsNotifier, StickyMetricsState>(
      listenWhen: widget.notifyOnlyWhen,
      listener: (state) {
        if (!_timeLineController.hasClients) return;
        _scroll(state.metricsAt(widget.index));
        final focusPoint =
            _timeLineController.offset -
            (_halfOfWindowWidth + _halfOfMonthIndicatorWidth);
        _enteredIntoCareerTimeLine = focusPoint >= 0;

        if (!_enteredIntoCareerTimeLine) return;

        final indicatorPos = (focusPoint / Misc.kMonthIndicatorWidth);
        final date = _datetime(indicatorPos);
        if (date == _currentDate) return;
        _currentDate = date;
        _animateCareerCard();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: isHeightLessThanMin ? 0 : (_size.height * 0.1),
        children: [
          SizedBox(
            height: isHeightLessThanMin
                ? 20
                : (_size.height * 0.05).clamp(20, double.infinity),
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
              NotifierBuilder<StickyMetricsNotifier, StickyMetricsState>(
                buildWhen: widget.notifyOnlyWhen,
                builder: (context, state) {
                  return YearIndicatorTextWidget(
                    year: _currentDate.year,
                    enteredIntoCareerTimeLine: _enteredIntoCareerTimeLine,
                  );
                },
              ),
            ],
          ),
          ExperienceWheelCard(
            careerCardExtend: _careerCardExtend,
            listWheelController: _listWheelController,
          ),
        ],
      ),
    );
  }

  void _animateCareerCard() {
    final career = KPersonal.careerJourney[_careerWheelIndex];
    final begin = career.begin;
    final end = career.end ?? DateTime.now();
    if (_currentDate.isAfter(begin) && _currentDate.isBefore(end)) {
      return;
    }

    _careerWheelIndex =
        (_currentDate.sameOrAfter(end)
                ? _careerWheelIndex + 1
                : _careerWheelIndex - 1)
            .clamp(0, KPersonal.careerJourney.length - 1);

    final newOffset = _careerCardExtend * _careerWheelIndex;

    _listWheelController.animateTo(
      newOffset,
      duration: KDurations.ms200,
      curve: Curves.slowMiddle,
    );
  }

  void _updateWidth() {
    _size = context.screenSize;
    _clampedWindowWidth = _size.width.clamp(0.0, Misc.maxViewPortWidth);
    _halfOfWindowWidth = _clampedWindowWidth / 2;
    _halfOfScreenHeight = _size.height / 2;
    _calcLeftFillerCount();
    _calcRightFillerCount();
  }

  void _calcLeftFillerCount() {
    final countAsDouble = _clampedWindowWidth / Misc.kMonthIndicatorWidth;
    _leftMonthFillerCount = countAsDouble.toInt();
    _leftSpacing =
        (_clampedWindowWidth -
            (_leftMonthFillerCount * Misc.kMonthIndicatorWidth)) +
        (countAsDouble - _leftMonthFillerCount);
  }

  void _calcRightFillerCount() {
    final countAsDouble = _halfOfWindowWidth / Misc.kMonthIndicatorWidth;
    _rightMonthFillerCount = countAsDouble.toInt();
    _rightSpacing =
        (_halfOfWindowWidth -
            (_rightMonthFillerCount * Misc.kMonthIndicatorWidth)) +
        (countAsDouble - _rightMonthFillerCount);
  }

  DateTime _datetime(double indicatorPos) {
    return DateTime(
      _careerStartDateTime.year,
      _careerStartDateTime.month + indicatorPos.toInt(),
    );
  }

  void _scroll(FreezeMetrics metrics) {
    _timeLineController.jumpTo(
      (metrics.bottomDy - _halfOfScreenHeight).clamp(
        0,
        _timeLineController.position.maxScrollExtent,
      ),
    );
  }
}
