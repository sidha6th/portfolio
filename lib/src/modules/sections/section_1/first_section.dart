import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/data/personal.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/animated_hovering_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/main_image.dart';
import 'package:sidharth/src/modules/sections/section_1/widgets/name_and_designation.dart';

class FirstSection extends StatelessWidget {
  const FirstSection(this.metrics, {super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final imageWidth = (context.screenWidth / 2).clamp(50.0, 400.0);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 20,
          top: 20,
          child: TextWidget(
            Personal.portfolio,
            style: const TextStyle(
              fontFamily: FontFamily.cindieMonoD,
              color: AppColors.white,
              fontSize: 7,
            ),
          ),
        ),
        MainImageWidget(imageWidth: imageWidth),
        NameAndDesignation(metrics: metrics),
        AnimatedHoveringImageWidget(
          path: Assets.images.png.image.path,
          imageWidth: imageWidth,
        ),
      ],
    );
  }
}
