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

  T? get safeFirst {
    if (isEmpty) return null;
    return first;
  }

  T? safeElementAt(int index) {
    if (isEmpty) return null;
    return elementAt(index);
  }

  T? get safeLast {
    if (isEmpty) return null;
    return last;
  }
}
