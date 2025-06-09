import 'package:flutter/material.dart';

class MouseLazyEffectState {
  const MouseLazyEffectState({
    this.visible = false,
    this.outerCircleOffset,
    this.innerEffectOffset = Offset.zero,
  });

  final bool visible;
  final Offset innerEffectOffset;
  final Offset? outerCircleOffset;

  MouseLazyEffectState onMove({
    required Offset innerOffset,
    required Offset outerOffset,
  }) {
    return copyWith(
      innerEffectOffset: innerOffset,
      outerEffectOffset: outerOffset,
    );
  }

  MouseLazyEffectState toggleVisiblity(bool visible) {
    return copyWith(visible: visible);
  }

  MouseLazyEffectState copyWith({
    bool? visible,
    Offset? innerEffectOffset,
    Offset? outerEffectOffset,
  }) {
    return MouseLazyEffectState(
      visible: visible ?? this.visible,
      innerEffectOffset: innerEffectOffset ?? this.innerEffectOffset,
      outerCircleOffset: outerEffectOffset ?? this.outerCircleOffset,
    );
  }

  @override
  bool operator ==(covariant MouseLazyEffectState other) {
    if (identical(this, other)) return true;

    return other.visible == visible &&
        other.innerEffectOffset == innerEffectOffset &&
        other.outerCircleOffset == outerCircleOffset;
  }

  @override
  int get hashCode =>
      visible.hashCode ^
      innerEffectOffset.hashCode ^
      outerCircleOffset.hashCode;
}
