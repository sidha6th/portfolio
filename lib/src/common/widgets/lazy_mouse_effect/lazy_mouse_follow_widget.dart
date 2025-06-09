import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sidharth/src/common/constants/colors.dart';
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
  final innerDotDiameter = 9.0;
  Offset mousePosition = Offset.zero;
  late final halfDiameter = diameter / 2;
  late final Ticker _ticker = Ticker(_tick);
  late final halfInnerDotDiameter = innerDotDiameter / 2;
  late final _mouseEventNotifer = ValueNotifier(const MouseLazyEffectState());

  Future<void> _tick(_) async {
    const double lerpSpeed = 0.08;
    const double innerDotlerpSpeed = 0.4;
    final outerCirlceOffset =
        _mouseEventNotifer.value.outerCircleOffset ?? Offset.zero;
    final outerDx =
        lerpDouble(outerCirlceOffset.dx, mousePosition.dx, lerpSpeed)!;
    final outerDy =
        lerpDouble(outerCirlceOffset.dy, mousePosition.dy, lerpSpeed)!;
    final innerDx =
        lerpDouble(outerCirlceOffset.dx, mousePosition.dx, innerDotlerpSpeed)!;
    final innerDy =
        lerpDouble(outerCirlceOffset.dy, mousePosition.dy, innerDotlerpSpeed)!;
    _mouseEventNotifer.value = _mouseEventNotifer.value.onMove(
      outerOffset: Offset(outerDx, outerDy),
      innerOffset: Offset(innerDx, innerDy),
    );
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    _mouseEventNotifer.dispose();
    super.dispose();
  }

  Future<void> _startTicker(Offset offset) async {
    mousePosition = offset;
    if (!_mouseEventNotifer.value.visible) {
      _mouseEventNotifer.value = _mouseEventNotifer.value.toggleVisiblity(true);
    }
    if (!_ticker.isActive) unawaited(_ticker.start());
  }

  void _hideCurser() {
    _mouseEventNotifer.value = _mouseEventNotifer.value.toggleVisiblity(false);
  }

  @override
  Widget build(BuildContext context) {
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
            valueListenable: _mouseEventNotifer,
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
                  colors: [
                    AppColors.white,
                    AppColors.black,
                    AppColors.white,
                  ],
                ),
              ),
            ),
            builder: (context, state, outerCircle) {
              return Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  TweenAnimationBuilder(
                    curve:
                        state.visible ? Curves.easeOutBack : Curves.elasticIn,
                    duration: state.outerCircleOffset == null
                        ? Duration.zero
                        : Duration(milliseconds: state.visible ? 200 : 600),
                    tween: Tween<double>(
                      begin: state.visible ? 0 : 1,
                      end: state.visible ? 1 : 0,
                    ),
                    builder: (context, value, child) {
                      final top =
                          (state.outerCircleOffset?.dy ?? 0) - halfDiameter;
                      final left =
                          (state.outerCircleOffset?.dx ?? 0) - halfDiameter;
                      return Positioned(
                        top: top,
                        left: left,
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
                      top: state.innerEffectOffset.dy - halfInnerDotDiameter,
                      left: state.innerEffectOffset.dx - halfInnerDotDiameter,
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
