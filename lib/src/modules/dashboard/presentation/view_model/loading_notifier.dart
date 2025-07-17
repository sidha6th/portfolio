import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:syncx/syncx.dart';

class LoadingState {
  LoadingState();
  double? progress;
  int? loadingStepCount;
  bool isLoading = true;

  void toCompleted() {
    progress = null;
    isLoading = false;
    loadingStepCount = null;
  }
}

class LoadingNotifier extends Notifier<LoadingState> {
  LoadingNotifier() : super(LoadingState());
  Future<void> startLoading(
    ScrollController controller, {
    VoidCallback? whenCompleted,
  }) async {
    void addListener() => _updateLoadingProgress(controller);
    controller.addListener(addListener);
    await _scroll(controller);
    await _scroll(controller, 0);
    controller.removeListener(addListener);
    state.toCompleted();
    setState(state, forced: true);
    whenCompleted?.call();
  }

  void _updateLoadingProgress(ScrollController controller) {
    final maxExtend = controller.position.maxScrollExtent;
    state.progress = normalize(
      value: maxExtend - controller.offset,
      end: maxExtend,
    );
    setState(state, forced: true);
  }

  Future<void> _scroll(ScrollController controller, [double? offset]) async {
    await controller.animateTo(
      offset ?? controller.position.maxScrollExtent,
      duration: KDurations.s1,
      curve: Curves.slowMiddle,
    );
    _incrementLoadingStepCount();
  }

  void _incrementLoadingStepCount() {
    state.loadingStepCount = (state.loadingStepCount ?? 0) + 1;
  }
}
