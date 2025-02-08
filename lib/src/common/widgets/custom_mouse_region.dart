import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';

class CustomMouseRegion extends StatelessWidget {
  const CustomMouseRegion({
    required this.child,
    required this.onExit,
    required this.onEnter,
    super.key,
  });

  final Widget child;
  final void Function(dynamic) onExit;
  final void Function(dynamic) onEnter;

  @override
  Widget build(BuildContext context) {
    if (KDimensions.isMobile) {
      return GestureDetector(
        onLongPressUp: () => onExit(null),
        onLongPressDown: onEnter,
        onTapDown: onEnter,
        onTapUp: onExit,
        child: child,
      );
    }
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: child,
    );
  }
}
