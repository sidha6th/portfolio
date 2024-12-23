import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/core/extensions/bool.dart';
import 'package:sidharth/src/core/extensions/iterable.dart';
import 'package:sidharth/src/modules/dashboard/presentation/provider/scroll_offset_state_provider.dart';

class FreezedChild extends ConsumerStatefulWidget {
  const FreezedChild({
    required this.delegates,
    required this.index,
    required this.screenSize,
    super.key,
  });

  final List<FreezedWidgetDelegate> delegates;
  final int index;
  final Size screenSize;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FreezedChildState();
}

class _FreezedChildState extends ConsumerState<FreezedChild> {
  late final currentDelegate = widget.delegates[widget.index];
  double? _pastViewPortTotalHeight;

  @override
  Widget build(BuildContext context) {
    final scrollMetrics = ref.watch(dashBoardScrollMetricsProvider);
    final offset = scrollMetrics?.pixels ?? 0;

    return currentDelegate.shouldFreeze.then(
      () {
        final freezedMetrics = _metrics(offset);
        return Transform.translate(
          offset: Offset(0, freezedMetrics.widgetOffset),
          child: currentDelegate.childBuilder(freezedMetrics),
        );
      },
      orElse: () => currentDelegate.childBuilder(FreezedMetrics.zero(offset)),
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
          widgetOffset: offset.clamp(0.0, max),
        );
      },
      orElse: () {
        final totalPastHeight = _calcPastViewPortHeight();
        final max = totalPastHeight - currentDelegate.freezeViewPortHeight;
        final clampedOffset =
            offset.clamp(0, totalPastHeight - widget.screenSize.height);
        return FreezedMetrics(
          scrollOffset: offset,
          widgetOffset: (clampedOffset - max).clamp(0.0, double.infinity),
        );
      },
    )!;
  }
}
