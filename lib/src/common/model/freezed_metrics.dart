import 'package:flutter/material.dart';

@immutable
final class FreezeMetrics {
  const FreezeMetrics({
    required this.topDy,
    required this.bottomDy,
    required this.freezedDy,
    required this.totalHeight,
    required this.scrollOffset,
  });

  const FreezeMetrics.zero(
    this.totalHeight, {
    this.topDy = 0,
    this.bottomDy = 0,
    this.scrollOffset = 0,
  }) : freezedDy = 0;

  final double topDy;
  final double bottomDy;
  final double freezedDy;
  final double totalHeight;
  final double scrollOffset;

  double get clampedOrigin => bottomDy.clamp(0, double.infinity);
  double availableViewPortHeight(double windowHeight) =>
      bottomDy.clamp(0, windowHeight);

  @override
  bool operator ==(covariant FreezeMetrics other) {
    if (identical(this, other)) return true;

    return other.topDy == topDy &&
        other.bottomDy == bottomDy &&
        other.freezedDy == freezedDy &&
        other.totalHeight == totalHeight &&
        other.scrollOffset == scrollOffset;
  }

  @override
  int get hashCode {
    return topDy.hashCode ^
        bottomDy.hashCode ^
        freezedDy.hashCode ^
        totalHeight.hashCode ^
        scrollOffset.hashCode;
  }
}
