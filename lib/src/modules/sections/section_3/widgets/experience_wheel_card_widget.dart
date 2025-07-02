import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/career_details_holding_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/career_preview_card.dart';

class ExperienceWheelCard extends StatelessWidget {
  const ExperienceWheelCard({
    required this.careerCardExtend,
    required this.listWheelController,
    super.key,
  });

  final double careerCardExtend;
  final ScrollController listWheelController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListWheelScrollView.useDelegate(
          perspective: 0.01,
          itemExtent: careerCardExtend,
          overAndUnderCenterOpacity: 0.3,
          controller: listWheelController,
          physics: const NeverScrollableScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: KPersonal.careerJourney.length,
            builder: (context, index) {
              final career = KPersonal.careerJourney[index];
              return CareerPreviewCard(
                height: careerCardExtend,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CareerDetailsHoldingWidget(career: career),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
