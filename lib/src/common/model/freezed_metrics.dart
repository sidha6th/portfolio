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
  });

  const FreezeMetrics.zero(
    this.totalHeight,
    this.windowSize, {
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

  double get windowWidth => windowSize.width;
  double get windowHeight => windowSize.height;
  double get minWindowSide => min(windowHeight, windowWidth);
  double get maxWindowSide => max(windowHeight, windowWidth);
  double get clampedOrigin => bottomDy.clamp(0, double.infinity);
  double get availableViewPortHeight => bottomDy.clamp(0, windowHeight);

  @override
  bool operator ==(covariant FreezeMetrics other) {
    if (identical(this, other)) return true;

    return other.freezedDy == freezedDy &&
        other.topDy == topDy &&
        other.bottomDy == bottomDy &&
        other.windowSize == windowSize &&
        other.totalHeight == totalHeight &&
        other.scrollOffset == scrollOffset;
  }

  @override
  int get hashCode {
    return freezedDy.hashCode ^
        topDy.hashCode ^
        bottomDy.hashCode ^
        windowSize.hashCode ^
        totalHeight.hashCode ^
        scrollOffset.hashCode;
  }

  @override
  String toString() {
    return '(scrollOffset: $scrollOffset, dy: $freezedDy, totalHeight: $totalHeight, bottomDy: $bottomDy, topDy: $topDy, windowSize: $windowSize)';
  }
}
