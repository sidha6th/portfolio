import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/widgets/lazy_mouse_effect/mouse_event_notifier_state.dart';

class MouseFollowEffect extends StatefulWidget {
  const MouseFollowEffect(this.child, {super.key});

  final Widget child;

  @override
  State<MouseFollowEffect> createState() => _MouseFollowEffectState();
}

class _MouseFollowEffectState extends State<MouseFollowEffect>
    with SingleTickerProviderStateMixin {
  final diameter = 20.0;
  Offset? mousePosition;
  final innerDotDiameter = 9.0;
  late final innerDotSpeed = 0.4;
  late final outerCircleSpeed = 0.08;
  late final Ticker _ticker = Ticker(_tick);
  late final halfOuterCircleDiameter = diameter / 2;
  late final halfInnerDotDiameter = innerDotDiameter / 2;
  late final _mouseEventNotifier = ValueNotifier(const MouseLazyEffectState());

  void _tick(_) {
    if (mousePosition == null) return _ticker.stop();

    final outerCircleOffset = _mouseEventNotifier.value.outerCircleOffset;
    final outerDx = lerpDouble(
      outerCircleOffset.dx,
      mousePosition!.dx,
      outerCircleSpeed,
    )!;
    final outerDy = lerpDouble(
      outerCircleOffset.dy,
      mousePosition!.dy,
      outerCircleSpeed,
    )!;
    final innerDx = lerpDouble(
      outerCircleOffset.dx,
      mousePosition!.dx,
      innerDotSpeed,
    )!;
    final innerDy = lerpDouble(
      outerCircleOffset.dy,
      mousePosition!.dy,
      innerDotSpeed,
    )!;

    _mouseEventNotifier.value = _mouseEventNotifier.value.onMove(
      outerOffset: Offset(outerDx, outerDy),
      innerOffset: Offset(innerDx, innerDy),
    );
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    _mouseEventNotifier.dispose();
    super.dispose();
  }

  void _startTicker(Offset offset) {
    mousePosition = offset;
    if (!_ticker.isActive) unawaited(_ticker.start());
    if (!_mouseEventNotifier.value.visible) {
      _mouseEventNotifier.value = _mouseEventNotifier.value.toggleVisibility(
        true,
      );
    }
  }

  void _hideCurser() {
    _mouseEventNotifier.value = _mouseEventNotifier.value.toggleVisibility(
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Misc.isMobile) return widget.child;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onExit: (event) => _hideCurser(),
      onHover: (event) => _startTicker(event.position),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          widget.child,
          ValueListenableBuilder(
            valueListenable: _mouseEventNotifier,
            child: Container(
              width: diameter,
              height: diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    color: AppColors.black26,
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
                backgroundBlendMode: BlendMode.difference,
                border: Border.all(color: AppColors.white),
                gradient: const RadialGradient(
                  colors: [AppColors.white, AppColors.black, AppColors.white],
                ),
              ),
            ),
            builder: (context, state, outerCircle) {
              return Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  TweenAnimationBuilder(
                    curve: state.visible
                        ? Curves.easeOutBack
                        : Curves.elasticIn,
                    duration: mousePosition == null
                        ? Duration.zero
                        : Duration(milliseconds: state.visible ? 200 : 600),
                    tween: Tween<double>(
                      begin: state.visible ? 0 : 1,
                      end: state.visible ? 1 : 0,
                    ),
                    onEnd: () {
                      if (!state.visible) _ticker.stop();
                    },
                    builder: (context, value, child) {
                      return Positioned(
                        top:
                            state.outerCircleOffset.dy -
                            halfOuterCircleDiameter,
                        left:
                            state.outerCircleOffset.dx -
                            halfOuterCircleDiameter,
                        child: IgnorePointer(
                          child: Transform.scale(
                            scale: value,
                            child: outerCircle,
                          ),
                        ),
                      );
                    },
                  ),
                  if (state.visible)
                    Positioned(
                      top: state.innerDotOffset.dy - halfInnerDotDiameter,
                      left: state.innerDotOffset.dx - halfInnerDotDiameter,
                      child: IgnorePointer(
                        child: Container(
                          width: innerDotDiameter,
                          height: innerDotDiameter,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.blue,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.black,
                                AppColors.offWhite,
                                AppColors.black,
                              ],
                            ),
                            backgroundBlendMode: BlendMode.difference,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
