import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:sidharth/src/common/extensions/build_context_extension.dart';
import 'package:sidharth/src/common/extensions/iterable_extension.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/freezed_child.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_state.dart';

class ChildWrapper extends StatefulWidget {
  const ChildWrapper({
    required this.size,
    required this.index,
    required this.delegates,
    required this.hasInitialized,
    super.key,
  });

  final Size size;
  final int index;
  final bool hasInitialized;
  final List<FreezedWidgetDelegate> delegates;

  @override
  State<ChildWrapper> createState() => _ChildWrapperState();
}

class _ChildWrapperState extends State<ChildWrapper> {
  late final _key = Key('${widget.index}-Freezed#Child');
  FreezedWidgetDelegate get _delegate => widget.delegates[widget.index];
  late var scrollFreezeHeight = _delegate.freezedScrollHeight(widget.size);
  late var pastScrolledHeight = _calcPastViewPortHeight();

  late Widget child = createChildWidget();

  @override
  void didUpdateWidget(covariant ChildWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    scrollFreezeHeight = _delegate.freezedScrollHeight(widget.size);
    pastScrolledHeight = _calcPastViewPortHeight();
    child = createChildWidget();
  }

  @override
  Widget build(BuildContext context) => child;

  Widget createChildWidget() {
    return SizedBox(
      width: widget.size.width,
      height: scrollFreezeHeight,
      child: BlocBuilder<ScrollObserverBloc, ScrollObserverState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return FreezedChild(
            key: _key,
            index: widget.index,
            screenSize: widget.size,
            currentDelegate: _delegate,
            delegates: widget.delegates,
            hasInitialized: widget.hasInitialized,
            pastScrolledHeight: pastScrolledHeight,
            scrollFreezeHeight: scrollFreezeHeight,
            scrollPosition: state.currentScrollPosition,
            setFocusedDelegate: context.scrollObsBloc.add,
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
