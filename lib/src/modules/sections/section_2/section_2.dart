import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/animated_floating_text_widget.dart';
import 'package:syncx/syncx.dart';

class SecondSection extends StatefulWidget implements StickableDelegate {
  const SecondSection(this.index, {super.key});

  final int index;

  @override
  double height(Size windowSize) => windowSize.height;

  @override
  Widget get child => this;

  @override
  bool get stick => false;

  @override
  bool get transformHitTests => false;

  @override
  State<SecondSection> createState() => _SecondSectionState();

  @override
  bool notifyOnlyWhen(_, StickyMetricsState curr) {
    return curr.currentIndex < 2;
  }
}

class _SecondSectionState extends State<SecondSection> {
  late var _size = context.screenSize;
  late var _maxOffset = stickableHeight + _size.height;
  late var _metrics = FreezeMetrics.zero(stickableHeight);
  late var stickableHeight = widget.height(context.screenSize);
  late var _dy = 1.0;
  late var _dx = 1.0;
  late var _angle = 1.0;

  @override
  void didUpdateWidget(covariant SecondSection oldWidget) {
    _whenResize(context.screenSize);
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
                      fontSize: (_size.width * 0.01).clamp(13, 40),
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
                  StatefulBuilder(
                    builder: (context, setState) =>
                        NotifierListener<
                          StickyMetricsNotifier,
                          StickyMetricsState
                        >(
                          listenWhen: widget.notifyOnlyWhen,
                          listener: (state) {
                            _metrics = state.metricsAt(widget.index);
                            setState(_calcTransformMetrics);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedFloatingTextWidget(
                                text:
                                    'Why can’t you just make an app overnight?',
                                initialDy: 1.8,
                                initialDx: -0.4,
                                angle: -_angle,
                                dx: -_dx,
                                dy: -_dy,
                              ),
                              AnimatedFloatingTextWidget(
                                text: 'My computer is slow, can you fix it?',
                                initialDx: 0.3,
                                initialDy: -0.2,
                                angle: -_angle,
                                dx: _dx,
                                dy: -_dy,
                              ),
                              AnimatedFloatingTextWidget(
                                text:
                                    'Why do apps need updates? Just make it perfect!',
                                initialDx: -0.3,
                                initialDy: 0.8,
                                angle: _angle,
                                dx: -_dx,
                                dy: _dy,
                              ),
                              AnimatedFloatingTextWidget(
                                text:
                                    'So, coding is just copying from Google, right?',
                                angle: _angle,
                                initialDy: -0.5,
                                initialDx: 0.4,
                                dx: _dx,
                                dy: -_dy,
                              ),
                              AnimatedFloatingTextWidget(
                                text:
                                    'Can you add a feature that reads my mind?',
                                initialDx: 0.4,
                                initialDy: -1,
                                angle: -_angle,
                                dx: _dx,
                                dy: _dy,
                              ),
                            ],
                          ),
                        ),
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
    _maxOffset = _metrics.totalHeight + _size.height;
    _calcTransformMetrics();
  }

  void _calcTransformMetrics() {
    final offset = normalize(
      value: _metrics.bottomDy - (_size.height * 0.01),
      end: _maxOffset,
    );

    _dy = offset * 2.5;
    _dx = offset / 2.5;
    _angle = offset * 0.15;
  }
}
