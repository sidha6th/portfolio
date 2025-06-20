class LoadingHandlerState {
  const LoadingHandlerState({this.isLoading = true})
    : progress = 0,
      loadingStepCount = 0;

  const LoadingHandlerState._({
    required this.isLoading,
    this.loadingStepCount,
    this.progress,
  });

  final bool isLoading;
  final double? progress;
  final int? loadingStepCount;

  LoadingHandlerState copyWith({
    double? progress,
    bool? isLoading,
    int? loadingStepCount,
  }) {
    return LoadingHandlerState._(
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      loadingStepCount: loadingStepCount ?? this.loadingStepCount,
    );
  }

  LoadingHandlerState completed() =>
      const LoadingHandlerState._(isLoading: false);

  @override
  bool operator ==(covariant LoadingHandlerState other) {
    if (identical(this, other)) return true;

    return other.progress == progress &&
        other.isLoading == isLoading &&
        other.loadingStepCount == loadingStepCount;
  }

  @override
  int get hashCode =>
      progress.hashCode ^ isLoading.hashCode ^ loadingStepCount.hashCode;
}
