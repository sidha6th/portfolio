import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidharth/src/common/widgets/freezed_child.dart';
import 'package:sidharth/src/core/extensions/bool.dart';
import 'package:sidharth/src/modules/dashboard/presentation/provider/scroll_offset_state_provider.dart';

class NotifiableLisViewBuilder extends ConsumerStatefulWidget {
  const NotifiableLisViewBuilder({
    super.key,
    this.itemBuilder,
    this.delegates = const [],
    this.children = const [],
    this.itemCount,
  });

  final Widget? Function(BuildContext, int)? itemBuilder;
  final List<FreezedWidgetDelegate> delegates;
  final List<Widget> children;
  final int? itemCount;

  @override
  ConsumerState<NotifiableLisViewBuilder> createState() =>
      _NotifiableLisViewBuilderState();
}

class _NotifiableLisViewBuilderState
    extends ConsumerState<NotifiableLisViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        ref.read(dashBoardScrollMetricsProvider.notifier).state =
            notification.metrics;
        return true;
      },
      child: ListView.builder(
        itemCount: (widget.children.isEmpty)
            ? widget.delegates.length
            : widget.children.length,
        itemBuilder: (context, index) {
          return (widget.children.isEmpty).then(
            () => SizedBox(
              height: widget.delegates[index].freezeViewPortHeight,
              child: FreezedChild(
                delegates: widget.delegates,
                index: index,
              ),
            ),
            orElse: () => widget.children[index],
          );
        },
      ),
    );
  }
}

class FreezedWidgetDelegate {
  FreezedWidgetDelegate({
    required this.freezeViewPortHeight,
    required this.childBuilder,
  });

  final double freezeViewPortHeight;
  final Widget Function(double offset) childBuilder;
}
