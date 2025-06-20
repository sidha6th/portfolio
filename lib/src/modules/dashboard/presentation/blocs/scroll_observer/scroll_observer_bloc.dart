import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_event.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_state.dart';

class ScrollObserverBloc
    extends Bloc<ScrollObserverEvent, ScrollObserverState> {
  ScrollObserverBloc() : super(const ScrollObserverState()) {
    on<UpdateScrollMetrics>(_onUpdateScrollMetrics);
    on<SetCurrentDelegate>(_onSetCurrentDelegate);
  }

  void _onUpdateScrollMetrics(
    UpdateScrollMetrics event,
    Emitter<ScrollObserverState> emit,
  ) => emit(state.updateScrollMetric(event.position));

  void _onSetCurrentDelegate(
    SetCurrentDelegate event,
    Emitter<ScrollObserverState> emit,
  ) {
    emit(
      state.copyWith(
        index: event.index,
        currentDelegate: event.delegate,
        normalizedCurrentSectionScrolledOffset: event.lerp,
      ),
    );
  }
}
