import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_description_widget.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_slider.dart';

class SkillsSmallScreenView extends StatelessWidget {
  const SkillsSmallScreenView({
    required this.slideStartDelay,
    required this.cardWidth,
    required this.metrics,
    required this.descriptionFontSize,
    super.key,
  });

  final double slideStartDelay;
  final double cardWidth;
  final FreezeMetrics metrics;
  final double descriptionFontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: metrics.windowHeight,
          width: metrics.windowWidth,
          child: Padding(
            padding: EdgeInsets.only(top: metrics.windowHeight * 0.1),
            child: Column(
              children: [
                VerticalSkillSlides.horizontal(
                  slideStartDelay: slideStartDelay,
                  cardWidth: cardWidth,
                  metrics: metrics,
                  icons: KPersonal.skillsSets.first,
                ),
                const SizedBox(height: 20),
                VerticalSkillSlides.horizontal(
                  slideStartDelay: slideStartDelay,
                  reverse: true,
                  cardWidth: cardWidth,
                  metrics: metrics,
                  icons: KPersonal.skillsSets.last,
                ),
                const Spacer(),
                SkillsDescriptionTextWidget(fontSize: descriptionFontSize),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
