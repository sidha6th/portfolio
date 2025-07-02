import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_description_widget.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_slider.dart';

class SkillsSmallScreenView extends StatelessWidget {
  const SkillsSmallScreenView({
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
    final origin = metrics.topDy.clamp(0.0, metrics.totalHeight);
    final double descriptionOffset = normalize(
      value: origin,
      end: metrics.totalHeight,
    );

    return Stack(
      children: [
        SizedBox(
          width: context.screenSize.width,
          height: context.screenSize.height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.screenSize.height * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              ),
              Positioned(
                bottom: (metrics.totalHeight * 0.02).clamp(30, 100),
                right: 0,
                child: AnimatedSlide(
                  offset: Offset(0, descriptionOffset),
                  duration: KDurations.ms100,
                  child: SkillsDescriptionTextWidget(
                    fontSize: descriptionFontSize,
                    maxWidth: context.screenSize.width.clamp(0, 300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
