import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:stacked/stacked.dart';

class LoadingHandlerViewModel extends BaseViewModel {
  LoadingHandlerViewModel(
    ScrollController this.scrollController, {
    required this.whenLoadingCompleted,
  })  : _progress = 0,
        _loadingStepCount = 0;

  double? _progress;

  bool isLoading = true;
  ScrollController? scrollController;
  final VoidCallback whenLoadingCompleted;
  int? _loadingStepCount;

  int get loadingStepCount => _loadingStepCount ?? 0;
  double get progress => _progress ?? 0;
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
    _loadingStepCount = loadingStepCount + 1;
  }

  void _updateLoadingProgress() {
    _progress = normalize(
      value:
          scrollController!.position.maxScrollExtent - scrollController!.offset,
      end: scrollController!.position.maxScrollExtent,
    );
    notifyListeners();
  }

  void _closeLoading() {
    whenLoadingCompleted();
    _progress = null;
    isLoading = false;
    _loadingStepCount = null;
    notifyListeners();
    _removeScrollListener();
    scrollController = null;

    dispose();
  }
}
