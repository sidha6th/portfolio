import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/widgets/animated/fade_slide_in.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_state.dart';

class ScrollProgressIndicatorWidget extends StatelessWidget {
  const ScrollProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: BlocBuilder<ScrollObserverBloc, ScrollObserverState>(
        buildWhen: (prev, curr) {
          return prev.index != curr.index ||
              prev.normalizedCurrentSectionScrolledOffset !=
                  curr.normalizedCurrentSectionScrolledOffset;
        },
        builder: (context, state) {
          final shouldRemove =
              (state.index > 3) ||
              (state.index >= 3 &&
                  state.normalizedCurrentSectionScrolledOffset > 0.8);
          return FadeSlideIn(
            offset: Offset(0, shouldRemove ? -1 : 0),
            opacity: shouldRemove ? 0 : 1,
            duration: KDurations.ms300,
            child: Row(
              spacing: 5,
              children: [
                AnimatedFlipCounter(
                  value: state.index + 1,
                  textStyle: const TextStyle(
                    color: AppColors.offWhite,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    value: state.normalizedCurrentSectionScrolledOffset,
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
  }
}
