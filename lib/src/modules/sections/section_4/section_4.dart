import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/views/large_screen_view.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/views/small_screen_view.dart';

class FourthSection extends StatefulWidget {
  const FourthSection(
    this._metrics, {
    super.key,
  });

  final FreezeMetrics _metrics;
  static const maxCardWidth = 250.0;

  @override
  State<FourthSection> createState() => _FourthSectionState();

  static double freezedHeight(Size screenSize) {
    final lessThanTabViewPort = _isLessThanTabView(screenSize.width);
    final delay = _slideStartDelay(screenSize.height);
    final minWidth = _cardMinWidth(
      screenSize.width,
      isLessThanTabView: lessThanTabViewPort,
      maxCardWidth: FourthSection.maxCardWidth,
    );

    late final singleCardHeight =
        _singleCardWidth(screenSize.width, minWidth) + 30;
    final cardsCount = KPersonal.skillsSets.first.length;

    final separatorsHeight = (cardsCount - 1) * 20;
    final cardsHeight = (cardsCount * singleCardHeight);
    return (cardsHeight + delay + separatorsHeight) - (screenSize.width * 0.5);
  }

  static bool _isLessThanTabView(double width) => width < 740;
  static double _slideStartDelay(double height) => height * 0.4;
  static double _singleCardWidth(double width, double minWidth) =>
      (width * 0.2).clamp(minWidth, FourthSection.maxCardWidth);
  static double _cardMinWidth(
    double windowWidth, {
    required bool isLessThanTabView,
    required double maxCardWidth,
  }) {
    if (!isLessThanTabView) return 150.0;
    return (windowWidth * 0.35).clamp(0.0, maxCardWidth);
  }
}

class _FourthSectionState extends State<FourthSection> {
  late var _size = widget._metrics.windowSize;
  late var _slideStartDelay = FourthSection._slideStartDelay(_size.height);
  late var _lessThanTabViewPort = FourthSection._isLessThanTabView(_size.width);
  late var _fontSize = fontSize;
  late var _skillCardWidth =
      FourthSection._singleCardWidth(_size.width, _skillCardMinWidth);
  late var _skillCardMinWidth = FourthSection._cardMinWidth(
    _size.width,
    maxCardWidth: FourthSection.maxCardWidth,
    isLessThanTabView: _lessThanTabViewPort,
  );

  double get fontSize =>
      (widget._metrics.minWindowSide * 0.05).clamp(8.0, 20.0);

  @override
  void didUpdateWidget(covariant FourthSection oldWidget) {
    widget._metrics.whenWindowResized(_size, _whenResize);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_lessThanTabViewPort) {
      return SkillsSmallScreenView(
        metrics: widget._metrics,
        cardWidth: _skillCardWidth,
        descriptionFontSize: _fontSize,
        slideStartDelay: _slideStartDelay,
      );
    }

    return SkillsLargeScreenViewWidget(
      metrics: widget._metrics,
      cardWidth: _skillCardWidth,
      descriptionFontSize: _fontSize,
      slideStartDelay: _slideStartDelay,
    );
  }

  void _whenResize(Size windowsSize) {
    _size = windowsSize;
    _lessThanTabViewPort = FourthSection._isLessThanTabView(_size.width);
    _skillCardMinWidth = FourthSection._cardMinWidth(
      _size.width,
      maxCardWidth: FourthSection.maxCardWidth,
      isLessThanTabView: _lessThanTabViewPort,
    );
    _slideStartDelay = FourthSection._slideStartDelay(_size.height);
    _skillCardWidth =
        FourthSection._singleCardWidth(_size.width, _skillCardMinWidth);
    _fontSize = fontSize;
  }
}
