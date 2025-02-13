import 'package:flutter/material.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:stacked/stacked.dart';

class ScrollObservingViewModel extends BaseViewModel {
  int index = 0;
  ScrollMetrics? metrics;
  FreezedWidgetDelegate? currentDelegate;
  late final scrollController = ScrollController();
  double normalizedCurrentSectionScrolledOffset = 0;

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

  void setCurrentDelegateState(
    int index,
    FreezedWidgetDelegate delegate,
    double lerp,
  ) {
    if (this.index != index) this.index = index;
    if (currentDelegate != delegate) currentDelegate = delegate;
    if (normalizedCurrentSectionScrolledOffset == lerp) return;
    normalizedCurrentSectionScrolledOffset = lerp;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
