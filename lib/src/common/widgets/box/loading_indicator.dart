import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/state_management/notifier_builder.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';

class FullScreenLoadingIndicator extends StatelessWidget {
  const FullScreenLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierBuilder<LoadingNotifier, LoadingState>(
      builder: (context, state) {
        if (!state.isLoading) return const SizedBox.shrink();

        return ColoredSizedBox(
          color: AppColors.black,
          width: context.screenSize.width,
          height: context.screenSize.height,
          child: Center(
            child: CircularProgressIndicator(
              value: state.progress,
              color: AppColors.offWhite,
            ),
          ),
        );
      },
    );
  }
}
