import 'package:flutter/cupertino.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';

abstract interface class StickableDelegate {
  const StickableDelegate({
    required this.stick,
    required this.child,
    this.transformHitTests = false,
  });

  final bool stick;
  final Widget child;
  final bool transformHitTests;
  double minStickableHeight(Size windowSize);

  bool notifyOnlyWhen(StickyMetricsState prev, StickyMetricsState curr) {
    return prev != curr;
  }
}
