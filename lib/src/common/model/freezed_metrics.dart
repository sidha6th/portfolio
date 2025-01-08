import 'dart:ui';

class FreezedMetrics {
  const FreezedMetrics({
    required this.scrollOffset,
    required this.freezedDy,
    required this.origin,
    required this.childHeight,
    required this.viewPortSize,
  });

  const FreezedMetrics.zero(
    this.childHeight,
    this.viewPortSize,
  )   : freezedDy = 0,
        scrollOffset = 0,
        origin = 0;

  final double scrollOffset;
  final double freezedDy;
  final double childHeight;
  final double origin;
  final Size viewPortSize;

  double get viewPortHeight => viewPortSize.height;
  double get viewPortWidth => viewPortSize.width;

  @override
  String toString() {
    return '(scrollOffset: $scrollOffset, freezedDy: $freezedDy, childHeight: $childHeight, origin: $origin, viewPortSize: $viewPortSize)';
  }

  @override
  bool operator ==(covariant FreezedMetrics other) {
    if (identical(this, other)) return true;

    return other.scrollOffset == scrollOffset &&
        other.freezedDy == freezedDy &&
        other.childHeight == childHeight &&
        other.origin == origin &&
        other.viewPortSize == viewPortSize;
  }

  @override
  int get hashCode {
    return scrollOffset.hashCode ^
        freezedDy.hashCode ^
        childHeight.hashCode ^
        origin.hashCode ^
        viewPortSize.hashCode;
  }
}
