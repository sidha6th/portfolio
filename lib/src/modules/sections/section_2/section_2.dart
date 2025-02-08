import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/animated_floating_text_widget.dart';

class SecondSection extends StatelessWidget {
  const SecondSection(this._metrics, {super.key});

  final FreezeMetrics _metrics;

  static double freezedHeight(Size screenSize) =>
      (screenSize.width * 0.68).clamp(500, double.infinity);

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final offset = (_metrics.bottomDy - (_metrics.totalHeight * 0.05))
        .clamp(0, double.infinity);
    final dy = offset / (size.height / 2);
    final dx = offset / (size.width * 5);
    final angle = ((offset / size.height) / 70) * m.pi;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: size.width.clamp(0, 500),
            child: TextWidget(
              KPersonal.introduction,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.elgocThin,
              ),
              margin: const EdgeInsets.only(bottom: 30),
              textAlign: TextAlign.center,
            ),
          ),
          TextWidget(
            KString.whatDoIDo,
            style: const TextStyle(
              fontFamily: FontFamily.cindieMonoD,
              color: AppColors.white,
              fontSize: 20,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              TextWidget(
                KString.quote,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                style: TextStyle(
                  fontFamily: FontFamily.cindieMonoD,
                  color: AppColors.white,
                  fontSize: (_metrics.windowWidth * 0.01).clamp(13, 40),
                  height: 2,
                  shadows: [
                    const Shadow(
                      color: Colors.cyan,
                      blurRadius: 0.3,
                      offset: Offset(-2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedFloatingTextWidget(
                      text: 'Why can’t you just make an app overnight?',
                      metrics: _metrics,
                      initialDy: 0.5,
                      initialDx: -0.4,
                      angle: -angle,
                      dx: -dx,
                      dy: -dy,
                    ),
                    AnimatedFloatingTextWidget(
                      text: 'My computer is slow, can you fix it?',
                      metrics: _metrics,
                      initialDx: 0.5,
                      angle: -angle,
                      dx: dx,
                      dy: -dy,
                    ),
                    AnimatedFloatingTextWidget(
                      metrics: _metrics,
                      text: 'Why do apps need updates? Just make it perfect!',
                      initialDx: -0.4,
                      angle: angle,
                      dx: -dx,
                      dy: dy,
                    ),
                    AnimatedFloatingTextWidget(
                      metrics: _metrics,
                      text: 'So, coding is just copying from Google, right?',
                      angle: angle,
                      initialDy: -0.5,
                      initialDx: 0.4,
                      dx: dx,
                      dy: -dy,
                    ),
                    AnimatedFloatingTextWidget(
                      metrics: _metrics,
                      text: 'Can you add a feature that reads my mind?',
                      initialDx: 0.4,
                      initialDy: -1,
                      angle: -angle,
                      dx: dx,
                      dy: dy,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
