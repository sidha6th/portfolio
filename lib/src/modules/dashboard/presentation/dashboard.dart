import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/section_1/first_section.dart';
import 'package:sidharth/src/modules/sections/section_2/second_section.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: NotifiableLisViewBuilder(
        delegates: [
          FreezedWidgetDelegate(
            freezeViewPortHeight: size.height,
            shouldFreeze: false,
            childBuilder: FirstSection.new,
          ),
          FreezedWidgetDelegate(
            freezeViewPortHeight: size.height,
            shouldFreeze: false,
            childBuilder: SecondSection.new,
          ),
          FreezedWidgetDelegate(
            freezeViewPortHeight: size.height * 2,
            childBuilder: (offset) {
              return ColoredSizedBox(
                color: Colors.yellow,
                height: size.height,
                width: size.width,
                child: TextWidget(
                  'data' * 2,
                  style: const TextStyle(color: AppColors.white, fontSize: 40),
                ),
              );
            },
          ),
          FreezedWidgetDelegate(
            freezeViewPortHeight: size.height * 2,
            childBuilder: (offset) {
              return ColoredSizedBox(
                color: Colors.red,
                height: size.height,
                width: size.width,
                child: TextWidget(
                  'data' * 2,
                  style: const TextStyle(color: AppColors.white, fontSize: 40),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
