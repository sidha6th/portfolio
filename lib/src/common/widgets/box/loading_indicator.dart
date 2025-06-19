import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_state.dart';

class FullScreenLoadingIndicator extends StatelessWidget {
  const FullScreenLoadingIndicator({required this.size, super.key});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingHandlerBloc, LoadingHandlerState>(
      builder: (context, loadingState) {
        if (!loadingState.isLoading) return const SizedBox.shrink();

        return ColoredSizedBox(
          color: AppColors.black,
          width: size.width,
          height: size.height,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.offWhite,
              value: loadingState.progress,
            ),
          ),
        );
      },
    );
  }
}
