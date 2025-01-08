extension Normalize on num {
  /// Normalize a value to the range 0-1 given [minValue] and [maxValue].
  double normalize(num minValue, num maxValue) {
    if (minValue == maxValue) return 0.0; // Avoid division by zero
    return (this - minValue) / (maxValue - minValue);
  }
}
