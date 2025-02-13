import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/freezable_list_view/notifiable_list_view_builder.dart';
import 'package:sidharth/src/modules/dashboard/presentation/widgets/scroll_progress_indicator_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/widgets/slidable_title_widget.dart';
import 'package:sidharth/src/modules/sections/section_1/section_1.dart';
import 'package:sidharth/src/modules/sections/section_2/section_2.dart';
import 'package:sidharth/src/modules/sections/section_3/section_3.dart';
import 'package:sidharth/src/modules/sections/section_4/section_4.dart';
import 'package:sidharth/src/modules/sections/section_5/section_5.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: NotifiableLisViewBuilder(
        isUnderDevelopment: true,
        delegates: [
          const FreezedWidgetDelegate(
            shouldFreeze: false,
            freezedScrollHeight: FirstSection.viewPortSize,
            childBuilder: FirstSection.new,
          ),
          const FreezedWidgetDelegate(
            shouldFreeze: false,
            freezedScrollHeight: SecondSection.freezedHeight,
            childBuilder: SecondSection.new,
          ),
          const FreezedWidgetDelegate(
            freezedScrollHeight: ThirdSection.freezedHeight,
            childBuilder: ThirdSection.new,
          ),
          const FreezedWidgetDelegate(
            transformHitTests: true,
            freezedScrollHeight: FourthSection.freezedHeight,
            childBuilder: FourthSection.new,
          ),
          const FreezedWidgetDelegate(
            transformHitTests: true,
            freezedScrollHeight: FifthSection.freezedHeight,
            childBuilder: FifthSection.new,
          ),
        ],
        foregroundWidgetBuilder: (windowSize, model) {
          return [
            SlidableTitleWidget(model: model, windowSize: windowSize),
            ScrollProgressIndicatorWidget(model: model),
          ];
        },
      ),
    );
  }
}
