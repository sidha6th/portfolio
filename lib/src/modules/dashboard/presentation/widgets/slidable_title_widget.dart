import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/size_extension.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_state.dart';

class SlidableTitleWidget extends StatefulWidget {
  const SlidableTitleWidget({required this.windowSize, super.key});

  final Size windowSize;

  @override
  State<SlidableTitleWidget> createState() => _SlidableTitleWidgetState();
}

class _SlidableTitleWidgetState extends State<SlidableTitleWidget> {
  TextStyle get _textStyle => TextStyle(
    fontSize: widget.windowSize.min * 0.07,
    color: AppColors.offWhite,
    fontFamily: FontFamily.elgocThin,
  );

  final _controller = ScrollController();
  late var _titleHeight = widget.windowSize.height * 0.1;
  late var textStyle = _textStyle;

  int currentIndex = 0;

  @override
  void didUpdateWidget(covariant SlidableTitleWidget oldWidget) {
    _titleHeight = widget.windowSize.height * 0.1;
    textStyle = _textStyle;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.windowSize.width;
    return BlocListener<ScrollObserverBloc, ScrollObserverState>(
      listener: (_, state) => _listenModel(state),
      listenWhen: (prev, curr) => prev.index != curr.index,
      child: Positioned(
        top: 20,
        left: 20,
        child: IgnorePointer(
          child: SizedBox(
            width: width < 600 ? width * 0.5 : width * 0.4,
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
          ),
        ),
      ),
    );
  }

  void _listenModel(ScrollObserverState state) {
    if (currentIndex == state.index) return;
    final newOffset =
        _titleHeight *
        (state.normalizedCurrentSectionScrolledOffset + state.index <
                currentIndex
            ? currentIndex - 1
            : state.index);

    _controller
        .animateTo(newOffset, curve: Curves.linear, duration: KDurations.ms200)
        .then((value) {
          currentIndex = state.index;
        });
  }
}
