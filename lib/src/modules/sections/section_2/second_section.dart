import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/data/personal.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_2/widgets/blue_gradient_text_box_widget.dart';

class SecondSection extends StatelessWidget {
  const SecondSection(this.metrics, {super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Column(
      children: [
        SizedBox(
          width: size.width.clamp(0, 400),
          child: TextWidget(
            Personal.introduction,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.elgocThin,
            ),
          ),
        ),
        TextWidget(
          Personal.whatDoIDo,
          style: const TextStyle(
            fontFamily: FontFamily.cindieMonoD,
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
        ...List.generate(
          Personal.nonTechiesQuestions.length,
          (index) =>
              BlueGradientTextBoxWidget(Personal.nonTechiesQuestions[index]),
        ),
        TextWidget(
          Personal.quote,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          style: const TextStyle(
            fontFamily: FontFamily.cindieMonoD,
            color: AppColors.white,
            fontSize: 10,
            height: 2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
