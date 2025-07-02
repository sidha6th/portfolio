import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/state_management/base_notifier.dart';

class StickyMetricsNotifier extends BaseNotifier<StickyMetricsState> {
  StickyMetricsNotifier(super.state);

  void onChangeScrollPosition(double position) {
    setState(state.copyWith(scrollPosition: position));
  }

  void onChangeMetrics(
    int index, {
    required FreezeMetrics metrics,
    required bool isVisible,
    double? childPosition,
  }) {
    state.metrics[index] = metrics;
    setState(
      state.copyWith(
        currentIndex: isVisible ? index : null,
        currentChildPosition: isVisible ? childPosition : null,
      ),
      forced: true,
    );
  }
}

class StickyMetricsState {
  factory StickyMetricsState.create(
    List<StickableDelegate> delegates,
    Size windowSize,
  ) {
    return StickyMetricsState(
      currentIndex: 0,
      scrollPosition: 0,
      currentChildPosition: 0,
      metrics: List.generate(
        delegates.length,
        (index) =>
            FreezeMetrics.zero(delegates[index].minStickableHeight(windowSize)),
        growable: false,
      ),
    );
  }
  const StickyMetricsState({
    required this.metrics,
    required this.currentIndex,
    required this.scrollPosition,
    required this.currentChildPosition,
  });

  final int currentIndex;
  final double scrollPosition;
  final double currentChildPosition;
  final List<FreezeMetrics> metrics;

  FreezeMetrics metricsAt(int index) => metrics[index];

  @override
  bool operator ==(covariant StickyMetricsState other) {
    if (identical(this, other)) return true;

    return other.currentIndex == currentIndex &&
        other.scrollPosition == scrollPosition &&
        other.currentChildPosition == currentChildPosition &&
        listEquals(other.metrics, metrics);
  }

  @override
  int get hashCode {
    return currentIndex.hashCode ^
        scrollPosition.hashCode ^
        currentChildPosition.hashCode ^
        metrics.hashCode;
  }

  StickyMetricsState copyWith({
    int? currentIndex,
    double? scrollPosition,
    double? currentChildPosition,
    List<FreezeMetrics>? metrics,
  }) {
    return StickyMetricsState(
      metrics: metrics ?? this.metrics,
      currentIndex: currentIndex ?? this.currentIndex,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      currentChildPosition: currentChildPosition ?? this.currentChildPosition,
    );
  }
}
