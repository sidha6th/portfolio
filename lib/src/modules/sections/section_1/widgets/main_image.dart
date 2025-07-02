import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/widgets/animated/tween_slide_in_down.dart';

class MainImageWidget extends StatefulWidget {
  const MainImageWidget({
    required this.scale,
    required this.imageWidth,
    required this.imageSlideInFrom,
    required this.whenSlideAnimationEnd,
    super.key,
  });

  final double scale;
  final double imageWidth;
  final double imageSlideInFrom;
  final VoidCallback? whenSlideAnimationEnd;

  @override
  State<MainImageWidget> createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget> {
  late Widget child = image();

  @override
  void didUpdateWidget(covariant MainImageWidget oldWidget) {
    if (widget.scale > 1) {
      child = ClipRect(
        child: TweenSlideInDown(
          from: widget.imageSlideInFrom,
          onFinish: widget.whenSlideAnimationEnd,
          child: Transform.scale(
            scale: widget.scale,
            transformHitTests: false,
            alignment: Alignment.topCenter,
            filterQuality: FilterQuality.low,
            child: image(),
          ),
        ),
      );
    } else if (oldWidget.imageWidth != widget.imageWidth) {
      child = image();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => IgnorePointer(child: child);

  SizedBox image() => SizedBox(
    width: widget.imageWidth,
    child: Assets.images.jpeg.image.image(
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.darken,
    ),
  );
}
