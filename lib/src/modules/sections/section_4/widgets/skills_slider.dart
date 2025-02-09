import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/shadow_gradient.dart';
import 'package:sidharth/src/modules/sections/section_4/widgets/skills_card.dart';

class VerticalSkillSlides extends StatefulWidget {
  const VerticalSkillSlides.vertical({
    required this.icons,
    required this.metrics,
    required this.cardWidth,
    this.reverse = false,
    this.slideStartDelay = 0,
    this.slideDirection = Axis.vertical,
    super.key,
  });

  const VerticalSkillSlides.horizontal({
    required this.icons,
    required this.metrics,
    required this.cardWidth,
    this.reverse = false,
    this.slideStartDelay = 0,
    this.slideDirection = Axis.horizontal,
    super.key,
  });

  final bool reverse;
  final double cardWidth;
  final Axis slideDirection;
  final FreezeMetrics metrics;
  final double slideStartDelay;
  final List<AssetGenImage> icons;

  @override
  State<VerticalSkillSlides> createState() => _VerticalSkillSlidesState();
}

class _VerticalSkillSlidesState extends State<VerticalSkillSlides> {
  late final _controller = ScrollController();
  late final _verticalSeparator = const SizedBox(height: 20);
  late final _horizontalSeparator = const SizedBox(width: 20);

  @override
  void didUpdateWidget(covariant VerticalSkillSlides oldWidget) {
    _controller.jumpTo(
      (widget.metrics.bottomDy - widget.slideStartDelay).clamp(
        0,
        _controller.position.maxScrollExtent,
      ),
    );
    
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleHeight = widget.metrics.availableViewPortHeight;
    final isVertical = widget.slideDirection == Axis.vertical;
    final maskHeight = widget.metrics.windowHeight * 0.4;
    final endMaskHeight = visibleHeight * 0.4;
    final cardHeight = widget.cardWidth + 30;

    return SizedBox(
      width: isVertical ? widget.cardWidth : widget.metrics.windowWidth,
      height: isVertical ? visibleHeight : cardHeight,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(1),
            child: ListView.separated(
              controller: _controller,
              reverse: widget.reverse,
              itemCount: widget.icons.length,
              scrollDirection: widget.slideDirection,
              physics: const NeverScrollableScrollPhysics(),
              padding: isVertical
                  ? EdgeInsets.symmetric(
                      vertical: (endMaskHeight / 2).clamp(20, double.infinity),
                    )
                  : EdgeInsets.zero,
              itemBuilder: (context, index) {
                return SlidingSkillCard(
                  height: cardHeight,
                  metrics: widget.metrics,
                  iconPadding:
                      isVertical ? EdgeInsets.zero : const EdgeInsets.all(20),
                  width: isVertical ? widget.cardWidth * 0.5 : widget.cardWidth,
                  asset: widget.icons[index],
                );
              },
              separatorBuilder: (context, index) =>
                  isVertical ? _verticalSeparator : _horizontalSeparator,
            ),
          ),
          if (isVertical) ...{
            Align(
              alignment:
                  isVertical ? Alignment.topCenter : Alignment.centerLeft,
              child: IgnorePointer(
                child: ShadowGradient.start(
                  height: endMaskHeight,
                  width: widget.cardWidth,
                ),
              ),
            ),
            Positioned(
              top: visibleHeight - endMaskHeight,
              child: IgnorePointer(
                child: ShadowGradient.end(
                  height: maskHeight,
                  width: widget.cardWidth,
                ),
              ),
            ),
          },
        ],
      ),
    );
  }
}
