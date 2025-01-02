import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/data/personal.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/blue_gradient_text_box_widget.dart';

class SecondSection extends StatelessWidget {
  const SecondSection(this.metrics, {super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final offset = (metrics.origin - (metrics.childHeight * 0.05))
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
              Personal.introduction,
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
            Personal.whatDoIDo,
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
                Personal.quote,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                style: TextStyle(
                  fontFamily: FontFamily.cindieMonoD,
                  color: AppColors.white,
                  fontSize: (metrics.viewPortWidth * 0.01).clamp(13, 40),
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
                    AnimatingQuestions(
                      text:
                          'Oh, you work with Flutter? Is that a game or something?',
                      metrics: metrics,
                      initialDy: 0.5,
                      initialDx: -0.4,
                      angle: -angle,
                      dx: -dx,
                      dy: -dy,
                    ),
                    AnimatingQuestions(
                      text: 'Can you make me an app for free?',
                      metrics: metrics,
                      initialDx: 0.5,
                      angle: -angle,
                      dx: dx,
                      dy: -dy,
                    ),
                    AnimatingQuestions(
                      metrics: metrics,
                      text:
                          'Wait, why do apps keep crashing—can’t you fix that?',
                      initialDx: -0.4,
                      angle: angle,
                      dx: -dx,
                      dy: dy,
                    ),
                    AnimatingQuestions(
                      metrics: metrics,
                      text: 'So, do you just press a bunch of keys all day?',
                      angle: angle,
                      initialDy: -0.5,
                      initialDx: 0.4,
                      dx: dx,
                      dy: -dy,
                    ),
                    AnimatingQuestions(
                      metrics: metrics,
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

class AnimatingQuestions extends StatefulWidget {
  const AnimatingQuestions({
    required this.metrics,
    required this.text,
    required this.angle,
    required this.dx,
    required this.dy,
    this.initialDy = 0,
    this.initialDx = 0,
    this.initialAngle = 0,
    this.alignment = Alignment.center,
    super.key,
  });

  final FreezedMetrics metrics;
  final String text;
  final double angle;
  final double dy;
  final double dx;
  final double initialDy;
  final double initialDx;
  final double initialAngle;
  final Alignment alignment;

  @override
  State<AnimatingQuestions> createState() => _AnimatingQuestionsState();
}

class _AnimatingQuestionsState extends State<AnimatingQuestions> {
  late final child = BlueGradientTextBoxWidget(widget.text);

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: Offset(
        widget.initialDx + widget.dx,
        widget.initialDy + widget.dy,
      ),
      duration: KDurations.ms50,
      child: AnimatedRotation(
        turns: widget.initialAngle + widget.angle,
        alignment: widget.alignment,
        duration: KDurations.ms50,
        filterQuality: FilterQuality.low,
        child: child,
      ),
    );
  }
}
