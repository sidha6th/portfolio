import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/extensions/iterable.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/state_management/notifier_consumer.dart';
import 'package:sidharth/src/common/widgets/freezed_child.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/screen_size_notifier.dart';

class ChildWrapper extends StatefulWidget {
  const ChildWrapper({
    required this.index,
    required this.delegates,
    required this.scrollController,
    super.key,
  });

  final int index;
  final List<StickableDelegate> delegates;
  final ScrollController scrollController;

  @override
  State<ChildWrapper> createState() => _ChildWrapperState();
}

class _ChildWrapperState extends State<ChildWrapper> {
  late final _key = Key('${widget.index}-Freezed#Child');
  StickableDelegate get _delegate => widget.delegates[widget.index];
  late var scrollFreezeHeight = _delegate.height(context.screenSize);
  late var pastScrolledHeight = _calcPastViewPortHeight();

  late var _child = _createChildWidget();

  void _whenResize(_) {
    scrollFreezeHeight = _delegate.height(context.screenSize);
    pastScrolledHeight = _calcPastViewPortHeight();
    _child = _createChildWidget();
  }

  @override
  Widget build(BuildContext context) =>
      NotifierConsumer<ScreenSizeNotifier, Size>(
        listener: _whenResize,
        builder: (context, _) => _child,
      );

  Widget _createChildWidget() {
    return SizedBox(
      height: scrollFreezeHeight,
      width: context.screenSize.width,
      child: StickableChild(
        key: _key,
        index: widget.index,
        currentDelegate: _delegate,
        delegates: widget.delegates,
        screenSize: context.screenSize,
        pastScrolledHeight: pastScrolledHeight,
        scrollFreezeHeight: scrollFreezeHeight,
        scrollController: widget.scrollController,
        child: _delegate.child,
      ),
    );
  }

  double _calcPastViewPortHeight() {
    final windowSize = context.screenSize;
    return widget.delegates.transform<double>(
          (e, result) => e.height(windowSize) + (result ?? 0),
          end: widget.index + 1,
        ) ??
        0;
  }
}
