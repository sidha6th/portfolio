import 'package:flutter/material.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:stacked/stacked.dart';

class ScrollObservingViewModel extends BaseViewModel {
  ScrollMetrics? metrics;
  late final scrollController = ScrollController();
  int index = 0;
  double normalizedCurrentSectionScrolledOffset = 0;
  FreezedWidgetDelegate? currentDelegate;

  void init() {
    _listenController();
  }

  void setMetrics(ScrollMetrics metrics) {
    this.metrics = metrics;
    notifyListeners();
  }

  void _listenController() {
    scrollController.addListener(() {
      setMetrics(scrollController.position);
    });
  }

  void setCurrentFocusingIndex(
    int index,
    FreezedWidgetDelegate delegate,
    double lerp,
  ) {
    if (this.index != index) this.index = index;
    if (currentDelegate != delegate) currentDelegate = delegate;
    if (normalizedCurrentSectionScrolledOffset != lerp)
      normalizedCurrentSectionScrolledOffset = lerp;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
