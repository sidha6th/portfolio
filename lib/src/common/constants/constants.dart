import 'package:flutter/foundation.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/extensions/date_time.dart';

class Misc {
  const Misc._();
  static const kFreezedListHorizontalTotalPadding = 40.0;
  static const kMonthIndicatorWidth = 30.0;

  static final maxViewPortWidth = 600.0;
  static final skillCardHeight = 400.0;

  static final monthsElapsedInCareer = KPersonal.careerStartDate
      .monthDifference();

  static final careerTimeLineStickHeight =
      (monthsElapsedInCareer * kMonthIndicatorWidth);

  static final isMobile =
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
