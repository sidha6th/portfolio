import 'package:flutter/material.dart';
import 'package:sidharth/src/common/state_management/base_notifier.dart';

class ScreenSizeNotifier extends BaseNotifier<Size> {
  ScreenSizeNotifier(super.state);

  void onChangeSize(Size newSize) => setState(newSize);
}
