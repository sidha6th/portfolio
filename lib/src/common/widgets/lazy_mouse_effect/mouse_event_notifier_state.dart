import 'package:flutter/material.dart';

class MouseLazyEffectState {
  const MouseLazyEffectState({
    this.visible = false,
    this.innerDotOffset = Offset.zero,
    this.outerCircleOffset = Offset.zero,
  });

  final bool visible;
  final Offset innerDotOffset;
  final Offset outerCircleOffset;

  MouseLazyEffectState onMove({
    required Offset innerOffset,
    required Offset outerOffset,
  }) {
    return copyWith(
      innerEffectOffset: innerOffset,
      outerEffectOffset: outerOffset,
    );
  }

  MouseLazyEffectState toggleVisibility(bool visible) {
    return copyWith(visible: visible);
  }

  MouseLazyEffectState copyWith({
    bool? visible,
    Offset? innerEffectOffset,
    Offset? outerEffectOffset,
  }) {
    return MouseLazyEffectState(
      visible: visible ?? this.visible,
      innerDotOffset: innerEffectOffset ?? innerDotOffset,
      outerCircleOffset: outerEffectOffset ?? outerCircleOffset,
    );
  }

  @override
  bool operator ==(covariant MouseLazyEffectState other) {
    if (identical(this, other)) return true;

    return other.visible == visible &&
        other.innerDotOffset == innerDotOffset &&
        other.outerCircleOffset == outerCircleOffset;
  }

  @override
  int get hashCode =>
      visible.hashCode ^ innerDotOffset.hashCode ^ outerCircleOffset.hashCode;
}
