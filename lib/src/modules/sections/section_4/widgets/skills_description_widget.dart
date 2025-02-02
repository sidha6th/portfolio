import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class SkillsDescriptionTextWidget extends StatelessWidget {
  const SkillsDescriptionTextWidget({
    required this.fontSize,
    super.key,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: TextWidget(
          KPersonal.skillsDescription,
          style: TextStyle(
            color: AppColors.offWhite,
            fontSize: fontSize,
            fontFamily: FontFamily.elgocThin,
          ),
        ),
      ),
    );
  }
}
