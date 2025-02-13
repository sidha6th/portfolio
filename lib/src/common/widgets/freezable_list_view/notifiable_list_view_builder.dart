import 'package:flutter/material.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/box/loading_indicator.dart';
import 'package:sidharth/src/common/widgets/box/under_development_indicator.dart';
import 'package:sidharth/src/common/widgets/freezable_list_view/child_wrapper.dart';
import 'package:sidharth/src/common/widgets/text/loading_info_text.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_handler_view_model.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_observing_view_model.dart';
import 'package:stacked/stacked.dart';

class NotifiableLisViewBuilder extends StatelessWidget {
  const NotifiableLisViewBuilder({
    super.key,
    this.delegates = const [],
    this.foregroundWidgetBuilder,
    this.padding = EdgeInsets.zero,
    this.isUnderDevelopment = false,
    this.restorationId = 'NotifiableScrollView',
    this.physics = const BouncingScrollPhysics(),
  });

  final EdgeInsets padding;
  final String restorationId;
  final ScrollPhysics physics;
  final bool isUnderDevelopment;
  final List<Widget> Function(
    Size windowSize,
    ScrollObservingViewModel model,
  )? foregroundWidgetBuilder;
  final List<FreezedWidgetDelegate> delegates;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: ScrollObservingViewModel.new,
      builder: (context, scrollObserver, child) {
        return ViewModelBuilder.nonReactive(
          viewModelBuilder: () => LoadingHandlerViewModel(
            scrollObserver.scrollController,
            whenLoadingCompleted: scrollObserver.init,
          ),
          onViewModelReady: (loadingController) => loadingController.init(),
          builder: (context, loadingController, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final windowSize = constraints.biggest;
                return Stack(
                  children: [
                    SingleChildScrollView(
                      primary: false,
                      padding: padding,
                      physics: physics,
                      clipBehavior: Clip.none,
                      restorationId: restorationId,
                      controller: scrollObserver.scrollController,
                      child: ViewModelBuilder.reactive(
                        viewModelBuilder: () => loadingController,
                        builder: (context, loadingController, child) {
                          return Column(
                            children: List.generate(
                              growable: false,
                              delegates.length,
                              (index) => ChildWrapper(
                                index: index,
                                size: windowSize,
                                delegates: delegates,
                                model: scrollObserver,
                                hasInitialized: !loadingController.isLoading,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (isUnderDevelopment)
                      UnderDevelopmentIndicator(size: windowSize),
                    if (foregroundWidgetBuilder != null)
                      ...foregroundWidgetBuilder!(windowSize, scrollObserver),
                    FullScreenLoadingIndicator(
                      size: windowSize,
                      loadingController: loadingController,
                    ),
                    LoadingInfoTextWidget(model: loadingController),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
