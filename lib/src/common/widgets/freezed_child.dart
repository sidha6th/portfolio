import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/core/extensions/bool.dart';
import 'package:sidharth/src/core/extensions/build_context.dart';
import 'package:sidharth/src/core/extensions/iterable.dart';
import 'package:sidharth/src/modules/dashboard/presentation/provider/scroll_offset_state_provider.dart';

class FreezedChild extends ConsumerStatefulWidget {
  const FreezedChild({
    required this.delegates,
    required this.index,
    super.key,
  });

  final List<FreezedWidgetDelegate> delegates;
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FreezedChildState();
}

class _FreezedChildState extends ConsumerState<FreezedChild> {
  late final size = context.screenSize;
  late final currentDelegate = widget.delegates[widget.index];
  double? _pastViewPortTotalHeight;
  double calcPastViewPortHeight() {
    return _pastViewPortTotalHeight ??= widget.delegates.transform<double>(
          (e, result) {
            return e.freezeViewPortHeight + (result ?? 0);
          },
          end: widget.index + 1,
        ) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    final metrics = ref.watch(dashBoardScrollMetricsProvider);
    final offset = metrics?.pixels ?? 0;
    final dy = (widget.index == 0).then(
      () {
        final max = currentDelegate.freezeViewPortHeight - size.height;
        return offset.clamp(0.0, max);
      },
      orElse: () {
        final totalPastHeight = calcPastViewPortHeight();
        final max = totalPastHeight - currentDelegate.freezeViewPortHeight;
        final clampedOffset = offset.clamp(0, totalPastHeight - size.height);
        return (clampedOffset - max).clamp(0.0, double.infinity);
      },
    )!;

    return Transform.translate(
      offset: Offset(0, dy),
      child: currentDelegate.childBuilder(dy),
    );
  }
}
