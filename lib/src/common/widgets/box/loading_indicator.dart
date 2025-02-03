import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    required this.size,
    required this.value,
    this.animate = false,
    this.isLoading = true,
    super.key,
  });

  final Size size;
  final bool animate;
  final bool isLoading;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      secondChild: const SizedBox.shrink(),
      duration: animate ? KDurations.ms200 : Duration.zero,
      firstChild: ColoredSizedBox(
        color: AppColors.black,
        width: size.width,
        height: size.height,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.offWhite,
            value: value,
          ),
        ),
      ),
    );
  }
}
