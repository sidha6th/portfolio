import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/animated/fade_slide_in.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class NameAndDesignation extends StatefulWidget {
  const NameAndDesignation({required this.metrics, super.key});

  final FreezeMetrics metrics;

  @override
  State<NameAndDesignation> createState() => _NameAndDesignationState();
}

class _NameAndDesignationState extends State<NameAndDesignation> {
  double _normalizedOffset = 0;
  late var fontSize = _size.width * 0.05;
  late var _size = widget.metrics.windowSize;
  late var designationFontSize = _size.width * 0.03;
  late var _maxHeightNeedForAnimate = widget.metrics.totalHeight * 0.9;
  bool get _isNotVisible => widget.metrics.topDy >= _maxHeightNeedForAnimate;

  @override
  void didUpdateWidget(covariant NameAndDesignation oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.metrics.whenWindowResized(_size, _whenResize);
    if (_isNotVisible) return;
    _calcNormalizedOffset();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeSlideIn(
            opacity: _opacity(),
            offset: Offset(0, -_dy()),
            child: TextWidget(
              KPersonal.name,
              style: TextStyle(
                fontSize: fontSize,
                color: AppColors.white,
                fontFamily: FontFamily.cindieMonoD,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          FadeSlideIn(
            opacity: _opacity(0.1),
            offset: Offset(0, -_dy(0.1)),
            child: TextWidget(
              KPersonal.designation,
              style: TextStyle(
                fontSize: designationFontSize,
                color: AppColors.white,
                fontFamily: FontFamily.cindieMonoD,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          FadeSlideIn(
            offset: Offset(0, -_dy(0.3)),
            opacity: _opacity(0.25),
            opacityDuration: KDurations.ms100,
            child: TextWidget(
              KString.year,
              style: TextStyle(
                fontSize: fontSize,
                color: AppColors.white,
                fontFamily: FontFamily.cindieMonoD,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _dy([double delay = 0]) {
    if (_isNotVisible) return 2.5;
    return ((_normalizedOffset - delay) * 4).clamp(0, double.infinity);
  }

  double _opacity([double delay = 0]) {
    if (_isNotVisible) return 0;
    return (1 - (_normalizedOffset - delay) * 3).clamp(0, 1);
  }

  void _calcNormalizedOffset() {
    _normalizedOffset = normalize(
      value: widget.metrics.topDy,
      end: widget.metrics.totalHeight,
    );
  }

  void _whenResize(Size windowsSize) {
    _size = windowsSize;
    fontSize = _size.width * 0.05;
    designationFontSize = _size.width * 0.03;
    _maxHeightNeedForAnimate = widget.metrics.totalHeight * 0.9;
  }
}
