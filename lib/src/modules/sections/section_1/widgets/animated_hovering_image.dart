import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class AnimatedHoveringImageWidget extends StatefulWidget {
  const AnimatedHoveringImageWidget({
    required this.imageWidth,
    required this.path,
    super.key,
  });

  final double imageWidth;
  final String path;

  @override
  State<AnimatedHoveringImageWidget> createState() =>
      _AnimatedHoveringImageWidgetState();
}

class _AnimatedHoveringImageWidgetState
    extends State<AnimatedHoveringImageWidget>
    with AutomaticKeepAliveClientMixin {
  bool isHovering = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: AnimatedOpacity(
        duration: KDurations.ms300,
        opacity: isHovering ? 1 : 0,
        child: FadeInDown(
          from: 50,
          onFinish: (direction) => disableIt(),
          child: Image.asset(
            widget.path,
            width: widget.imageWidth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _onEnter() {
    setState(() {
      isHovering = true;
    });
  }

  void _onExit() {
    setState(() {
      isHovering = false;
    });
  }

  void disableIt() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          isHovering = false;
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }
}
