import 'package:flutter/material.dart';

class TextWidget extends Text {
  /// This [TextWidget] widget allows for nullable text values, accommodating scenarios where localization services may be null.
  ///
  /// By permitting nullable input, we reduce the need to handle nullability each time we use the [Text] widget.
  TextWidget(
    Object? data, {
    this.margin = EdgeInsets.zero,
    super.style,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap = true,
    super.overflow,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
    super.textHeightBehavior,
    super.selectionColor,
    super.strutStyle,
    super.textScaler,
    super.textWidthBasis,
    super.key,
    this.fallbackWidget,
  }) : super(data?.toString() ?? '');

  final Widget? fallbackWidget;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.trim().isEmpty) {
      return fallbackWidget ?? const SizedBox.shrink();
    }
    return Padding(padding: margin, child: super.build(context));
  }
}
