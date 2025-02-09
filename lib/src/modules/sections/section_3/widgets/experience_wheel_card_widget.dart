import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/personal.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/career_details_holding_widget.dart';
import 'package:sidharth/src/modules/sections/section_3/widgets/career_preview_card.dart';

class ExperienceWheelCard extends StatelessWidget {
  const ExperienceWheelCard({
    required this.metrics,
    required this.currentDate,
    required this.careerWheelIndex,
    required this.careerCardExtend,
    required this.changeWheelIndex,
    required this.listWheelController,
    super.key,
  });

  final DateTime currentDate;
  final int careerWheelIndex;
  final FreezeMetrics metrics;
  final double careerCardExtend;
  final ScrollController listWheelController;
  final void Function(int newIndex) changeWheelIndex;

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
              final isCurrent = career.isCurrent(currentDate);
              final timeToSwitch = isCurrent && careerWheelIndex != index;
              if (timeToSwitch) changeWheelIndex(index);

              return CareerPreviewCard(
                metrics: metrics,
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
