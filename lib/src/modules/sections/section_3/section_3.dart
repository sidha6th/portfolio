import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/time_line_calendar.dart';

class ThirdSection extends StatelessWidget {
  const ThirdSection(this._metrics, {super.key});

  final FreezeMetrics _metrics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: _metrics.windowHeight < 500 ? 40 : 0,
      ),
      child: TimeLineCalendar(_metrics),
    );
  }

  static double freezedHeight(Size screenSize) {
    return (KDimensions.timeLineWidth +
        (screenSize.height * 0.5) +
        (screenSize.width.clamp(0, KDimensions.maxViewPortWidth) * 0.5));
  }
}
