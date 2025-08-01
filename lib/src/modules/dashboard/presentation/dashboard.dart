import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/freezable_list_view/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/lazy_mouse_effect/lazy_mouse_follow_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/widgets/scroll_progress_indicator_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/widgets/slidable_title_widget.dart';
import 'package:sidharth/src/modules/dashboard/presentation/widgets/version_indicator.dart';
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
      body: MouseFollowEffect(
        NotifiableLisViewBuilder(
          delegates: [
            FirstSection.new,
            SecondSection.new,
            ThirdSection.new,
            FourthSection.new,
            FifthSection.new,
          ],
          foregroundWidgetBuilder: () {
            return [
              const VersionIndicator(),
              const SlidableTitleWidget(),
              const ScrollProgressIndicatorWidget(),
            ];
          },
        ),
      ),
    );
  }
}
