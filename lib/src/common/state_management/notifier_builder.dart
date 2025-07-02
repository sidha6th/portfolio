import 'package:flutter/widgets.dart'
    show StatefulWidget, Widget, State, BuildContext;
import 'package:provider/provider.dart' show Provider;
import 'package:sidharth/src/common/state_management/base_notifier.dart';

class NotifierBuilder<N extends BaseNotifier<S>, S> extends StatefulWidget {
  const NotifierBuilder({
    required this.builder,
    this.buildWhen,
    this.onInit,
    super.key,
  });

  final void Function(N notifier)? onInit;
  final bool Function(S previous, S current)? buildWhen;
  final Widget Function(BuildContext context, S state) builder;

  @override
  State<StatefulWidget> createState() => _NotifierBuilderState<N, S>();
}

class _NotifierBuilderState<N extends BaseNotifier<S>, S>
    extends State<NotifierBuilder<N, S>> {
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
    final shouldRebuild =
        widget.buildWhen?.call(currentState, notifier.state) ?? true;
    currentState = notifier.state;
    if (shouldRebuild) setState(() {});
  }
}
