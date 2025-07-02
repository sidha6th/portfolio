import 'dart:math' show max;

import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/extensions/size.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/state_management/notifier_consumer.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:sidharth/src/modules/sections/section_5/widgets/launchable_text_widget.dart';
import 'package:sidharth/src/modules/sections/section_5/widgets/made_with_flutter_indicating_widget.dart';

class FifthSection extends StatefulWidget implements StickableDelegate {
  const FifthSection(this.index, {super.key});

  final int index;

  @override
  Widget get child => this;

  @override
  double minStickableHeight(Size windowSize) {
    return max(windowSize.width, windowSize.height) + (windowSize.height / 2);
  }

  @override
  bool get stick => true;

  @override
  bool get transformHitTests => true;

  @override
  State<FifthSection> createState() => _FifthSectionState();

  @override
  bool notifyOnlyWhen(_, StickyMetricsState curr) {
    return curr.currentIndex >= index - 1;
  }
}

class _FifthSectionState extends State<FifthSection> {
  double _offsetToScroll = 0;
  late var _size = context.screenSize;
  final _scrollController = ScrollController();
  late var _metrics = FreezeMetrics.zero(widget.minStickableHeight(_size));
  late var socialMediaTextWidgets = _getSocialMediaTextWidgets();

  List _getSocialMediaTextWidgets() {
    return List.generate(KPersonal.social.length, (index) {
      final social = KPersonal.social[index];
      return LaunchableTextWidget(
        text: social.label,
        url: social.urlAsString,
        width: context.screenSize.width,
      );
    }, growable: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _whenResize(context.screenSize);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        NotifierConsumer<StickyMetricsNotifier, StickyMetricsState>(
          listenWhen: widget.notifyOnlyWhen,
          listener: (state) {
            _metrics = state.metricsAt(widget.index);
            if (!_scrollController.hasClients) return;
            _scroll();
          },
          buildWhen: widget.notifyOnlyWhen,
          builder: (context, state) {
            late var bottomDy = state.metricsAt(widget.index).bottomDy;
            final origin = bottomDy - (_size.height / 2);
            final height = origin.clamp(10.0, _size.height);
            final width = origin.clamp(10.0, _size.width);
            return Padding(
              padding: EdgeInsets.only(
                top: ((_size.max * 0.1) - state.metricsAt(widget.index).topDy)
                    .clamp(0, double.infinity),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withAlpha(60),
                      blurRadius: 6.0,
                      offset: const Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: AnimatedOpacity(
                    opacity: width > 100 ? 1 : 0,
                    duration: KDurations.ms200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: TextWidget(
                            KString.findMeOn,
                            margin: const EdgeInsets.only(top: 20),
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              fontFamily: FontFamily.cindieMonoD,
                            ),
                            softWrap: false,
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              SingleChildScrollView(
                                controller: _scrollController,
                                padding: EdgeInsets.only(
                                  top: _size.height * 0.3,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    ...socialMediaTextWidgets,
                                    IgnorePointer(
                                      child: SizedBox(
                                        height: _size.height * 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_scrollController.hasClients)
                                Positioned(
                                  bottom: 0,
                                  left: _size.width > 700 ? width * 0.1 : 0,
                                  child: MadeWithFlutterIndicatingWidget(
                                    scrollController: _scrollController,
                                    offsetToScroll: _offsetToScroll,
                                    width: width,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _whenResize(Size windowsSize) {
    if (_size == windowsSize) return;
    _size = windowsSize;
    socialMediaTextWidgets = _getSocialMediaTextWidgets();
    _scroll();
  }

  Future<void> _scroll() async {
    _offsetToScroll = (_metrics.bottomDy - _size.height).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.jumpTo(_offsetToScroll);
  }
}
