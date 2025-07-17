import 'package:flutter/material.dart' show Size;
import 'package:syncx/syncx.dart';

class ScreenSizeNotifier extends Notifier<Size> {
  ScreenSizeNotifier(super.state);

  void onChangeSize(Size newSize) => setState(newSize);
}
