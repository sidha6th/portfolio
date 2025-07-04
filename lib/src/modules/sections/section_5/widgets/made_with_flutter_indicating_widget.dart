import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class MadeWithFlutterIndicatingWidget extends StatefulWidget {
  const MadeWithFlutterIndicatingWidget({
    required this.scrollController,
    required this.offsetToScroll,
    required this.width,
    super.key,
  });

  final ScrollController scrollController;
  final double offsetToScroll;
  final double width;

  @override
  State<MadeWithFlutterIndicatingWidget> createState() =>
      _MadeWithFlutterIndicatingWidgetState();
}

class _MadeWithFlutterIndicatingWidgetState
    extends State<MadeWithFlutterIndicatingWidget> {
  final flutterSvgWidget = SvgPicture.asset(
    Assets.images.svg.flutter,
    width: 12,
  );

  bool _visible = false;
  double _opacity = 0;

  @override
  void didUpdateWidget(covariant MadeWithFlutterIndicatingWidget oldWidget) {
    _opacity =
        widget.offsetToScroll >=
            widget.scrollController.position.maxScrollExtent
        ? 1
        : 0;
    _visible = _opacity > 0;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();
    return AnimatedOpacity(
      opacity: _opacity,
      duration: KDurations.ms200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
                right: 5,
              ),
              KString.madeWithFlutter,
              style: TextStyle(
                fontSize: (widget.width * 0.013).clamp(1, 5),
                fontFamily: FontFamily.cindieMonoD,
                color: AppColors.black45,
              ),
              softWrap: false,
            ),
            flutterSvgWidget,
          ],
        ),
      ),
    );
  }
}
