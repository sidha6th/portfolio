import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/state_management/notifier_builder.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/animated_hovering_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/main_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/name_and_designation.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/portfolio_year_indicator.dart';

class FirstSection extends StatefulWidget implements StickableDelegate {
  const FirstSection(this.index, {super.key});

  final int index;

  @override
  Widget get child => this;

  @override
  bool get stick => false;

  @override
  bool get transformHitTests => false;

  @override
  double height(Size windowSize) {
    return windowSize.height.clamp(400, double.infinity);
  }

  @override
  bool notifyOnlyWhen(_, StickyMetricsState curr) => curr.currentIndex < 1;

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  final _maxScale = 1.1;
  final _imageSlideInFrom = 30.0;
  late var _minScale = _maxScale;
  final curve = Curves.fastOutSlowIn;
  late var _imageWidth = _calcImageWidth;
  final _scaleDuration = KDurations.ms300;
  late var _size = context.screenSize;

  @override
  Widget build(BuildContext context) {
    _whenWindowResized(context.screenSize);
    return NotifierBuilder<LoadingNotifier, LoadingState>(
      buildWhen: (previous, current) => !current.isLoading,
      builder: (context, loadingState) {
        return TweenAnimationBuilder(
          duration: loadingState.isLoading ? Duration.zero : _scaleDuration,
          curve: Curves.fastOutSlowIn,
          tween: Tween<double>(begin: _maxScale, end: _minScale),
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
                NotifierBuilder<StickyMetricsNotifier, StickyMetricsState>(
                  buildWhen: widget.notifyOnlyWhen,
                  builder: (context, state) => NameAndDesignation(
                    metrics: state.metricsAt(widget.index),
                  ),
                ),
                TransparentBackgroundImageWidget(
                  scale: value,
                  imageWidth: _imageWidth,
                  imageSlideInFrom: _imageSlideInFrom,
                  opacityAnimationDuration: KDurations.ms400,
                ),
                PortfolioYearIndicator(loading: loadingState.isLoading),
              ],
            );
          },
        );
      },
    );
  }

  double get _calcImageWidth {
    return (_size.width / 2).clamp(
      50.0,
      (_size.height * 0.6).clamp(0.0, 500.0),
    );
  }

  void _whenWindowResized(Size windowsSize) {
    if (_size == windowsSize) return;
    _size = windowsSize;
    _imageWidth = _calcImageWidth;
  }

  void _whenSlideAnimationDone() {
    setState(() => _minScale = 1);
  }
}
