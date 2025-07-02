import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';

class TweenSlideInDown extends StatelessWidget {
  const TweenSlideInDown({
    required this.from,
    required this.child,
    this.onFinish,
    super.key,
  });

  final double from;
  final Widget child;
  final VoidCallback? onFinish;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: -from, end: 0),
      duration: KDurations.ms600,
      curve: Curves.fastOutSlowIn,
      onEnd: onFinish,
      child: child,
      builder: (context, value, child) {
        return Transform.translate(
          transformHitTests: false,
          offset: Offset(0, value),
          child: child!,
        );
      },
    );
  }
}
