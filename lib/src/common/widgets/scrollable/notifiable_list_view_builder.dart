import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/dimensions.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KDimensions.kFreezedListHorizontalTotalPadding / 2,
      ),
      child: ViewModelBuilder.nonReactive(
        viewModelBuilder: ScrollObservingViewModel.new,
        onViewModelReady: (viewModel) => viewModel.listenController(),
        builder: (context, model, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                controller: model.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    delegates.length,
                    (index) {
                      final delegate = delegates[index];
                      final child = FreezedReactiveChild(
                        model: model,
                        delegates: delegates,
                        index: index,
                        size: size,
                      );
                      return ConstrainedBox(
                        constraints: BoxConstraints.expand(
                          height: delegate.viewPortHeight(size),
                          width: size.width,
                        ),
                        key: Key('$index-Freezed#Child'),
                        child: delegate.shouldFreeze
                            ? SizedBox(
                                height: size.height,
                                width: size.width,
                                child: child,
                              )
                            : child,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FreezedReactiveChild extends StatelessWidget {
  const FreezedReactiveChild({
    required this.model,
    required this.delegates,
    required this.size,
    required this.index,
    super.key,
  });

  final ScrollObservingViewModel model;
  final List<FreezedWidgetDelegate> delegates;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => model,
      disposeViewModel: false,
      builder: (context, model, child) {
        return FreezedChild(
          delegates: delegates,
          scrollMetrics: model.metrics,
          screenSize: size,
          index: index,
        );
      },
    );
  }
}
