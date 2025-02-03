import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_observing_view_model.dart';

class SlidableTitleWidget extends StatelessWidget {
  const SlidableTitleWidget({
    required this.windowSize,
    required this.model,
    super.key,
  });

  final Size windowSize;
  final ScrollObservingViewModel model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: IgnorePointer(
        child: SizedBox(
          height: windowSize.height * 0.1,
          width: windowSize.width * 0.4,
          child: ListView.builder(
            itemExtent: windowSize.height * 0.1,
            primary: false,
            itemBuilder: (context, index) {
              return TextWidget(
                index,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.elgocThin,
                  color: AppColors.offWhite,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
