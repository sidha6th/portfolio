import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_description_widget.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_slider.dart';

class SkillsDesktopViewWidget extends StatelessWidget {
  const SkillsDesktopViewWidget({
    required this.metrics,
    required this.cardWidth,
    required this.slideStartDelay,
    required this.descriptionFontSize,
    super.key,
  });

  final double cardWidth;
  final double slideStartDelay;
  final FreezeMetrics metrics;
  final double descriptionFontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          spacing: 20,
          children: [
            const Spacer(),
            SkillsDescriptionTextWidget(fontSize: descriptionFontSize),
            const Spacer(),
            VerticalSkillSlides.vertical(
              slideStartDelay: slideStartDelay,
              cardWidth: cardWidth,
              metrics: metrics,
              icons: KPersonal.skillsSets.first,
            ),
            VerticalSkillSlides.vertical(
              slideStartDelay: slideStartDelay,
              cardWidth: cardWidth,
              metrics: metrics,
              reverse: true,
              icons: KPersonal.skillsSets.last,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
