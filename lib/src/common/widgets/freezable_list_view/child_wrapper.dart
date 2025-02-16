import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/iterable.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/freezed_child.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_observing_view_model.dart';
import 'package:stacked/stacked.dart';

class ChildWrapper extends StatefulWidget {
  const ChildWrapper({
    required this.size,
    required this.index,
    required this.model,
    required this.delegates,
    required this.hasInitialized,
    super.key,
  });

  final Size size;
  final int index;
  final bool hasInitialized;
  final ScrollObservingViewModel model;
  final List<FreezedWidgetDelegate> delegates;

  @override
  State<ChildWrapper> createState() => _ChildWrapperState();
}

class _ChildWrapperState extends State<ChildWrapper> {
  late final _key = Key('${widget.index}-Freezed#Child');
  FreezedWidgetDelegate get _delegate => widget.delegates[widget.index];
  late var scrollFreezeHeight = _delegate.freezedScrollHeight(widget.size);
  late var pastScrolledHeight = _calcPastViewPortHeight();

  @override
  void didUpdateWidget(covariant ChildWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    scrollFreezeHeight = _delegate.freezedScrollHeight(widget.size);
    pastScrolledHeight = _calcPastViewPortHeight();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: scrollFreezeHeight,
      child: ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.model,
        builder: (context, model, child) {
          return FreezedChild(
            key: _key,
            index: widget.index,
            screenSize: widget.size,
            currentDelegate: _delegate,
            delegates: widget.delegates,
            scrollMetrics: model.metrics,
            hasInitialized: widget.hasInitialized,
            pastScrolledHeight: pastScrolledHeight,
            scrollFreezeHeight: scrollFreezeHeight,
            setFocusedDelegate: model.setCurrentDelegateState,
          );
        },
      ),
    );
  }

  double _calcPastViewPortHeight() {
    return widget.delegates.transform<double>(
          (e, result) => e.freezedScrollHeight(widget.size) + (result ?? 0),
          end: widget.index + 1,
        ) ??
        0;
  }
}
