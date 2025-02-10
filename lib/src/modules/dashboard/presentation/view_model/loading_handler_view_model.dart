import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:stacked/stacked.dart';

class LoadingHandlerViewModel extends BaseViewModel {
  LoadingHandlerViewModel(
    ScrollController this._scrollController, {
    required this.whenLoadingCompleted,
  })  : _progress = 0,
        _loadingStepCount = 0;

  double? _progress;
  int? _loadingStepCount;
  ScrollController? _scrollController;

  bool isLoading = true;
  final VoidCallback whenLoadingCompleted;

  int get loadingStepCount => _loadingStepCount ?? 0;
  double get progress => _progress ?? 0;

  void init([VoidCallback? task]) {
    task?.call();
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
    return _scrollController!
        .animateTo(
          offset ?? _scrollController!.position.maxScrollExtent,
          duration: KDurations.s1,
          curve: Curves.slowMiddle,
        )
        .then(_incrementLoadingStepCount);
  }

  void _addScrollListener() {
    _scrollController!.addListener(_updateLoadingProgress);
  }

  void _removeScrollListener() {
    _scrollController!.removeListener(_updateLoadingProgress);
  }

  void _incrementLoadingStepCount(_) {
    _loadingStepCount = loadingStepCount + 1;
  }

  void _updateLoadingProgress() {
    final maxExtend = _scrollController!.position.maxScrollExtent;
    _progress = normalize(
      value: maxExtend - _scrollController!.offset,
      end: maxExtend,
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
    _scrollController = null;

    dispose();
  }
}
