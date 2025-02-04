import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_5/widgets/launchable_text_widget.dart';
import 'package:sidharth/src/modules/sections/section_5/widgets/made_with_flutter_indicating_widget.dart';

class FifthSection extends StatefulWidget {
  const FifthSection(this._metrics, {super.key});

  final FreezeMetrics _metrics;

  static double freezedHeight(Size screenSize) =>
      max(screenSize.width, screenSize.height) + (screenSize.height / 2);

  @override
  State<FifthSection> createState() => _FifthSectionState();
}

class _FifthSectionState extends State<FifthSection> {
  final scrollController = ScrollController();
  late double origin =
      widget._metrics.bottomDy - (widget._metrics.windowHeight / 2);
  late double width = origin.clamp(10.0, widget._metrics.windowWidth);
  late double height = origin.clamp(10.0, widget._metrics.windowHeight);
  double offsetToScroll = 0;
  late var socialMediaTextWidgets = List.generate(
    KPersonal.social.length,
    (index) {
      final social = KPersonal.social[index];
      return LaunchableTextWidget(
        text: social.label,
        width: widget._metrics.windowWidth,
        url: social.urlAsString,
      );
    },
  );

  @override
  void didUpdateWidget(covariant FifthSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOuterBoxSize();
    if (scrollController.hasClients) {
      offsetToScroll =
          (widget._metrics.bottomDy - (widget._metrics.windowHeight))
              .clamp(0.0, scrollController.position.maxScrollExtent);
      scrollController.jumpTo(offsetToScroll);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: ((widget._metrics.windowHeight * 0.1) - widget._metrics.topDy)
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
                opacity: width >=
                            (widget._metrics.windowWidth / 2).clamp(0, 60) &&
                        height >=
                            (widget._metrics.windowHeight / 2).clamp(
                              0,
                              scrollController.hasClients
                                  ? scrollController.position.maxScrollExtent /
                                      2
                                  : 0,
                            )
                    ? 1
                    : 0,
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
                          ListView(
                            controller: scrollController,
                            padding: EdgeInsets.only(
                              top: widget._metrics.windowHeight * 0.3,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ...socialMediaTextWidgets,
                              IgnorePointer(
                                child: SizedBox(
                                  height: widget._metrics.windowHeight * 0.2,
                                ),
                              ),
                            ],
                          ),
                          if (scrollController.hasClients)
                            Positioned(
                              bottom: 0,
                              left: widget._metrics.windowWidth > 700
                                  ? width * 0.1
                                  : 0,
                              child: MadeWithFlutterIndicatingWidget(
                                scrollController: scrollController,
                                offsetToScroll: offsetToScroll,
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
        ),
      ],
    );
  }

  void _updateOuterBoxSize() {
    origin = widget._metrics.bottomDy - (widget._metrics.windowHeight / 2);
    width = origin.clamp(10.0, widget._metrics.windowWidth);
    height = origin.clamp(10.0, widget._metrics.windowHeight);
  }
}
