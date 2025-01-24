import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class MonthIndicatorWidget extends StatelessWidget {
  const MonthIndicatorWidget(this.month, {required this.height, super.key});

  final int month;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: KDimensions.kMonthTimelineIndicatorWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ColoredSizedBox(
              height: height,
              width: 0.5,
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.white,
              child: TextWidget(
                month,
                style: const TextStyle(
                  fontSize: 5,
                  color: AppColors.black,
                  fontFamily: FontFamily.cindieMonoD,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
