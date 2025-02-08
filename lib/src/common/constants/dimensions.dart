import 'package:flutter/foundation.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/extensions/date_time.dart';

class KDimensions {
  const KDimensions._();

  static const kFreezedListHorizontalTotalPadding = 40.0;
  static const kMonthTimelineIndicatorWidth = 31.0;

  static final totalMonthsPast = KPersonal.careerStartDate.monthDifference();

  static final maxViewPortWidth = 600.0;

  static final skillCardHeight = 400.0;

  static final timeLineWidth =
      (totalMonthsPast * KDimensions.kMonthTimelineIndicatorWidth);

  static final isMobile = defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
