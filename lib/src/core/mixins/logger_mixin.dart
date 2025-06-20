import 'dart:async' show Zone;
import 'dart:developer' as dev show log;

import 'package:flutter/foundation.dart' show kDebugMode, protected;
import 'package:sidharth/src/common/extensions/string_extension.dart';

mixin LoggerMixin {
  @protected
  void log(
    Object? value, {
    Object? error,
    StackTrace? stackTrace,
    String? title,
  }) {
    if (!kDebugMode) return;

    if (title.hasData) {
      dev.log(
        '-------------------------------- $title --------------------------------',
      );
    }

    dev.log(
      error != null ? '' : value.toString(),
      error: error,
      zone: Zone.root,
      stackTrace: stackTrace,
    );
  }
}
