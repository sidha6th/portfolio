import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/extensions/bool.dart';
import 'package:sidharth/src/common/helper/methods.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    required this.size,
    required this.value,
    this.animate = false,
    this.isLoading = true,
    this.startScale = false,
    super.key,
  });

  final Size size;
  final bool animate;
  final bool isLoading;
  final double? value;
  final bool startScale;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    if (disabled) return const SizedBox.shrink();

    return ColoredSizedBox(
      color: AppColors.black,
      width: widget.size.width,
      height: widget.size.height,
      child: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 40, end: !widget.startScale ? 40 : 0),
          duration: KDimensions.loadingScaleTransitionDuration,
          curve: Curves.easeInToLinear,
          onEnd: whenLoadingCompleted,
          builder: (context, diameter, child) {
            final opacity = widget.startScale.then(
              () => normalize(value: diameter, end: 40),
              orElse: () => 1.0,
            )!;

            return Opacity(
              opacity: opacity,
              child: SizedBox(
                width: diameter,
                height: diameter,
                child: CircularProgressIndicator(
                  color: AppColors.offWhite,
                  value: widget.value,
                  strokeWidth: 4 * opacity,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void whenLoadingCompleted() {
    setState(() {
      disabled = true;
    });
  }
}
