import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/widgets/animated/animated_fade_slide_in.dart';
import 'package:sidharth/src/common/widgets/animated/fractional_fade_slide_in.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';
import 'package:syncx/syncx.dart' as syncx;

class ScrollProgressIndicatorWidget extends StatelessWidget {
  const ScrollProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: syncx.NotifierBuilder<LoadingNotifier, LoadingState>(
        builder: (context, state) {
          return AnimatedFadeSlideIn(
            slidCurve: Curves.fastOutSlowIn,
            duration: KDurations.ms600,
            offset: !state.isLoading ? Offset.zero : const Offset(0, 2),
            opacity: !state.isLoading ? 1 : 0,
            child:
                syncx.NotifierBuilder<
                  StickyMetricsNotifier,
                  StickyMetricsState
                >(
                  builder: (context, state) {
                    final shouldRemove =
                        (state.currentIndex > 3) ||
                        (state.currentIndex >= 3 &&
                            state.currentChildPosition > 0.8);
                    return FractionalFadeSlideIn(
                      offset: Offset(0, shouldRemove ? -1 : 0),
                      opacity: shouldRemove ? 0 : 1,
                      child: Row(
                        spacing: 5,
                        children: [
                          AnimatedFlipCounter(
                            value: state.currentIndex + 1,
                            textStyle: const TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: LinearProgressIndicator(
                              value: state.currentChildPosition,
                              backgroundColor: AppColors.grey,
                              minHeight: 0.5,
                              color: AppColors.offWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          TextWidget(
                            '4',
                            style: const TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
