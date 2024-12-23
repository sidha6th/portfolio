import 'package:flutter/material.dart';

class ColoredSizedBox extends StatelessWidget {
  const ColoredSizedBox({
    this.margin = EdgeInsets.zero,
    this.color = Colors.white,
    this.height,
    this.width,
    this.child,
    super.key,
  });

  final double? height;
  final double? width;
  final Color color;
  final EdgeInsets margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ColoredBox(
        color: color,
        child: SizedBox(
          height: height,
          width: width,
          child: child,
        ),
      ),
    );
  }
}
