import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/widgets/animated/fade_slide_in.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_observing_view_model.dart';
import 'package:stacked/stacked.dart';

class ScrollProgressIndicatorWidget extends StatelessWidget {
  const ScrollProgressIndicatorWidget({
    required this.model,
    super.key,
  });

  final ScrollObservingViewModel model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: ViewModelBuilder.reactive(
        viewModelBuilder: () => model,
        disposeViewModel: false,
        builder: (context, model, child) {
          final shouldRemove = (model.index > 3) ||
              (model.index >= 3 &&
                  model.normalizedCurrentSectionScrolledOffset > 0.8);
          return FadeSlideIn(
            offset: Offset(
              0,
              shouldRemove ? -1 : 0,
            ),
            opacity: shouldRemove ? 0 : 1,
            duration: KDurations.ms300,
            child: Row(
              spacing: 5,
              children: [
                AnimatedFlipCounter(
                  value: model.index + 1,
                  textStyle: const TextStyle(
                    color: AppColors.offWhite,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    value: model.normalizedCurrentSectionScrolledOffset,
                    backgroundColor: Colors.grey,
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
  }
}
