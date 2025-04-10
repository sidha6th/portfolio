import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/animated_floating_text_widget.dart';

class SecondSection extends StatefulWidget {
  const SecondSection(this._metrics, {super.key});

  final FreezeMetrics _metrics;

  static double freezedHeight(Size screenSize) => screenSize.height;

  @override
  State<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends State<SecondSection> {
  late var _size = widget._metrics.windowSize;
  late var _maxOffset = widget._metrics.totalHeight + _size.height;
  late var _dy = 1.0;
  late var _dx = 1.0;
  late var _angle = 1.0;

  @override
  void didUpdateWidget(covariant SecondSection oldWidget) {
    widget._metrics.whenWindowResized(_size, _whenResize);
    if (widget._metrics.bottomDy >= _maxOffset) return;
    _calcTransformMetrics();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: _size.width.clamp(0, Misc.maxViewPortWidth),
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
          Column(
            children: [
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
                      fontSize:
                          (widget._metrics.windowWidth * 0.01).clamp(13, 40),
                      height: 2,
                      shadows: [
                        const Shadow(
                          color: AppColors.cyan,
                          blurRadius: 0.3,
                          offset: Offset(-2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedFloatingTextWidget(
                        text: 'Why can’t you just make an app overnight?',
                        metrics: widget._metrics,
                        initialDy: 1.5,
                        initialDx: -0.4,
                        angle: -_angle,
                        dx: -_dx,
                        dy: -_dy,
                      ),
                      AnimatedFloatingTextWidget(
                        text: 'My computer is slow, can you fix it?',
                        metrics: widget._metrics,
                        initialDx: 0.3,
                        initialDy: -0.2,
                        angle: -_angle,
                        dx: _dx,
                        dy: -_dy,
                      ),
                      AnimatedFloatingTextWidget(
                        metrics: widget._metrics,
                        text: 'Why do apps need updates? Just make it perfect!',
                        initialDx: -0.3,
                        initialDy: 0.8,
                        angle: _angle,
                        dx: -_dx,
                        dy: _dy,
                      ),
                      AnimatedFloatingTextWidget(
                        metrics: widget._metrics,
                        text: 'So, coding is just copying from Google, right?',
                        angle: _angle,
                        initialDy: -0.5,
                        initialDx: 0.4,
                        dx: _dx,
                        dy: -_dy,
                      ),
                      AnimatedFloatingTextWidget(
                        metrics: widget._metrics,
                        text: 'Can you add a feature that reads my mind?',
                        initialDx: 0.4,
                        initialDy: -1,
                        angle: -_angle,
                        dx: _dx,
                        dy: _dy,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _whenResize(Size windowsSize) {
    _size = windowsSize;
    _maxOffset = widget._metrics.totalHeight + _size.height;
  }

  Future<void> _calcTransformMetrics() async {
    final offset = normalize(
      value: widget._metrics.bottomDy - (_size.height * 0.1),
      end: _maxOffset,
    );

    _dy = offset * 2.5;
    _dx = offset / 2.5;
    _angle = offset * 0.15;
  }
}
