import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:stacked/stacked.dart';

class LoadingHandlerViewModel extends BaseViewModel {
  LoadingHandlerViewModel(
    ScrollController this.scrollController, {
    required this.whenLoadingCompleted,
  })  : progress = 0,
        loadingStepCount = 0;

  double? progress;
  bool isLoading = true;
  int? loadingStepCount;
  ScrollController? scrollController;
  final VoidCallback whenLoadingCompleted;

  void init() {
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await _scroll();
        await _scroll(0);
        _closeLoading();
      },
    );
  }

  Future<void> _scroll([double? offset]) {
    return scrollController!
        .animateTo(
          offset ?? scrollController!.position.maxScrollExtent,
          duration: KDurations.s1,
          curve: Curves.slowMiddle,
        )
        .then(_incrementLoadingStepCount);
  }

  void _addScrollListener() {
    scrollController!.addListener(_updateLoadingProgress);
  }

  void _removeScrollListener() {
    scrollController!.removeListener(_updateLoadingProgress);
  }

  void _incrementLoadingStepCount(_) {
    loadingStepCount = loadingStepCount! + 1;
  }

  void _updateLoadingProgress() {
    progress = normalize(
      value:
          scrollController!.position.maxScrollExtent - scrollController!.offset,
      end: scrollController!.position.maxScrollExtent,
    );
    notifyListeners();
  }

  void _closeLoading() {
    whenLoadingCompleted();
    progress = null;
    isLoading = false;
    loadingStepCount = null;
    notifyListeners();
    _removeScrollListener();
    scrollController = null;

    dispose();
  }
}
