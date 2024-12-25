import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class BlueGradientTextBoxWidget extends StatelessWidget {
  const BlueGradientTextBoxWidget(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.blue, AppColors.lightBlue],
        ),
        boxShadow: [
          const BoxShadow(
            color: AppColors.black26,
            blurRadius: 8.0,
            spreadRadius: 3.0,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (width * 0.015).clamp(3, 10),
          vertical: (width * 0.02).clamp(5, 15),
        ),
        child: TextWidget(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: FontFamily.elgocThin,
            fontSize: (width * 0.02).clamp(0, 15),
            fontWeight: FontWeight.bold,
            shadows: [
              const BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 2,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
