import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/bool.dart';
import 'package:sidharth/src/common/extensions/iterable.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';

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
  double? _pastViewPortTotalHeight;
  late final delegate = widget.delegates[widget.index];
  late final height = delegate.viewPortHeight(widget.screenSize);
  late FreezedMetrics metrics = FreezedMetrics.zero(height, widget.screenSize);

  @override
  void didUpdateWidget(covariant FreezedChild oldWidget) {
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
    return (widget.index == 0).then(
      () {
        final max = height - widget.screenSize.height;
        final dy = offset.clamp(0.0, max);
        return FreezedMetrics(
          freezedDy: dy,
          origin: offset,
          childHeight: height,
          scrollOffset: offset,
          viewPortSize: widget.screenSize,
        );
      },
      orElse: () {
        final pastScrolledHeight = _calcPastViewPortHeight();
        final pastScrollableHeight = pastScrolledHeight - height;
        final origin =
            (offset + widget.screenSize.height) - pastScrollableHeight;

        final max = pastScrolledHeight - widget.screenSize.height;
        final clampedOffset = offset.clamp(0.0, max);
        final dy = (clampedOffset - (pastScrollableHeight))
            .clamp(0.0, max - (pastScrollableHeight));

        return FreezedMetrics(
          origin: origin.abs(),
          freezedDy: dy,
          childHeight: height,
          scrollOffset: offset,
          viewPortSize: widget.screenSize,
        );
      },
    )!;
  }

  double _calcPastViewPortHeight() {
    return _pastViewPortTotalHeight ??= widget.delegates.transform<double>(
          (e, result) {
            return e.viewPortHeight(widget.screenSize) + (result ?? 0);
          },
          end: widget.index + 1,
        ) ??
        0;
  }
}
