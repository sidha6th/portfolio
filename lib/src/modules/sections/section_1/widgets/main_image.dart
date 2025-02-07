import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';

class MainImageWidget extends StatefulWidget {
  const MainImageWidget({
    required this.scale,
    required this.imageWidth,
    required this.clipBehavior,
    required this.slideDownDelay,
    required this.imageSlideInFrom,
    required this.whenSlideAnimationEnd,
    super.key,
  });

  final double scale;
  final Clip clipBehavior;
  final double imageWidth;
  final double imageSlideInFrom;
  final Duration slideDownDelay;
  final void Function(AnimateDoDirection)? whenSlideAnimationEnd;

  @override
  State<MainImageWidget> createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget> {
  late final image = Assets.images.jpeg.image.image(
    fit: BoxFit.fill,
    colorBlendMode: BlendMode.darken,
    filterQuality: FilterQuality.none,
  );

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRect(
        clipBehavior: widget.clipBehavior,
        child: SlideInDown(
          from: widget.imageSlideInFrom,
          delay: widget.slideDownDelay,
          onFinish: widget.whenSlideAnimationEnd,
          child: Transform.scale(
            scale: widget.scale,
            transformHitTests: false,
            alignment: Alignment.topCenter,
            filterQuality: FilterQuality.none,
            child: SizedBox(
              width: widget.imageWidth,
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
