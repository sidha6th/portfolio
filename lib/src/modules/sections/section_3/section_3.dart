import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/time_line_calendar.dart';

class ThirdSection extends StatelessWidget {
  const ThirdSection(this.metrics, {super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          KString.career,
          style: TextStyle(
            fontFamily: FontFamily.cindieMonoD,
            color: AppColors.white,
            fontSize: (metrics.viewPortWidth * 0.01).clamp(13, 40),
            height: 2,
            shadows: [
              const Shadow(
                color: Colors.blueGrey,
                blurRadius: 0.3,
                offset: Offset(-2, 2),
              ),
            ],
          ),
        ),
        TimeLineCalendar(
          offset: metrics.origin,
          metrics: metrics,
        ),
      ],
    );
  }
}
