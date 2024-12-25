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
                    height: delegates[index].freezeViewPortHeight,
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
    required this.freezeViewPortHeight,
    required this.childBuilder,
    this.shouldFreeze = true,
  });

  final Widget Function(FreezedMetrics metrics) childBuilder;
  final double freezeViewPortHeight;
  final bool shouldFreeze;
}

class FreezedMetrics {
  const FreezedMetrics({
    required this.scrollOffset,
    required this.freezedOffset,
    required this.height,
  });

  const FreezedMetrics.zero(this.scrollOffset, this.height) : freezedOffset = 0;

  final double scrollOffset;
  final double freezedOffset;
  final double height;

  @override
  String toString() =>
      '(scrollOffset: $scrollOffset, freezedOffset: $freezedOffset, height: $height)';
}
