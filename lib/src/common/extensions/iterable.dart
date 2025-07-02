extension ExtensionOnIterable<T> on Iterable<T> {
  R? transform<R>(R? Function(T e, R? result) action, {int? end}) {
    R? finalResult;
    for (var i = 0; i < (end ?? length); i++) {
      final e = elementAt(i);
      final result = action(e, finalResult);
      if (result == null) continue;
      finalResult = result;
    }
    return finalResult;
  }

  T? safeAt(int index) {
    if (index > length - 1 || index < 0) return null;
    return elementAt(index);
  }
}
