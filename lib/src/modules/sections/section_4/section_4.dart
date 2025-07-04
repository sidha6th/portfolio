import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/extensions/size.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/state_management/notifier_builder.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/views/large_screen_view.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/views/small_screen_view.dart';

class FourthSection extends StatefulWidget implements StickableDelegate {
  const FourthSection(this.index, {super.key});

  final int index;
  final maxCardWidth = 250.0;

  @override
  Widget get child => this;

  bool _isLessThanTabView(double width) => width < 740;
  double _slideStartDelay(double height) => height * 0.4;
  double _singleCardWidth(double width, double minWidth) =>
      (width * 0.2).clamp(minWidth, maxCardWidth);
  double _cardMinWidth(
    double windowWidth, {
    required bool isLessThanTabView,
    required double maxCardWidth,
  }) {
    if (!isLessThanTabView) return 150.0;
    return (windowWidth * 0.35).clamp(0.0, maxCardWidth);
  }

  @override
  double height(Size windowSize) {
    final lessThanTabViewPort = _isLessThanTabView(windowSize.width);
    final delay = _slideStartDelay(windowSize.height);
    final minWidth = _cardMinWidth(
      windowSize.width,
      isLessThanTabView: lessThanTabViewPort,
      maxCardWidth: maxCardWidth,
    );

    late final singleCardHeight =
        _singleCardWidth(windowSize.width, minWidth) + 30;
    final cardsCount = KPersonal.skillsSets.first.length;

    final separatorsHeight = (cardsCount - 1) * 20;
    final cardsHeight = (cardsCount * singleCardHeight);
    return (cardsHeight + delay + separatorsHeight) - (windowSize.width * 0.5);
  }

  @override
  bool get stick => true;

  @override
  bool get transformHitTests => true;

  @override
  bool notifyOnlyWhen(StickyMetricsState prev, StickyMetricsState curr) {
    return prev.currentIndex < 5 && curr.currentIndex >= 2;
  }

  @override
  State<FourthSection> createState() => _FourthSectionState();
}

class _FourthSectionState extends State<FourthSection> {
  late var _size = context.screenSize;
  late var _slideStartDelay = widget._slideStartDelay(_size.height);
  late var _lessThanTabViewPort = widget._isLessThanTabView(_size.width);
  late var _fontSize = fontSize;
  late var _skillCardWidth = widget._singleCardWidth(
    _size.width,
    _skillCardMinWidth,
  );
  late var _skillCardMinWidth = widget._cardMinWidth(
    _size.width,
    maxCardWidth: widget.maxCardWidth,
    isLessThanTabView: _lessThanTabViewPort,
  );

  double get fontSize => (_size.min * 0.05).clamp(8.0, 20.0);

  @override
  Widget build(BuildContext context) {
    _whenResize(context.screenSize);
    if (_lessThanTabViewPort) {
      return NotifierBuilder<StickyMetricsNotifier, StickyMetricsState>(
        buildWhen: widget.notifyOnlyWhen,
        builder: (context, state) {
          return SkillsSmallScreenView(
            cardWidth: _skillCardWidth,
            descriptionFontSize: _fontSize,
            slideStartDelay: _slideStartDelay,
            metrics: state.metricsAt(widget.index),
          );
        },
      );
    }

    return NotifierBuilder<StickyMetricsNotifier, StickyMetricsState>(
      buildWhen: widget.notifyOnlyWhen,
      builder: (context, state) {
        return SkillsLargeScreenViewWidget(
          cardWidth: _skillCardWidth,
          descriptionFontSize: _fontSize,
          slideStartDelay: _slideStartDelay,
          metrics: state.metricsAt(widget.index),
        );
      },
    );
  }

  void _whenResize(Size windowsSize) {
    if (_size == windowsSize) return;
    _size = windowsSize;
    _lessThanTabViewPort = widget._isLessThanTabView(_size.width);
    _skillCardMinWidth = widget._cardMinWidth(
      _size.width,
      maxCardWidth: widget.maxCardWidth,
      isLessThanTabView: _lessThanTabViewPort,
    );
    _slideStartDelay = widget._slideStartDelay(_size.height);
    _skillCardWidth = widget._singleCardWidth(_size.width, _skillCardMinWidth);
    _fontSize = fontSize;
  }
}
