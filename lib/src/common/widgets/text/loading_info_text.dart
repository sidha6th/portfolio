import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_state.dart';

class LoadingInfoTextWidget extends StatelessWidget {
  const LoadingInfoTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingHandlerBloc, LoadingHandlerState>(
      builder: (context, loadingState) {
        if (!loadingState.isLoading) return const SizedBox.shrink();
        return Positioned(
          bottom: 20,
          right: 20,
          child: IgnorePointer(
            child: Opacity(
              opacity: loadingState.progress ?? 0,
              child: TextWidget(
                KString.loadingInfoTexts[loadingState.loadingStepCount ?? 0],
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
