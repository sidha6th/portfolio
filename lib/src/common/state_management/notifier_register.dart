import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:sidharth/src/common/state_management/base_notifier.dart';

class NotifierRegister<N extends BaseNotifier<V>, V extends Object?>
    extends StatelessWidget {
  const NotifierRegister({
    required this.create,
    super.key,
    this.lazy,
    this.child,
    this.builder,
  });

  final bool? lazy;
  final Widget? child;
  final N Function(BuildContext context) create;
  final Widget Function(BuildContext context, Widget? child)? builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: lazy,
      create: create,
      builder: builder,
      child: child,
    );
  }
}
