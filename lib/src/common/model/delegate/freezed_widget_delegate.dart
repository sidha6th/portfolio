import 'package:flutter/material.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';

class FreezedWidgetDelegate {
  const FreezedWidgetDelegate({
    required this.viewPortHeight,
    required this.childBuilder,
    this.shouldFreeze = true,
    this.transformHitTests = false,
  });

  final Widget Function(FreezedMetrics metrics) childBuilder;
  final double Function(Size screenSize) viewPortHeight;
  final bool shouldFreeze;
  final bool transformHitTests;
}
