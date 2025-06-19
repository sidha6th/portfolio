import 'package:flutter/widgets.dart' show ScrollController, Curves;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_event.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_state.dart';

class LoadingHandlerBloc
    extends Bloc<LoadingHandlerEvent, LoadingHandlerState> {
  LoadingHandlerBloc() : super(const LoadingHandlerState()) {
    on<StartLoadPage>(_onStartedLoadPage);
  }

  Future<void> _onStartedLoadPage(
    StartLoadPage event,
    Emitter<LoadingHandlerState> emit,
  ) async {
    event.onStart?.call();
    void update() => _updateLoadingProgress(emit, event.scrollController);
    event.scrollController.addListener(update);
    await _scroll(emit, event.scrollController);
    await _scroll(emit, event.scrollController, 0);
    event.scrollController.removeListener(update);
    emit(state.completed());
    event.onFinish?.call();
  }

  Future<void> _scroll(
    Emitter<LoadingHandlerState> emit,
    ScrollController controller, [
    double? offset,
  ]) async {
    await controller.animateTo(
      offset ?? controller.position.maxScrollExtent,
      duration: KDurations.s1,
      curve: Curves.slowMiddle,
    );
    emit(state.copyWith(loadingStepCount: (state.loadingStepCount ?? 0) + 1));
  }

  void _updateLoadingProgress(
    Emitter<LoadingHandlerState> emit,
    ScrollController controller,
  ) {
    final maxExtend = controller.position.maxScrollExtent;
    final progress = normalize(
      value: maxExtend - (controller.offset),
      end: maxExtend,
    );
    emit(state.copyWith(progress: progress));
  }
}
