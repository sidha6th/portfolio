extension ExtensionOnNullableBool on bool? {
  /// Executes the [ifTrue] callback when the boolean is `true`.
  /// If the boolean is `false` and [orElse] is provided, executes the [orElse] callback.
  /// If the boolean is `null`, it executes based on the [fallbackTo] value.
  ///
  /// Example:
  /// ```dart
  /// final result = true.when(
  ///   () => "It's true!",
  ///   orElse: () => "It's false!",
  ///   fallbackTo: false,
  /// );
  /// print(result); // Output: "It's true!"
  /// ```
  T? then<T>(
    T Function() ifTrue, {
    T Function()? orElse,
    bool fallbackTo = false,
  }) {
    if (this ?? fallbackTo) return ifTrue();
    return orElse?.call();
  }
}
