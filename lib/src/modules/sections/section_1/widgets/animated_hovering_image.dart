import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class EmptyBackgroundImage extends StatefulWidget {
  const EmptyBackgroundImage({
    required this.scale,
    required this.imageWidth,
    required this.clipBehavior,
    required this.slideDownDelay,
    required this.imageSlideInFrom,
    required this.opacityAnimationDuration,
    super.key,
  });

  final double scale;
  final double imageWidth;
  final Clip clipBehavior;
  final Duration slideDownDelay;
  final double imageSlideInFrom;
  final Duration opacityAnimationDuration;

  @override
  State<EmptyBackgroundImage> createState() => _EmptyBackgroundImageState();
}

class _EmptyBackgroundImageState extends State<EmptyBackgroundImage> {
  bool visible = true;
  bool opacityAnimationDoneOnce = false;
  late final image = Assets.images.png.image.image(
    fit: BoxFit.cover,
    colorBlendMode: BlendMode.darken,
    filterQuality: FilterQuality.none,
  );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: ClipRect(
        clipBehavior: widget.clipBehavior,
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          curve: opacityAnimationDoneOnce
              ? (visible ? Curves.bounceOut : Curves.bounceIn)
              : Curves.ease,
          onEnd: _whenAnimatedOpacityFinished,
          duration: widget.opacityAnimationDuration,
          child: SlideInDown(
            delay: widget.slideDownDelay,
            from: widget.imageSlideInFrom,
            onFinish: _whenSlideAnimationFinished,
            child: Transform.scale(
              scale: widget.scale,
              alignment: Alignment.topCenter,
              filterQuality: FilterQuality.none,
              child: SizedBox(
                width: widget.imageWidth,
                child: image,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onEnter(_) {
    if (visible) return;
    setState(() {
      visible = true;
    });
  }

  void _onExit(_) {
    if (!visible) return;
    setState(() {
      visible = false;
    });
  }

  void _whenSlideAnimationFinished(_) {
    Future.delayed(
      KDurations.ms100,
      () {
        setState(() {
          visible = false;
        });
      },
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  void _whenAnimatedOpacityFinished() {
    if (!opacityAnimationDoneOnce) {
      opacityAnimationDoneOnce = true;
    }
  }
}
