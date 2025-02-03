import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
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
    return Positioned(
      top: 20,
      right: 30,
      child: MouseRegion(
        onHover: _onHover,
        onExit: _onExitHover,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadiusDirectional.circular(90),
          ),
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: isHovering ? 30 : 200,
              end: isHovering ? 200 : 30,
            ),
            duration: KDurations.ms200,
            curve: Curves.fastOutSlowIn,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
                child: SizedBox(
                  width: value,
                  child: Row(
                    mainAxisAlignment: isHovering
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      Assets.images.png.wip.image(width: 20),
                      if (isHovering)
                        Flexible(
                          child: TextWidget(
                            KString.underDevelopment,
                            style: const TextStyle(
                              color: AppColors.black45,
                              fontSize: 6,
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
    setState(() {
      isHovering = false;
    });
  }
}
