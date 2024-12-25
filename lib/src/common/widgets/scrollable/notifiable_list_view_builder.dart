// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sidharth/src/common/widgets/freezed_child.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_offset_state_provider.dart';
import 'package:stacked/stacked.dart';

class NotifiableLisViewBuilder extends StatelessWidget {
  const NotifiableLisViewBuilder({
    this.delegates = const [],
    super.key,
  });

  final List<FreezedWidgetDelegate> delegates;

  @override
  Widget build(
    BuildContext context,
  ) {
    final screenSize = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ViewModelBuilder.nonReactive(
          viewModelBuilder: ScrollObservingViewModel.new,
          builder: (context, model, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                model.setMetrics(notification.metrics);
                return true;
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: delegates.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: delegates[index].viewPortHeight,
                    width: screenSize.width,
                    child: ViewModelBuilder.reactive(
                      viewModelBuilder: () => model,
                      disposeViewModel: false,
                      builder: (context, model, child) {
                        return FreezedChild(
                          delegates: delegates,
                          scrollMetrics: model.metrics,
                          screenSize: screenSize,
                          index: index,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class FreezedWidgetDelegate {
  const FreezedWidgetDelegate({
    required this.viewPortHeight,
    required this.childBuilder,
    this.shouldFreeze = true,
  });

  final Widget Function(FreezedMetrics metrics) childBuilder;
  final double viewPortHeight;
  final bool shouldFreeze;
}

class FreezedMetrics {
  const FreezedMetrics({
    required this.scrollOffset,
    required this.freezedOffset,
    required this.origin,
    required this.height,
  });

  const FreezedMetrics.zero(
    this.scrollOffset,
    this.height,
    this.origin,
  ) : freezedOffset = 0;

  final double scrollOffset;
  final double freezedOffset;
  final double height;
  final double origin;

  double get dyFromOrigin => (scrollOffset + height) - origin;
  double get dy => scrollOffset - origin;

  @override
  String toString() {
    return '(scrollOffset: $scrollOffset, freezedOffset: $freezedOffset, height: $height, origin: $origin)';
  }
}
