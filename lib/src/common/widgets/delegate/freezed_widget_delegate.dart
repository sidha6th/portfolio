import 'package:flutter/material.dart';

class FreezedWidgetDelegate {
  FreezedWidgetDelegate({
    required this.freezeViewPortHeight,
    required this.childBuilder,
  });

  final double freezeViewPortHeight;
  final Widget Function(double offset) childBuilder;
}
