import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/modules/sections/first_section/first_section.dart';

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
            childBuilder: (metrics) => FirstTile(metrics: metrics),
          ),
          FreezedWidgetDelegate(
            freezeViewPortHeight: size.height * 3,
            childBuilder: (metrics) {
              return ColoredSizedBox(
                color: Colors.orange,
                height: size.height,
                width: size.width,
                child: TextWidget(
                  'data' * 2,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
              );
            },
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
                  style: const TextStyle(color: Colors.white, fontSize: 40),
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
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}




    // final children = [
    //   SizedBox(
    //     height: size.height * 2,
    //     child: Consumer(
    //       builder: (context, ref, child) {
    //         final metrics = ref.watch(dashBoardScrollMetricsProvider);
    //         final offset = metrics?.pixels ?? 0;
    //         return Transform.translate(
    //           offset: Offset(
    //             0,
    //             (offset).clamp(0, (size.height * 2) - size.height),
    //           ),
    //           child: ColoredSizedBox(
    //             color: Colors.green,
    //             height: size.height,
    //             width: size.width,
    //             child: TextWidget(
    //               'data' * 2,
    //               style: const TextStyle(color: Colors.white, fontSize: 40),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    //   SizedBox(
    //     height: size.height * 3,
    //     child: Consumer(
    //       builder: (context, ref, child) {
    //         final metrics = ref.watch(dashBoardScrollMetricsProvider);
    //         final offset = metrics?.pixels ?? 0;

    //         final dy = (offset - size.height * 2)
    //             .clamp(0.0, (size.height * 3) - size.height);

    //         return Transform.translate(
    //           offset: Offset(0, dy),
    //           child: ColoredSizedBox(
    //             height: size.height,
    //             width: size.width,
    //             color: Colors.orange,
    //             child: TextWidget(
    //               'data' * 2,
    //               style: const TextStyle(color: Colors.white, fontSize: 40),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    //   SizedBox(
    //     height: size.height * 2,
    //     child: Consumer(
    //       builder: (context, ref, child) {
    //         final metrics = ref.watch(dashBoardScrollMetricsProvider);
    //         final offset = metrics?.pixels ?? 0;
    //         final dy = (offset - size.height * 4)
    //             .clamp(0.0, (size.height * 2) - size.height);

    //         return Transform.translate(
    //           offset: Offset(0, dy),
    //           child: ColoredSizedBox(
    //             height: size.height,
    //             width: size.width,
    //             color: Colors.grey,
    //             child: TextWidget(
    //               'data' * 2,
    //               style: const TextStyle(color: Colors.white, fontSize: 40),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    //   ColoredSizedBox(
    //     height: size.height,
    //     width: size.width,
    //     color: Colors.yellow,
    //   ),
    // ];