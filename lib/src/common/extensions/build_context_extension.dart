import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_bloc.dart';

extension BuildContextExtension on BuildContext {
  ScrollObserverBloc get scrollObsBloc => read<ScrollObserverBloc>();
  LoadingHandlerBloc get loadingHandlerBloc => read<LoadingHandlerBloc>();
}
