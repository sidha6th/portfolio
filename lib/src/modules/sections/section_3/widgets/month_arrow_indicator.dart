import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/animated/fade_slide_in.dart';

class MonthArrowIndicator extends StatelessWidget {
  const MonthArrowIndicator({
    required this.enteredIntoCareerTimeLine,
    super.key,
  });

  final bool enteredIntoCareerTimeLine;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      offset: Offset(0, enteredIntoCareerTimeLine ? 0 : -1),
      opacity: enteredIntoCareerTimeLine ? 1 : 0,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
