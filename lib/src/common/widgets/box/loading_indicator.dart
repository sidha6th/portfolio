import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_handler_view_model.dart';
import 'package:stacked/stacked.dart';

class FullScreenLoadingIndicator extends StatelessWidget {
  const FullScreenLoadingIndicator({
    required this.size,
    required this.loadingController,
    super.key,
  });

  final Size size;
  final LoadingHandlerViewModel loadingController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => loadingController,
      builder: (context, loadingHandler, child) {
        if (!loadingHandler.isLoading) return const SizedBox.shrink();

        return MouseRegion(
          cursor: SystemMouseCursors.wait,
          child: ColoredSizedBox(
            color: AppColors.black,
            width: size.width,
            height: size.height,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.offWhite,
                value: loadingHandler.progress,
              ),
            ),
          ),
        );
      },
    );
  }
}
