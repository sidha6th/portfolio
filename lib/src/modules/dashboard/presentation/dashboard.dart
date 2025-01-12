import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/modules/sections/section_1/section_1.dart';
import 'package:sidharth/src/modules/sections/section_2/section_2.dart';
import 'package:sidharth/src/modules/sections/section_3/section_3.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: NotifiableLisViewBuilder(
        delegates: [
          FreezedWidgetDelegate(
            shouldFreeze: false,
            viewPortHeight: (size) => size.height.clamp(400, double.infinity),
            childBuilder: FirstSection.new,
          ),
          FreezedWidgetDelegate(
            shouldFreeze: false,
            viewPortHeight: (screenSize) {
              return (screenSize.width * 0.68).clamp(500, double.infinity);
            },
            childBuilder: SecondSection.new,
          ),
          FreezedWidgetDelegate(
            viewPortHeight: (screenSize) {
              return (KDimensions.timeLineWidth +
                  (screenSize.height * 0.5) +
                  (screenSize.width.clamp(0, KDimensions.maxViewPortWidth) *
                      0.5));
            },
            childBuilder: ThirdSection.new,
          ),
          FreezedWidgetDelegate(
            viewPortHeight: (screenSize) => screenSize.width * 2,
            childBuilder: (metrics) {
              return ColoredSizedBox(
                height: metrics.viewPortHeight,
                width: metrics.viewPortWidth,
              );
            },
          ),
        ],
      ),
    );
  }
}
