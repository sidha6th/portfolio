import 'package:flutter/material.dart';
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
  late var maxProgress = scrollController.position.maxScrollExtent * 2;
  final VoidCallback whenLoadingCompleted;

  void init() {
    addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await scroll();
        await scroll(0);
        whenLoadingCompleted();
        loadingContent = false;
        notifyListeners();
        removeScrollListener();
      },
    );
  }

  Future<void> scroll([double? offset]) {
    return scrollController
        .animateTo(
          offset ?? scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
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
}
