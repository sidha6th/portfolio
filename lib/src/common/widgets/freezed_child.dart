import 'package:flutter/material.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_event.dart';

class FreezedChild extends StatefulWidget {
  const FreezedChild({
    required this.index,
    required this.delegates,
    required this.screenSize,
    required this.scrollPosition,
    required this.hasInitialized,
    required this.currentDelegate,
    required this.scrollFreezeHeight,
    required this.pastScrolledHeight,
    required this.setFocusedDelegate,
    super.key,
  });

  final int index;
  final Size screenSize;
  final bool hasInitialized;
  final double scrollPosition;
  final double scrollFreezeHeight;
  final double pastScrolledHeight;
  final FreezedWidgetDelegate currentDelegate;
  final List<FreezedWidgetDelegate> delegates;
  final void Function(SetCurrentDelegate) setFocusedDelegate;

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
    initialized: widget.hasInitialized,
  );

  @override
  void didUpdateWidget(covariant FreezedChild oldWidget) {
    final offset = widget.scrollPosition;
    if (offset > widget.pastScrolledHeight) return;
    _getMetrics(offset).then((_) => _setGlobalState());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final child = _delegate.childBuilder(_metrics);
    if (!_delegate.shouldFreeze) return child;

    return Transform.translate(
      transformHitTests: _delegate.transformHitTests,
      offset: Offset(0, _metrics.freezedDy),
      key: _key,
      child: child,
    );
  }

  Future<void> _getMetrics(double offset) async {
    if (widget.index == 0) {
      final max = (_scrollFreezeHeight - widget.screenSize.height).clamp(
        0.0,
        _scrollFreezeHeight,
      );
      final dy = _delegate.shouldFreeze ? offset.clamp(0.0, max) : 0.0;
      _metrics = FreezeMetrics(
        freezedDy: dy,
        topDy: offset,
        scrollOffset: offset,
        windowSize: widget.screenSize,
        totalHeight: _scrollFreezeHeight,
        initialized: widget.hasInitialized,
        bottomDy: offset + widget.screenSize.height,
      );
      return;
    }

    final pastScrolledHeight = widget.pastScrolledHeight;
    final pastScrollableHeight = pastScrolledHeight - _scrollFreezeHeight;
    final origin = (offset + widget.screenSize.height) - pastScrollableHeight;
    final max = (pastScrolledHeight - widget.screenSize.height).clamp(
      0,
      double.infinity,
    );
    final clampedOffset = offset.clamp(0, max);
    final freezedDy = _calcDy(clampedOffset, pastScrollableHeight, max);

    _metrics = FreezeMetrics(
      freezedDy: freezedDy,
      bottomDy: origin,
      scrollOffset: offset,
      windowSize: widget.screenSize,
      totalHeight: _scrollFreezeHeight,
      initialized: widget.hasInitialized,
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
      final normalizedValue = normalize(
        value: _metrics.topDy,
        end: _scrollFreezeHeight,
      );
      widget.setFocusedDelegate(
        SetCurrentDelegate(
          index: widget.index,
          delegate: _delegate,
          lerp: normalizedValue,
        ),
      );
    }
  }
}
