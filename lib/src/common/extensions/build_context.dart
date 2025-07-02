import 'package:flutter/widgets.dart';

extension ExtensionOnSize on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
}
