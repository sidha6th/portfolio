import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class SectionTitleTextWidget extends StatelessWidget {
  const SectionTitleTextWidget({
    required this.size,
    super.key,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final minWindowSide = min(size.height, size.width);
    return TextWidget(
      KString.skills,
      style: TextStyle(
        fontSize: minWindowSide * 0.03,
        fontFamily: FontFamily.cindieMonoD,
        color: AppColors.offWhite,
      ),
    );
  }
}
