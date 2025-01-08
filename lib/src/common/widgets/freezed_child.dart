import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/iterable.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';

class FreezedChild extends StatefulWidget {
  const FreezedChild({
    required this.screenSize,
    required this.delegates,
    required this.index,
    this.scrollMetrics,
    super.key,
  });

  final List<FreezedWidgetDelegate> delegates;
  final ScrollMetrics? scrollMetrics;
  final Size screenSize;
  final int index;

  @override
  State<StatefulWidget> createState() => _FreezedChildState();
}

class _FreezedChildState extends State<FreezedChild> {
  double _height = 0;
  late final delegate = widget.delegates[widget.index];
  late var metrics = FreezedMetrics.zero(_height, widget.screenSize);

  @override
  void didUpdateWidget(covariant FreezedChild oldWidget) {
    _height = delegate.viewPortHeight(widget.screenSize);
    final offset = widget.scrollMetrics?.pixels ?? 0;
    metrics = _metrics(offset);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (delegate.shouldFreeze) {
      return Transform.translate(
        offset: Offset(0, metrics.freezedDy),
        child: delegate.childBuilder(metrics),
      );
    }
    return delegate.childBuilder(metrics);
  }

  FreezedMetrics _metrics(double offset) {
    if (widget.index == 0) {
      final max = (_height - widget.screenSize.height).clamp(0.0, _height);
      final dy = offset.clamp(0.0, max);
      return FreezedMetrics(
        freezedDy: dy,
        origin: offset,
        childHeight: _height,
        scrollOffset: offset,
        viewPortSize: widget.screenSize,
      );
    }

    final pastScrolledHeight = _calcPastViewPortHeight;
    final pastScrollableHeight = pastScrolledHeight - _height;
    final origin = (offset + widget.screenSize.height) - pastScrollableHeight;
    final max = (pastScrolledHeight - widget.screenSize.height)
        .clamp(0, double.infinity);
    final clampedOffset = offset.clamp(0.0, max);
    final dy = (clampedOffset - (pastScrollableHeight)).clamp(
      0.0,
      (max - (pastScrollableHeight)).clamp(0.0, double.infinity),
    );

    return FreezedMetrics(
      origin: origin.clamp(0, double.infinity),
      freezedDy: dy,
      childHeight: _height,
      scrollOffset: offset,
      viewPortSize: widget.screenSize,
    );
  }

  double get _calcPastViewPortHeight {
    return widget.delegates.transform<double>(
          (e, result) => e.viewPortHeight(widget.screenSize) + (result ?? 0),
          end: widget.index + 1,
        ) ??
        0;
  }
}
