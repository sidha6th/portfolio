import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';

class MonthArrowIndicator extends StatelessWidget {
  const MonthArrowIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.arrow_drop_down,
          color: AppColors.white,
        ),
      ],
    );
  }
}
