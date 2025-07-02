import 'package:flutter/material.dart'
    show
        FractionalTranslation,
        Offset,
        Widget,
        BuildContext,
        Opacity,
        StatelessWidget;

class FractionalFadeSlideIn extends StatelessWidget {
  const FractionalFadeSlideIn({
    required this.child,
    required this.offset,
    required this.opacity,
    super.key,
  });

  final Widget child;
  final Offset offset;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: offset,
      transformHitTests: false,
      child: Opacity(opacity: opacity, child: child),
    );
  }
}
