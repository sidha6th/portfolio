import 'package:flutter/widgets.dart'
    show StatefulWidget, Widget, State, BuildContext;
import 'package:provider/provider.dart' show Provider;
import 'package:sidharth/src/common/state_management/base_notifier.dart';

class NotifierListener<N extends BaseNotifier<S>, S> extends StatefulWidget {
  const NotifierListener({
    required this.child,
    required this.listener,
    this.listenWhen,
    this.onInit,
    super.key,
  });

  final Widget child;
  final void Function(S state) listener;
  final void Function(N notifier)? onInit;
  final bool Function(S previous, S current)? listenWhen;

  @override
  State<StatefulWidget> createState() => _NotifierListenerState<N, S>();
}

class _NotifierListenerState<N extends BaseNotifier<S>, S>
    extends State<NotifierListener<N, S>> {
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
    return widget.child;
  }

  void _stateChanged() {
    final shouldListen =
        widget.listenWhen?.call(currentState, notifier.state) ?? true;
    currentState = notifier.state;
    if (shouldListen) widget.listener(currentState);
  }
}
