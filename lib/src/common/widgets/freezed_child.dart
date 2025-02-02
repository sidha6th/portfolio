import 'package:flutter/material.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';

class FreezedChild extends StatefulWidget {
  const FreezedChild({
    required this.index,
    required this.delegates,
    required this.screenSize,
    required this.currentDelegate,
    required this.scrollFreezeHeight,
    required this.pastScrolledHeight,
    required this.setFocusedDelegate,
    this.scrollMetrics,
    super.key,
  });

  final int index;
  final Size screenSize;
  final double scrollFreezeHeight;
  final double pastScrolledHeight;
  final ScrollMetrics? scrollMetrics;
  final FreezedWidgetDelegate currentDelegate;
  final List<FreezedWidgetDelegate> delegates;
  final void Function(
    int index,
    FreezedWidgetDelegate delegate,
    double normalizedValue,
  ) setFocusedDelegate;

  @override
  State<StatefulWidget> createState() => _FreezedChildState();
}

class _FreezedChildState extends State<FreezedChild> {
  double get _scrollFreezeHeight => widget.scrollFreezeHeight;
  FreezedWidgetDelegate get _delegate => widget.currentDelegate;

  late final _key = ValueKey(_delegate);
  late var _metrics = FreezeMetrics.zero(
    _scrollFreezeHeight,
    widget.screenSize,
  );

  @override
  void didUpdateWidget(covariant FreezedChild oldWidget) {
    final offset = widget.scrollMetrics?.pixels ?? 0;
    _metrics = _getMetrics(offset);
    _setGlobalState();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final child = _delegate.childBuilder(_metrics);
    if (!_delegate.shouldFreeze) return child;

    final offset = Offset(0, _metrics.freezedDy);
    return Transform.translate(
      key: _key,
      offset: offset,
      transformHitTests: _delegate.transformHitTests,
      child: child,
    );
  }

  FreezeMetrics _getMetrics(double offset) {
    if (widget.index == 0) {
      final max = (_scrollFreezeHeight - widget.screenSize.height)
          .clamp(0.0, _scrollFreezeHeight);
      final dy = _delegate.shouldFreeze ? offset.clamp(0.0, max) : 0.0;
      return FreezeMetrics(
        freezedDy: dy,
        topDy: offset,
        scrollOffset: offset,
        windowSize: widget.screenSize,
        totalHeight: _scrollFreezeHeight,
        bottomDy: offset + widget.screenSize.height,
      );
    }

    final pastScrolledHeight = widget.pastScrolledHeight;
    final pastScrollableHeight = pastScrolledHeight - _scrollFreezeHeight;
    final origin = (offset + widget.screenSize.height) - pastScrollableHeight;
    final max = (pastScrolledHeight - widget.screenSize.height)
        .clamp(0, double.infinity);
    final clampedOffset = offset.clamp(0, max);
    final freezedDy = _calcDy(clampedOffset, pastScrollableHeight, max);

    return FreezeMetrics(
      freezedDy: freezedDy,
      bottomDy: origin,
      scrollOffset: offset,
      windowSize: widget.screenSize,
      totalHeight: _scrollFreezeHeight,
      topDy: origin - widget.screenSize.height,
    );
  }

  double _calcDy(num clampedOffset, double pastScrollableHeight, num max) {
    if (!_delegate.shouldFreeze) return 0;
    return (clampedOffset - pastScrollableHeight).clamp(
      0,
      (max - (pastScrollableHeight)).clamp(0, double.infinity),
    );
  }

  void _setGlobalState() {
    if (_metrics.topDy > 0 && _metrics.topDy <= _scrollFreezeHeight) {
      final normalizedValue =
          _normalize(value: _metrics.topDy, end: _scrollFreezeHeight);
      widget.setFocusedDelegate(widget.index, _delegate, normalizedValue);
    }
  }

  double _normalize({
    required double value,
    required double end,
    double start = 0,
  }) {
    if (start == end) return 0; // Prevent division by zero
    return (value - start) / (end - start);
  }
}
