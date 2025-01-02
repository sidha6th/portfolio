import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
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
    final screenSize = context.screenSize;

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
                  final delegate = delegates[index];

                  final child = ViewModelBuilder.reactive(
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
                  );

                  return ConstrainedBox(
                    constraints: BoxConstraints.expand(
                      height: delegate.viewPortHeight(screenSize),
                      width: screenSize.width,
                    ),
                    key: Key('$index-Freezed#Child'),
                    child: delegate.shouldFreeze
                        ? Column(
                            children: [
                              SizedBox(
                                height: screenSize.height,
                                width: screenSize.width,
                                child: child,
                              ),
                            ],
                          )
                        : child,
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
  final double Function(Size screenSize) viewPortHeight;
  final bool shouldFreeze;
}

class FreezedMetrics {
  const FreezedMetrics({
    required this.scrollOffset,
    required this.freezedDy,
    required this.origin,
    required this.childHeight,
    required this.viewPortSize,
  });

  const FreezedMetrics.zero(
    this.childHeight,
    this.viewPortSize,
  )   : freezedDy = 0,
        scrollOffset = 0,
        origin = 0;

  final double scrollOffset;
  final double freezedDy;
  final double childHeight;
  final double origin;
  final Size viewPortSize;

  double get dy => scrollOffset - origin;

  double get viewPortHeight => viewPortSize.height;
  double get viewPortWidth => viewPortSize.width;

  @override
  String toString() {
    return '(scrollOffset: $scrollOffset, freezedOffset: $freezedDy, height: $childHeight, origin: $origin)';
  }
}
