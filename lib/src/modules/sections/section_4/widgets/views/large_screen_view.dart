import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_description_widget.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_slider.dart';

class SkillsLargeScreenViewWidget extends StatelessWidget {
  const SkillsLargeScreenViewWidget({
    required this.metrics,
    required this.cardWidth,
    required this.slideStartDelay,
    required this.descriptionFontSize,
    super.key,
  });

  final double cardWidth;
  final FreezeMetrics metrics;
  final double slideStartDelay;
  final double descriptionFontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const Spacer(),
            SkillsDescriptionTextWidget(fontSize: descriptionFontSize),
            const Spacer(),
            VerticalSkillSlides.vertical(
              metrics: metrics,
              cardWidth: cardWidth,
              slideStartDelay: slideStartDelay,
              icons: KPersonal.skillsSets.first,
            ),
            const SizedBox(width: 20),
            VerticalSkillSlides.vertical(
              reverse: true,
              metrics: metrics,
              cardWidth: cardWidth,
              slideStartDelay: slideStartDelay,
              icons: KPersonal.skillsSets.last,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
