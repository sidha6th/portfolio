import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:sidharth/src/modules/sections/first_section/view_model/first_section_view_model.dart';
import 'package:sidharth/src/modules/sections/first_section/widgets/name_and_designation.dart';
import 'package:stacked/stacked.dart';

class FirstTile extends StatelessWidget {
  const FirstTile({required this.metrics, super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final imageWidth = (context.screenWidth / 2).clamp(50.0, 400.0);
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: FirstSectionViewModel.new,
      builder: (context, model, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: TextWidget(
                'Portfolio © 2024',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.cindieMonoD,
                  fontSize: 7,
                ),
              ),
            ),
            MouseRegion(
              onEnter: (_) => model.changeHoverState(true),
              onExit: (_) => model.changeHoverState(false),
              child: FadeInDown(
                from: 50,
                child: Image.asset(
                  Assets.images.jpeg.image.path,
                  width: imageWidth,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            NameAndDesignation(metrics: metrics),
            IgnorePointer(
              child: FadeInDown(
                from: 50,
                onFinish: (direction) => model.offHoverStateDelayed(),
                child: ViewModelBuilder.reactive(
                  viewModelBuilder: () => model,
                  disposeViewModel: false,
                  builder: (context, model, child) {
                    return model.isHovering ? child! : const SizedBox.shrink();
                  },
                  staticChild: FadeIn(
                    duration: const Duration(milliseconds: 200),
                    child: Image.asset(
                      Assets.images.png.image.path,
                      width: imageWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
