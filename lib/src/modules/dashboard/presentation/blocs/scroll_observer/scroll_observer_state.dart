import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';

class ScrollObserverState {
  const ScrollObserverState({
    this.index = 0,
    this.currentDelegate,
    this.currentScrollPosition = 0,
    this.normalizedCurrentSectionScrolledOffset = 0,
  });

  final int index;
  final double currentScrollPosition;
  final FreezedWidgetDelegate? currentDelegate;
  final double normalizedCurrentSectionScrolledOffset;

  ScrollObserverState updateScrollMetric(double pixels) {
    return copyWith(currentScrollPosition: pixels);
  }

  ScrollObserverState copyWith({
    int? index,
    double? currentScrollPosition,
    FreezedWidgetDelegate? currentDelegate,
    double? normalizedCurrentSectionScrolledOffset,
  }) {
    return ScrollObserverState(
      index: index ?? this.index,
      currentScrollPosition:
          currentScrollPosition ?? this.currentScrollPosition,
      normalizedCurrentSectionScrolledOffset:
          normalizedCurrentSectionScrolledOffset ??
          this.normalizedCurrentSectionScrolledOffset,
      currentDelegate: currentDelegate ?? this.currentDelegate,
    );
  }

  @override
  bool operator ==(covariant ScrollObserverState other) {
    if (identical(this, other)) return true;

    return other.index == index &&
        other.currentScrollPosition == currentScrollPosition &&
        other.currentDelegate == currentDelegate &&
        other.normalizedCurrentSectionScrolledOffset ==
            normalizedCurrentSectionScrolledOffset;
  }

  @override
  int get hashCode {
    return index.hashCode ^
        currentScrollPosition.hashCode ^
        currentDelegate.hashCode ^
        normalizedCurrentSectionScrolledOffset.hashCode;
  }
}
