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
          SizedBox(
            height: size.width * 0.4,
            child: Stack(
              children: [
                AnimatingQuestions(
                  metrics: metrics,
                  text:
                      'Oh, you work with Flutter? Is that a game or something?',
                  dx: -0.4,
                  dy: -6,
                  angleBuilder: _dy,
                ),
                AnimatingQuestions(
                  metrics: metrics,
                  text: 'Can you make me an app for free?',
                  dx: 1.1,
                  dy: -2,
                  angleBuilder: (dy) => -_dy(dy),
                ),
                AnimatingQuestions(
                  metrics: metrics,
                  text: 'Wait, why do apps keep crashing—can’t you fix that?',
                  dx: 0.1,
                  dy: -12,
                  angleBuilder: (dy) => -_dy(dy) + 0.01,
                ),
                AnimatingQuestions(
                  metrics: metrics,
                  text: 'So, do you just press a bunch of keys all day?',
                  dx: 0,
                  dy: -19,
                  angleBuilder: (dy) => -_dy(dy) * 0.1,
                ),
                AnimatingQuestions(
                  metrics: metrics,
                  text: 'Can you add a feature that reads my mind?',
                  dx: 0.5,
                  dy: -22,
                  angleBuilder: _dy,
                ),
              ],
            ),
          ),
          TextWidget(
            Personal.quote,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            style: const TextStyle(
              fontFamily: FontFamily.cindieMonoD,
              color: AppColors.white,
              fontSize: 10,
              height: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  double _dy(double dy) {
    final turns = (dy / 100) * 0.6;
    return turns;
  }
}

class AnimatingQuestions extends StatefulWidget {
  const AnimatingQuestions({
    required this.metrics,
    required this.text,
    required this.dx,
    required this.dy,
    required this.angleBuilder,
    this.alignment = Alignment.center,
    super.key,
  });

  final FreezedMetrics metrics;
  final String text;
  final double dx;
  final double dy;
  final double Function(double dy) angleBuilder;
  final Alignment alignment;

  @override
  State<AnimatingQuestions> createState() => _AnimatingQuestionsState();
}

class _AnimatingQuestionsState extends State<AnimatingQuestions>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dy = _dy(
      context.screenHeight * 0.3,
      delay: context.screenHeight * 0.4,
    );
    return AnimatedRotation(
      alignment: widget.alignment,
      turns: widget.angleBuilder(dy),
      duration: KDurations.ms100,
      child: AnimatedSlide(
        offset: Offset(
          widget.dx,
          -(widget.dy + dy) * 0.2,
        ),
        duration: KDurations.ms100,
        child: BlueGradientTextBoxWidget(widget.text),
      ),
    );
  }

  double _dy(double max, {double delay = 0}) {
    max = max + delay;
    return (widget.metrics.dyFromOrigin - delay).clamp(0, max) / 100;
  }

  @override
  bool get wantKeepAlive => true;
}
