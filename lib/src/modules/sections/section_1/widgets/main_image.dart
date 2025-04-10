import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';

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
  final void Function(AnimateDoDirection)? whenSlideAnimationEnd;

  @override
  State<MainImageWidget> createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget> {
  @override
  void didUpdateWidget(covariant MainImageWidget oldWidget) {
    if (widget.scale > 1) {
      child = ClipRect(
        child: SlideInDown(
          animate: widget.scale > 1,
          from: widget.imageSlideInFrom,
          onFinish: widget.whenSlideAnimationEnd,
          child: Transform.scale(
            scale: widget.scale,
            transformHitTests: false,
            alignment: Alignment.topCenter,
            filterQuality: FilterQuality.none,
            child: image,
          ),
        ),
      );
    } else if (child != image) {
      child = image;
    }

    super.didUpdateWidget(oldWidget);
  }

  late final image = SizedBox(
    width: widget.imageWidth,
    child: Assets.images.jpeg.image.image(
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.darken,
      filterQuality: FilterQuality.none,
    ),
  );

  late Widget child = image;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: child);
  }
}
