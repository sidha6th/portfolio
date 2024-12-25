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
  late final delegate = widget.delegates[widget.index];
  late final totalPastHeight =
      widget.index == 0 ? 0 : _calcPastViewPortHeight();
  late final origin = (widget.index == 0)
      ? delegate.viewPortHeight - widget.screenSize.height
      : totalPastHeight - delegate.viewPortHeight;

  double? _pastViewPortTotalHeight;
  late FreezedMetrics metrics =
      FreezedMetrics.zero(0, delegate.viewPortHeight, 0);

  @override
  void didUpdateWidget(covariant FreezedChild oldWidget) {
    final offset = widget.scrollMetrics?.pixels ?? 0;

    metrics = _metrics(offset);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return delegate.shouldFreeze.then(
      () {
        return Transform.translate(
          offset: Offset(0, metrics.freezedOffset),
          child: delegate.childBuilder(metrics),
        );
      },
      orElse: () => delegate.childBuilder(metrics),
    )!;
  }

  double _calcPastViewPortHeight() {
    return _pastViewPortTotalHeight ??= widget.delegates.transform<double>(
          (e, result) {
            return e.viewPortHeight + (result ?? 0);
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
        return FreezedMetrics(
          scrollOffset: offset,
          freezedOffset: offset.clamp(0.0, origin),
          height: delegate.viewPortHeight,
          origin: widget.scrollMetrics?.minScrollExtent ?? 0,
        );
      },
      orElse: () {
        final clampedOffset =
            offset.clamp(0.0, totalPastHeight - widget.screenSize.height);
        return FreezedMetrics(
          scrollOffset: offset,
          freezedOffset: (clampedOffset - origin).clamp(0.0, double.infinity),
          height: delegate.viewPortHeight,
          origin: origin,
        );
      },
    )!;
  }
}
