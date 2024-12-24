import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ScrollObservingViewModel extends BaseViewModel {
  ScrollMetrics? metrics;

  void setMetrics(ScrollMetrics metrics) {
    this.metrics = metrics;
    notifyListeners();
  }
}
