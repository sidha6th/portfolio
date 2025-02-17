import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_handler_view_model.dart';
import 'package:stacked/stacked.dart';

class LoadingInfoTextWidget extends StatelessWidget {
  const LoadingInfoTextWidget({
    required this.model,
    super.key,
  });

  final LoadingHandlerViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => model,
      disposeViewModel: false,
      builder: (context, model, child) {
        if (!model.isLoading) return const SizedBox.shrink();
        return Positioned(
          bottom: 20,
          right: 20,
          child: IgnorePointer(
            child: Opacity(
              opacity: model.progress,
              child: TextWidget(
                KString.loadingInfoTexts[model.loadingStepCount],
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
