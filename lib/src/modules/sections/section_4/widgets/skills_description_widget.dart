import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class SkillsDescriptionTextWidget extends StatelessWidget {
  const SkillsDescriptionTextWidget({
    required this.fontSize,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0),
    this.maxWidth = 300,
    super.key,
  });

  final double fontSize;
  final EdgeInsets padding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: TextWidget(
          KPersonal.skillsDescription,
          style: TextStyle(
            fontSize: fontSize,
            color: AppColors.offWhite,
            fontFamily: FontFamily.elgocThin,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
