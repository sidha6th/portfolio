import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class UnderDevelopmentIndicator extends StatefulWidget {
  const UnderDevelopmentIndicator({required this.size, super.key});

  final Size size;

  @override
  State<UnderDevelopmentIndicator> createState() =>
      _UnderDevelopmentIndicatorState();
}

class _UnderDevelopmentIndicatorState extends State<UnderDevelopmentIndicator> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    const maxWidth = 140.0;
    const minWidth = 22.0;

    return Positioned(
      top: 20,
      right: 30,
      child: MouseRegion(
        onEnter: _onHover,
        onExit: _onExitHover,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadiusDirectional.circular(140),
          ),
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: isHovering ? minWidth : maxWidth,
              end: isHovering ? maxWidth : minWidth,
            ),
            duration: KDurations.ms200,
            curve: Curves.fastOutSlowIn,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.5),
                child: SizedBox(
                  width: value,
                  child: Row(
                    mainAxisAlignment: isHovering
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.yellow,
                        size: 14,
                        applyTextScaling: true,
                      ),
                      if (isHovering)
                        Flexible(
                          child: TextWidget(
                            KString.underDevelopment,
                            style: const TextStyle(
                              color: AppColors.black45,
                              fontSize: 4,
                              fontFamily: FontFamily.cindieMonoD,
                            ),
                            softWrap: false,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onHover(_) {
    if (isHovering) return;
    setState(() {
      isHovering = true;
    });
  }

  void _onExitHover(_) {
    if (!isHovering) return;
    setState(() {
      isHovering = false;
    });
  }
}
