import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/animated_hovering_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/main_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/name_and_designation.dart';

class FirstSection extends StatelessWidget {
  const FirstSection(this._metrics, {super.key});

  final FreezeMetrics _metrics;

  @override
  Widget build(BuildContext context) {
    final imageWidth = (_metrics.windowWidth / 2)
        .clamp(50.0, (_metrics.windowHeight * 0.6).clamp(0.0, 500.0));

    return Stack(
      alignment: Alignment.center,
      children: [
        MainImageWidget(imageWidth: imageWidth),
        NameAndDesignation(metrics: _metrics),
        AnimatedHoveringImageWidget(
          path: Assets.images.png.image.path,
          imageWidth: imageWidth,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: TextWidget(
            KString.portfolio,
            style: const TextStyle(
              fontFamily: FontFamily.cindieMonoD,
              color: AppColors.white,
              fontSize: 7,
            ),
          ),
        ),
      ],
    );
  }

  static double viewPortSize(Size screenSize) {
    return screenSize.height.clamp(400, double.infinity);
  }
}
