import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/modules/sections/section_1/first_section.dart';
import 'package:sidharth/src/modules/sections/section_2/second_section.dart';

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
            viewPortHeight: (size) => size.height,
            childBuilder: FirstSection.new,
          ),
          FreezedWidgetDelegate(
            shouldFreeze: false,
            viewPortHeight: (screenSize) => screenSize.height,
            childBuilder: SecondSection.new,
          ),
          FreezedWidgetDelegate(
            viewPortHeight: (screenSize) => 2000,
            childBuilder: ThirdSection.new,
          ),
        ],
      ),
    );
  }
}

class ThirdSection extends StatelessWidget {
  const ThirdSection(this.metrics, {super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
