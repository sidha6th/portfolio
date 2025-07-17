import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/extensions/size.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/screen_size_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:syncx/syncx.dart';

class SlidableTitleWidget extends StatefulWidget {
  const SlidableTitleWidget({super.key});

  @override
  State<SlidableTitleWidget> createState() => _SlidableTitleWidgetState();
}

class _SlidableTitleWidgetState extends State<SlidableTitleWidget> {
  int currentIndex = 0;
  late var textStyle = _textStyle;
  late var _size = context.screenSize;
  final _controller = ScrollController();
  late var _titleHeight = _size.height * 0.1;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: IgnorePointer(
        child: NotifierConsumer<ScreenSizeNotifier, Size>(
          listener: _whenResize,
          builder: (context, state) {
            return NotifierConsumer<StickyMetricsNotifier, StickyMetricsState>(
              listener: _listenModel,
              builder: (context, state) {
                return SizedBox(
                  width: _size.width < 600
                      ? _size.width * 0.5
                      : _size.width * 0.4,
                  height: _titleHeight,
                  child: ListView.builder(
                    primary: false,
                    controller: _controller,
                    itemExtent: _titleHeight,
                    itemCount: KString.titles.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TextWidget(
                        KString.titles[index],
                        style: textStyle,
                        softWrap: false,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(
    fontSize: _size.min * 0.07,
    color: AppColors.offWhite,
    fontFamily: FontFamily.elgocThin,
  );

  void _listenModel(StickyMetricsState state) {
    if (currentIndex == state.currentIndex) return;
    final newOffset =
        _titleHeight *
        (state.currentChildPosition + state.currentIndex < currentIndex
            ? currentIndex - 1
            : state.currentIndex);

    _controller
        .animateTo(newOffset, curve: Curves.linear, duration: KDurations.ms200)
        .then((value) {
          currentIndex = state.currentIndex;
        });
  }

  void _whenResize(Size windowSize) {
    if (_size == windowSize) return;
    _size = windowSize;
    _titleHeight = _size.height * 0.1;
    textStyle = _textStyle;
  }
}
