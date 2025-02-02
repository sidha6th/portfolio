import 'package:flutter/material.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';

@immutable
class FreezedWidgetDelegate {
  const FreezedWidgetDelegate({
    required this.freezedScrollHeight,
    required this.childBuilder,
    this.shouldFreeze = true,
    this.transformHitTests = false,
  });

  final Widget Function(FreezeMetrics metrics) childBuilder;
  final double Function(Size screenSize) freezedScrollHeight;
  final bool shouldFreeze;
  final bool transformHitTests;

  FreezedWidgetDelegate copyWith({
    Widget Function(FreezeMetrics metrics)? childBuilder,
    double Function(Size screenSize)? freezedScrollHeight,
    bool? shouldFreeze,
    bool? transformHitTests,
  }) {
    return FreezedWidgetDelegate(
      childBuilder: childBuilder ?? this.childBuilder,
      freezedScrollHeight: freezedScrollHeight ?? this.freezedScrollHeight,
      shouldFreeze: shouldFreeze ?? this.shouldFreeze,
      transformHitTests: transformHitTests ?? this.transformHitTests,
    );
  }

  @override
  bool operator ==(covariant FreezedWidgetDelegate other) {
    if (identical(this, other)) return true;

    return other.childBuilder == childBuilder &&
        other.freezedScrollHeight == freezedScrollHeight &&
        other.shouldFreeze == shouldFreeze &&
        other.transformHitTests == transformHitTests;
  }

  @override
  int get hashCode {
    return childBuilder.hashCode ^
        freezedScrollHeight.hashCode ^
        shouldFreeze.hashCode ^
        transformHitTests.hashCode;
  }
}
