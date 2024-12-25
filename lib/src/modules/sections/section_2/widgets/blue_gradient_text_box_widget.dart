import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class BlueGradientTextBoxWidget extends StatelessWidget {
  const BlueGradientTextBoxWidget(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
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
            blurRadius: 10.0,
            spreadRadius: 3.0,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: TextWidget(
          text,
          style: const TextStyle(
            color: AppColors.white,
            shadows: [
              BoxShadow(
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
