import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class FreezeMetrics {
  const FreezeMetrics({
    required this.topDy,
    required this.bottomDy,
    required this.freezedDy,
    required this.windowSize,
    required this.totalHeight,
    required this.scrollOffset,
    required this.initialized,
  });

  const FreezeMetrics.zero(
    this.totalHeight,
    this.windowSize, {
    required this.initialized,
    this.topDy = 0,
    this.bottomDy = 0,
    this.scrollOffset = 0,
  }) : freezedDy = 0;

  final double topDy;
  final double bottomDy;
  final Size windowSize;
  final double freezedDy;
  final double totalHeight;
  final double scrollOffset;
  final bool initialized;

  double get windowWidth => windowSize.width;
  double get windowHeight => windowSize.height;
  double get minWindowSide => min(windowHeight, windowWidth);
  double get maxWindowSide => max(windowHeight, windowWidth);
  double get clampedOrigin => bottomDy.clamp(0, double.infinity);
  double get availableViewPortHeight => bottomDy.clamp(0, windowHeight);

  void whenWindowResized(
    Size size,
    void Function(Size windowsSize) callback,
  ) {
    if (size == windowSize) return;
    return callback(windowSize);
  }

  @override
  bool operator ==(covariant FreezeMetrics other) {
    if (identical(this, other)) return true;

    return other.topDy == topDy &&
        other.bottomDy == bottomDy &&
        other.windowSize == windowSize &&
        other.freezedDy == freezedDy &&
        other.totalHeight == totalHeight &&
        other.scrollOffset == scrollOffset &&
        other.initialized == initialized;
  }

  @override
  int get hashCode {
    return topDy.hashCode ^
        bottomDy.hashCode ^
        windowSize.hashCode ^
        freezedDy.hashCode ^
        totalHeight.hashCode ^
        scrollOffset.hashCode ^
        initialized.hashCode;
  }
}
