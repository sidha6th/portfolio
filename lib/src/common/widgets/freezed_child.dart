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
  late final currentDelegate = widget.delegates[widget.index];
  late FreezedMetrics metrics = FreezedMetrics.zero(
    0,
    currentDelegate.freezeViewPortHeight,
  );

  @override
  void didUpdateWidget(covariant FreezedChild oldWidget) {
    final offset = widget.scrollMetrics?.pixels ?? 0;
    metrics = currentDelegate.shouldFreeze.then(() => _metrics(offset)) ??
        FreezedMetrics.zero(offset, currentDelegate.freezeViewPortHeight);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return currentDelegate.shouldFreeze.then(
      () {
        return Transform.translate(
          offset: Offset(0, metrics.freezedOffset),
          child: currentDelegate.childBuilder(metrics),
        );
      },
      orElse: () => currentDelegate.childBuilder(metrics),
    )!;
  }

  double _calcPastViewPortHeight() {
    return _pastViewPortTotalHeight ??= widget.delegates.transform<double>(
          (e, result) {
            return e.freezeViewPortHeight + (result ?? 0);
          },
          end: widget.index + 1,
        ) ??
        0;
  }

  FreezedMetrics _metrics(
    double offset,
  ) {
    return (widget.index == 0).then(
      () {
        final max =
            currentDelegate.freezeViewPortHeight - widget.screenSize.height;
        return FreezedMetrics(
          scrollOffset: offset,
          freezedOffset: offset.clamp(0.0, max),
          height: currentDelegate.freezeViewPortHeight,
        );
      },
      orElse: () {
        final totalPastHeight = _calcPastViewPortHeight();
        final max = totalPastHeight - currentDelegate.freezeViewPortHeight;
        final clampedOffset =
            offset.clamp(0, totalPastHeight - widget.screenSize.height);
        return FreezedMetrics(
          scrollOffset: offset,
          height: currentDelegate.freezeViewPortHeight,
          freezedOffset: (clampedOffset - max).clamp(0.0, double.infinity),
        );
      },
    )!;
  }
}
