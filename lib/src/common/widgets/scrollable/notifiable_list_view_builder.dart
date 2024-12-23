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
    return LayoutBuilder(
      builder: (context, constraints) {
        late final screenSize = constraints.biggest;
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
                    screenSize: screenSize,
                    index: index,
                  ),
                ),
                orElse: () => widget.children[index],
              );
            },
          ),
        );
      },
    );
  }
}

class FreezedWidgetDelegate {
  FreezedWidgetDelegate({
    required this.freezeViewPortHeight,
    required this.childBuilder,
    this.shouldFreeze = true,
  });

  final double freezeViewPortHeight;
  final Widget Function(FreezedMetrics metrics) childBuilder;
  final bool shouldFreeze;
}

class FreezedMetrics {
  const FreezedMetrics({
    required this.scrollOffset,
    required this.widgetOffset,
  });
  const FreezedMetrics.zero(this.scrollOffset) : widgetOffset = 0;

  final double scrollOffset;
  final double widgetOffset;
}
