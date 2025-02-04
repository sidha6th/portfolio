import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/size.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_observing_view_model.dart';
import 'package:stacked/stacked.dart';

class SlidableTitleWidget extends StatefulWidget {
  const SlidableTitleWidget({
    required this.windowSize,
    required this.model,
    super.key,
  });

  final Size windowSize;
  final ScrollObservingViewModel model;

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
  void initState() {
    widget.model.addListener(_listenModel);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SlidableTitleWidget oldWidget) {
    _titleHeight = widget.windowSize.height * 0.1;
    textStyle = _textStyle;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: IgnorePointer(
        child: ViewModelBuilder.reactive(
          viewModelBuilder: () => widget.model,
          disposeViewModel: false,
          builder: (context, model, child) {
            return SizedBox(
              width: widget.windowSize.width * 0.4,
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
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _listenModel() {
    if (currentIndex == widget.model.index) return;
    final newOffset = _titleHeight *
        (widget.model.normalizedCurrentSectionScrolledOffset +
                    widget.model.index <
                currentIndex
            ? currentIndex - 1
            : widget.model.index);

    _controller
        .animateTo(
      newOffset,
      curve: Curves.linear,
      duration: KDurations.ms200,
    )
        .then(
      (value) {
        currentIndex = widget.model.index;
      },
    );
  }
}
