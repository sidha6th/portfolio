import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';
import 'package:syncx/syncx.dart';

class LoadingInfoTextWidget extends StatelessWidget {
  const LoadingInfoTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierBuilder<LoadingNotifier, LoadingState>(
      builder: (context, state) {
        if (!state.isLoading) return const SizedBox.shrink();
        return Positioned(
          bottom: 20,
          right: 20,
          child: IgnorePointer(
            child: Opacity(
              opacity: state.progress ?? 0,
              child: TextWidget(
                KString.loadingInfoTexts[state.loadingStepCount ?? 0],
                style: const TextStyle(
                  fontSize: 5,
                  fontFamily: FontFamily.cindieMonoD,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
