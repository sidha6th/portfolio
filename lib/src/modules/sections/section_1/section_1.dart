import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/animated_hovering_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/main_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/name_and_designation.dart';

class FirstSection extends StatefulWidget {
  const FirstSection(this._metrics, {super.key});

  final FreezeMetrics _metrics;

  @override
  State<FirstSection> createState() => _FirstSectionState();

  static double viewPortSize(Size screenSize) {
    return screenSize.height.clamp(400, double.infinity);
  }
}

class _FirstSectionState extends State<FirstSection> {
  final _maxScale = 1.1;
  final _imageSlideInFrom = 30.0;
  late var _minScale = _maxScale;
  late var _imageWidth = _calcImageWidth;
  late final _portFolioTextWidget = _title;
  final _scaleDuration = KDurations.ms300;
  late var _size = widget._metrics.windowSize;
  final curve = Curves.fastOutSlowIn;

  @override
  void didUpdateWidget(covariant FirstSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._metrics.whenWindowResized(_size, _whenWindowResized);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: _maxScale,
        end: _minScale,
      ),
      curve: Curves.fastOutSlowIn,
      duration: _scaleDuration,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            MainImageWidget(
              scale: value,
              imageWidth: _imageWidth,
              imageSlideInFrom: _imageSlideInFrom,
              whenSlideAnimationEnd: _whenSlideAnimationDone,
            ),
            NameAndDesignation(metrics: widget._metrics),
            TransparentBackgroundImageWidget(
              scale: value,
              imageWidth: _imageWidth,
              imageSlideInFrom: _imageSlideInFrom,
              opacityAnimationDuration: KDurations.ms400,
            ),
            _portFolioTextWidget,
          ],
        );
      },
    );
  }

  double get _calcImageWidth {
    return (widget._metrics.windowWidth / 2)
        .clamp(50.0, (widget._metrics.windowHeight * 0.6).clamp(0.0, 500.0));
  }

  Widget get _title => Positioned(
        top: 20,
        left: 20,
        child: TextWidget(
          KString.portfolio,
          style: const TextStyle(
            fontFamily: FontFamily.cindieMonoD,
            color: AppColors.white,
            fontSize: 7,
          ),
        ),
      );

  void _whenWindowResized(Size windowsSize) {
    _imageWidth = _calcImageWidth;
    _size = windowsSize;
  }

  void _whenSlideAnimationDone(_) {
    setState(() => _minScale = 1);
  }
}
