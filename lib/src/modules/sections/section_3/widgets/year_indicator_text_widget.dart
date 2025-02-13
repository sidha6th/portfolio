import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/animated/fade_slide_in.dart';

class YearIndicatorTextWidget extends StatelessWidget {
  const YearIndicatorTextWidget({
    required this.enteredIntoCareerTimeLine,
    required this.year,
    super.key,
  });

  final bool enteredIntoCareerTimeLine;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FadeSlideIn(
            offset: Offset(0, enteredIntoCareerTimeLine ? 0 : 1),
            opacity: enteredIntoCareerTimeLine ? 1 : 0,
            child: AnimatedFlipCounter(
              value: year,
              textStyle: const TextStyle(
                fontSize: 10,
                color: AppColors.white,
                fontFamily: FontFamily.cindieMonoD,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
