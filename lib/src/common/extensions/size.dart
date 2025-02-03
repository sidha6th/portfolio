import 'dart:math' as math;

import 'package:flutter/widgets.dart';

extension ExtensionOnSize on Size {
  double get max => math.max(width, height);
  double get min => math.min(width, height);
}
