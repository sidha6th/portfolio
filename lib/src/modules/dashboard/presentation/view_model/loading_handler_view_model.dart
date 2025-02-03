import 'package:flutter/material.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:stacked/stacked.dart';

class LoadingHandlerViewModel extends BaseViewModel {
  LoadingHandlerViewModel({
    required this.scrollController,
  });

  final ScrollController scrollController;
  bool loadingContent = true;
  double? progress;
  late var maxProgress = scrollController.position.maxScrollExtent * 2;

  void init() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await scroll();
        addScrollListener();
        await scroll(0);
        notifyListeners();
        loadingContent = false;
        removeScrollListener();
      },
    );
  }

  Future<void> scroll([double? offset]) {
    return scrollController.animateTo(
      offset ?? scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.elasticIn,
    );
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
