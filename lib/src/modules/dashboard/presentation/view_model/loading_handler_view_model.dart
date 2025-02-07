import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:stacked/stacked.dart';

class LoadingHandlerViewModel extends BaseViewModel {
  LoadingHandlerViewModel({
    required this.scrollController,
    required this.whenLoadingCompleted,
  });

  final ScrollController scrollController;
  bool loadingContent = true;
  double? progress;
  int loadingInfoTextIndex = 0;
  bool testScrollCompleted = false;
  final VoidCallback whenLoadingCompleted;

  void init() {
    addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await _scroll();
        await _scroll(0);
        testScrollCompleted = true;
        notifyListeners();
        Future.delayed(
          KDimensions.loadingScaleTransitionDuration,
          _closeLoading,
        );
      },
    );
  }

  Future<void> _scroll([double? offset]) {
    return scrollController
        .animateTo(
          offset ?? scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.slowMiddle,
        )
        .then((value) => loadingInfoTextIndex++);
  }

  void addScrollListener() {
    scrollController.addListener(updateLoadingProgress);
  }

  void removeScrollListener() {
    scrollController.removeListener(updateLoadingProgress);
  }

  void updateLoadingProgress() {
    progress = normalize(
      value:
          scrollController.position.maxScrollExtent - scrollController.offset,
      end: scrollController.position.maxScrollExtent,
    );
    notifyListeners();
  }

  void _closeLoading() {
    whenLoadingCompleted();
    loadingContent = false;
    notifyListeners();
    removeScrollListener();
  }
}
