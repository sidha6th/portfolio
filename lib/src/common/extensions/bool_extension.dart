extension BoolExtension on bool {
  T then<T>(T Function() isTrue, {required T Function() orElse}) {
    if (this) return isTrue();
    return orElse();
  }
}
