import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class MonthIndicatorWidget extends StatelessWidget {
  const MonthIndicatorWidget(
    this.month, {
    required this.height,
    this.indicate = false,
    this.indicatorStickWidth = 0.5,
    this.color = AppColors.white,
    super.key,
  });

  final int month;
  final Color color;
  final bool indicate;
  final double height;
  final double indicatorStickWidth;

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
              width: indicatorStickWidth,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: color,
                  child: TextWidget(
                    month,
                    style: const TextStyle(
                      fontSize: 5,
                      color: AppColors.black,
                      fontFamily: FontFamily.cindieMonoD,
                    ),
                  ),
                ),
                if (indicate)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue,
                      ),
                      child: SizedBox.square(dimension: 4),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
