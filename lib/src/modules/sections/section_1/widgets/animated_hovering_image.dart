import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/widgets/custom_mouse_region.dart';

class TransparentBackgroundImageWidget extends StatefulWidget {
  const TransparentBackgroundImageWidget({
    required this.scale,
    required this.imageWidth,
    required this.imageSlideInFrom,
    required this.opacityAnimationDuration,
    super.key,
  });

  final double scale;
  final double imageWidth;
  final double imageSlideInFrom;
  final Duration opacityAnimationDuration;

  @override
  State<TransparentBackgroundImageWidget> createState() =>
      _TransparentBackgroundImageWidgetState();
}

class _TransparentBackgroundImageWidgetState
    extends State<TransparentBackgroundImageWidget> {
  bool visible = true;
  late Widget child = image();
  bool opacityAnimationDoneOnce = false;

  @override
  void didUpdateWidget(covariant TransparentBackgroundImageWidget oldWidget) {
    if (widget.scale > 1) {
      child = ClipRect(
        child: SlideInDown(
          from: widget.imageSlideInFrom,
          onFinish: _whenSlideAnimationFinished,
          child: Transform.scale(
            scale: widget.scale,
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
  Widget build(BuildContext context) {
    return CustomMouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        curve: opacityAnimationDoneOnce
            ? (visible ? Curves.bounceOut : Curves.bounceIn)
            : Curves.ease,
        onEnd: _whenAnimatedOpacityFinished,
        duration: widget.opacityAnimationDuration,
        child: child,
      ),
    );
  }

  SizedBox image() => SizedBox(
        width: widget.imageWidth,
        child: Assets.images.png.image.image(
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
        ),
      );

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
