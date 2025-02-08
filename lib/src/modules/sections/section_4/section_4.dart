import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/views/desktop_view.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/views/small_screen_view.dart';

class FourthSection extends StatelessWidget {
  const FourthSection(
    this._metrics, {
    this.maxCardWidth = 400.0,
    super.key,
  });

  final FreezeMetrics _metrics;
  final double maxCardWidth;

  @override
  Widget build(BuildContext context) {
    final slideStartDelay = _metrics.windowHeight * 0.4;
    final lessThanTabViewPort = _metrics.windowWidth < 740;
    final valueUsingAsWidth = !lessThanTabViewPort
        ? _metrics.windowWidth * 0.2
        : _metrics.windowHeight * 0.2;
    final minWidth = !lessThanTabViewPort ? 150.0 : 100.0;
    late final skillCardWidth =
        (valueUsingAsWidth).clamp(minWidth, maxCardWidth);
    final fontSize = (_metrics.minWindowSide * 0.04).clamp(4.0, 20.0);

    if (lessThanTabViewPort) {
      return SkillsSmallScreenView(
        metrics: _metrics,
        cardWidth: skillCardWidth,
        descriptionFontSize: fontSize,
        slideStartDelay: slideStartDelay,
      );
    }
    return SkillsDesktopViewWidget(
      metrics: _metrics,
      cardWidth: skillCardWidth,
      descriptionFontSize: fontSize,
      slideStartDelay: slideStartDelay,
    );
  }

  static double freezedHeight(Size screenSize) {
    final lessThanTabViewPort = screenSize.width < 740;
    final valueUsingAsWidth =
        !lessThanTabViewPort ? screenSize.width * 0.2 : screenSize.height * 0.2;
    final minWidth = !lessThanTabViewPort ? 200.0 : 100.0;
    late final singleCardHeight =
        (valueUsingAsWidth).clamp(minWidth, 400.0) + 30;
    final delay = screenSize.height * 0.4;
    final cardsCount = KPersonal.skillsSets.first.length;
    final separatorsHeight = (cardsCount - 1) * 20;
    final cardsHeight = (cardsCount * singleCardHeight);
    return (cardsHeight + delay + separatorsHeight) - (screenSize.width * 0.5);
  }
}
