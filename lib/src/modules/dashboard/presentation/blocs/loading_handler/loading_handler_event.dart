import 'package:flutter/material.dart' show VoidCallback, ScrollController;

class LoadingHandlerEvent {
  const LoadingHandlerEvent();
}

class StartLoadPage extends LoadingHandlerEvent {
  const StartLoadPage(this.scrollController, {this.onStart, this.onFinish});

  final VoidCallback? onStart;
  final VoidCallback? onFinish;
  final ScrollController scrollController;
}
