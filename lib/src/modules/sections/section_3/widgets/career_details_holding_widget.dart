import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/string.dart';
import 'package:sidharth/src/common/extensions/date_time.dart';
import 'package:sidharth/src/common/model/experience_details.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class CareerDetailsHoldingWidget extends StatelessWidget {
  const CareerDetailsHoldingWidget({
    required this.career,
    super.key,
  });

  final ExperienceDetails career;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextWidget(
              career.begin.format(KString.mmm_yyyy),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontFamily: FontFamily.elgocThin,
              ),
            ),
          ],
        ),
        const Spacer(),
        TextWidget(
          'At ${career.org}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            fontFamily: FontFamily.elgocThin,
          ),
        ),
        TextWidget(
          'As ${career.designation}',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            fontFamily: FontFamily.elgocThin,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextWidget(
              career.end == null
                  ? 'Present'
                  : career.end!.format(KString.mmm_yyyy),
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontFamily: FontFamily.elgocThin,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
