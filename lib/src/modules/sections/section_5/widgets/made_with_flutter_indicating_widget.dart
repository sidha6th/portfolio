import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool visible = false;
  double opacity = 0;
  Offset? position;

  @override
  void didUpdateWidget(covariant MadeWithFlutterIndicatingWidget oldWidget) {
    opacity = widget.offsetToScroll >=
            widget.scrollController.position.maxScrollExtent
        ? 1
        : 0;
    visible = opacity > 0;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: opacity,
          onEnd: _onAnimationEnd,
          duration: KDurations.ms200,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.none,
                  onExit: _onHoverEnd,
                  onHover: _onHover,
                  opaque: false,
                  child: TextWidget(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10,
                      right: position == null ? 5 : 10,
                    ),
                    KString.madeWithFlutter,
                    style: TextStyle(
                      fontSize: (widget.width * 0.013).clamp(1, 5),
                      fontFamily: FontFamily.cindieMonoD,
                      color: AppColors.black45,
                    ),
                    softWrap: false,
                  ),
                ),
                if (position == null) flutterSvgWidget,
              ],
            ),
          ),
        ),
        if (position != null)
          Positioned(
            left: position!.dx,
            top: position!.dy,
            child: flutterSvgWidget,
          ),
      ],
    );
  }

  void _onHover(PointerHoverEvent event) {
    setState(() {
      position = Offset(
        event.localPosition.dx + 6,
        event.localPosition.dy + 7,
      );
    });
  }

  void _onHoverEnd(_) {
    setState(() {
      position = null;
    });
  }

  void _onAnimationEnd() {
    visible = opacity > 0;
  }
}
