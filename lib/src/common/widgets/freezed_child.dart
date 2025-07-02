import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/state_management/notifier_builder.dart';
import 'package:sidharth/src/common/state_management/notifier_listener.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';

class StickableChild extends StatefulWidget {
  const StickableChild({
    required this.index,
    required this.child,
    required this.delegates,
    required this.screenSize,
    required this.scrollController,
    required this.currentDelegate,
    required this.scrollFreezeHeight,
    required this.pastScrolledHeight,
    super.key,
  });

  final int index;
  final Widget child;
  final Size screenSize;
  final double scrollFreezeHeight;
  final double pastScrolledHeight;
  final StickableDelegate currentDelegate;
  final List<StickableDelegate> delegates;
  final ScrollController scrollController;

  @override
  State<StatefulWidget> createState() => _StickableChildState();
}

class _StickableChildState extends State<StickableChild> {
  double get _scrollFreezeHeight => widget.scrollFreezeHeight;
  StickableDelegate get _delegate => widget.currentDelegate;
  late final _key = ValueKey(_delegate);

  late var maxStickableHeight = _maxStickableHeight();
  late var top = widget.pastScrolledHeight - _scrollFreezeHeight;

  @override
  void didUpdateWidget(covariant StickableChild oldWidget) {
    maxStickableHeight = _maxStickableHeight();
    top = widget.pastScrolledHeight - _scrollFreezeHeight;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return NotifierListener<LoadingNotifier, LoadingState>(
      listenWhen: (previous, current) => !current.isLoading,
      listener: (state) {
        if (state.isLoading) return;
        widget.scrollController.addListener(_updateMetrics);
      },
      child: !_delegate.stick
          ? widget.child
          : NotifierBuilder<StickyMetricsNotifier, StickyMetricsState>(
              builder: (context, state) {
                return RepaintBoundary(
                  child: Transform.translate(
                    key: _key,
                    transformHitTests: _delegate.transformHitTests,
                    offset: Offset(0, state.metricsAt(widget.index).freezedDy),
                    child: widget.child,
                  ),
                );
              },
            ),
    );
  }

  void _updateMetrics() {
    final offset = widget.scrollController.offset;
    if (offset > widget.pastScrolledHeight) return;
    final metrics = _calculateMetrics(offset);
    context.read<StickyMetricsNotifier>().onChangeMetrics(
      widget.index,
      metrics: metrics,
      childPosition: currentSectionPosition(metrics),
      isVisible: metrics.topDy > 0 && metrics.topDy <= _scrollFreezeHeight,
    );
  }

  FreezeMetrics _calculateMetrics(double offset) {
    if (widget.index == 0) {
      final dy = _delegate.stick ? offset.clamp(0.0, maxStickableHeight) : 0.0;
      return FreezeMetrics(
        freezedDy: dy,
        topDy: offset,
        scrollOffset: offset,
        totalHeight: _scrollFreezeHeight,
        bottomDy: offset + widget.screenSize.height,
      );
    }

    final bottomDy = (offset + widget.screenSize.height) - top;
    return FreezeMetrics(
      bottomDy: bottomDy,
      scrollOffset: offset,
      freezedDy: _calcDy(offset),
      totalHeight: _scrollFreezeHeight,
      topDy: bottomDy - widget.screenSize.height,
    );
  }

  double _maxStickableHeight() {
    final h = widget.screenSize.height;
    if (widget.index == 0) {
      return (_scrollFreezeHeight - h).clamp(0.0, _scrollFreezeHeight);
    }
    return (widget.pastScrolledHeight - h).clamp(0, double.infinity);
  }

  double _calcDy(double offset) {
    if (!_delegate.stick) return 0;
    final max = (maxStickableHeight - (top)).clamp(0.0, double.infinity);
    return (offset.clamp(0, maxStickableHeight) - top).clamp(0, max);
  }

  double? currentSectionPosition(FreezeMetrics metrics) {
    if (metrics.topDy > 0 && metrics.topDy <= _scrollFreezeHeight) {
      return normalize(value: metrics.topDy, end: _scrollFreezeHeight);
    }
    return null;
  }
}
