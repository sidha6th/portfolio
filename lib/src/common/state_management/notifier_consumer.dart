import 'package:flutter/widgets.dart'
    show StatefulWidget, Widget, State, BuildContext;
import 'package:provider/provider.dart' show Provider;
import 'package:sidharth/src/common/state_management/base_notifier.dart';

class NotifierConsumer<N extends BaseNotifier<S>, S> extends StatefulWidget {
  const NotifierConsumer({
    required this.builder,
    required this.listener,
    this.buildWhen,
    this.listenWhen,
    this.onInit,
    super.key,
  });

  final void Function(S state) listener;
  final void Function(N notifier)? onInit;
  final bool Function(S previous, S current)? buildWhen;
  final bool Function(S previous, S current)? listenWhen;
  final Widget Function(BuildContext context, S state) builder;

  @override
  State<StatefulWidget> createState() => _NotifierConsumerState<N, S>();
}

class _NotifierConsumerState<N extends BaseNotifier<S>, S>
    extends State<NotifierConsumer<N, S>> {
  late final notifier = Provider.of<N>(context, listen: false);
  late S currentState = notifier.state;

  @override
  void initState() {
    super.initState();
    notifier.addListener(_stateChanged);
    widget.onInit?.call(notifier);
  }

  @override
  void dispose() {
    notifier.removeListener(_stateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, currentState);
  }

  void _stateChanged() {
    if (widget.buildWhen?.call(currentState, notifier.state) ?? true) {
      setState(() {});
    }
    if (widget.listenWhen?.call(currentState, notifier.state) ?? true) {
      widget.listener(currentState);
    }
    currentState = notifier.state;
  }
}
