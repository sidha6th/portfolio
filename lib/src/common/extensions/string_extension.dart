extension NullableStringExtension on String? {
  bool get hasData => this != null && this!.trim().isNotEmpty;
  bool get hasNoData => this == null || this!.trim().isEmpty;
}
