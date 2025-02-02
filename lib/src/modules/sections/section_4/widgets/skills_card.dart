import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/constants/durations.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';
import 'package:sidharth/src/common/widgets/box/colored_sided_box.dart';

class SlidingSkillCard extends StatefulWidget {
  const SlidingSkillCard({
    required this.metrics,
    required this.asset,
    required this.width,
    required this.height,
    this.iconPadding = EdgeInsets.zero,
    super.key,
  });

  final FreezeMetrics metrics;
  final AssetGenImage asset;
  final double width;
  final double height;
  final EdgeInsets iconPadding;

  @override
  State<SlidingSkillCard> createState() => _SlidingSkillCardState();
}

class _SlidingSkillCardState extends State<SlidingSkillCard> {
  bool hovering = false;
  bool animationDone = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TweenAnimationBuilder(
          onEnd: _onEndAnimation,
          tween: Tween<double>(
            begin: hovering ? 255 : 0,
            end: hovering ? 0 : 255,
          ),
          duration: animationDone ? Duration.zero : KDurations.ms200,
          child: ColoredSizedBox(
            height: widget.height,
            width: widget.width,
            child: Padding(
              padding: widget.iconPadding,
              child: Center(
                child: widget.asset.image(
                  width: widget.width,
                  filterQuality: FilterQuality.none,
                ),
              ),
            ),
          ),
          builder: (context, value, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey.withAlpha(value.toInt()),
                BlendMode.color,
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }

  void _onHover(_) {
    if (hovering) return;
    animationDone = false;
    setState(() {
      hovering = true;
    });
  }

  void _onExit(_) {
    if (!hovering) return;
    animationDone = false;
    setState(() {
      hovering = false;
    });
  }

  void _onEndAnimation() {
    animationDone = true;
  }
}
