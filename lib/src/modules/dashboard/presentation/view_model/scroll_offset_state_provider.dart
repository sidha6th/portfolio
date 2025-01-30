import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ScrollObservingViewModel extends BaseViewModel {
  ScrollMetrics? metrics;
  late final scrollController = ScrollController();

  void setMetrics(ScrollMetrics metrics) {
    this.metrics = metrics;
    notifyListeners();
  }

  void listenController() {
    scrollController.addListener(() {
      setMetrics(scrollController.position);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
