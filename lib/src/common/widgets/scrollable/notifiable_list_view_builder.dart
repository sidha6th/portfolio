import 'package:flutter/material.dart';
import 'package:sidharth/src/common/extensions/iterable.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/box/loading_indicator.dart';
import 'package:sidharth/src/common/widgets/box/under_development_indicator.dart';
import 'package:sidharth/src/common/widgets/freezed_child.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_handler_view_model.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/scroll_observing_view_model.dart';
import 'package:stacked/stacked.dart';

class NotifiableLisViewBuilder extends StatelessWidget {
  const NotifiableLisViewBuilder({
    super.key,
    this.delegates = const [],
    this.padding = EdgeInsets.zero,
    this.physics = const BouncingScrollPhysics(),
    this.foregroundWidgetBuilder,
    this.isUnderDevelopment = false,
    this.restorationId = 'NotifiableScrollView',
  });

  final List<FreezedWidgetDelegate> delegates;
  final EdgeInsets padding;
  final String restorationId;
  final ScrollPhysics physics;
  final bool isUnderDevelopment;
  final List<Widget> Function(
    ScrollObservingViewModel model,
    Size windowSize,
  )? foregroundWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: ScrollObservingViewModel.new,
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return ViewModelBuilder.nonReactive(
          viewModelBuilder: () =>
              LoadingHandlerViewModel(scrollController: model.scrollController),
          onViewModelReady: (viewModel) => viewModel.init(),
          builder: (context, loadingHandler, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final windowSize = constraints.biggest;
                return Stack(
                  children: [
                    ListView(
                      padding: padding,
                      physics: physics,
                      restorationId: restorationId,
                      primary: false,
                      controller: model.scrollController,
                      children: List.generate(
                        delegates.length,
                        (index) => _ChildWrapper(
                          size: windowSize,
                          index: index,
                          model: model,
                          delegates: delegates,
                        ),
                      ),
                    ),
                    if (isUnderDevelopment)
                      UnderDevelopmentIndicator(size: windowSize),
                    if (foregroundWidgetBuilder != null)
                      ...foregroundWidgetBuilder!(model, windowSize),
                    ViewModelBuilder.reactive(
                      viewModelBuilder: () => loadingHandler,
                      disposeViewModel: false,
                      builder: (context, loadingHandler, child) {
                        return LoadingIndicator(
                          size: windowSize,
                          isLoading: loadingHandler.loadingContent,
                          animate: !loadingHandler.loadingContent,
                          value: loadingHandler.progress,
                        );
                      },
                    ),
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

class _ChildWrapper extends StatefulWidget {
  const _ChildWrapper({
    required this.size,
    required this.index,
    required this.model,
    required this.delegates,
  });

  final Size size;
  final int index;
  final ScrollObservingViewModel model;
  final List<FreezedWidgetDelegate> delegates;

  @override
  State<_ChildWrapper> createState() => _ChildWrapperState();
}

class _ChildWrapperState extends State<_ChildWrapper> {
  late final _key = Key('${widget.index}-Freezed#Child');
  FreezedWidgetDelegate get _delegate => widget.delegates[widget.index];
  late var scrollFreezeHeight = _delegate.freezedScrollHeight(widget.size);
  late var pastScrolledHeight = _calcPastViewPortHeight;

  @override
  void didUpdateWidget(covariant _ChildWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    scrollFreezeHeight = _delegate.freezedScrollHeight(widget.size);
    pastScrolledHeight = _calcPastViewPortHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      width: widget.size.width,
      height: scrollFreezeHeight,
      child: ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => widget.model,
        builder: (context, model, child) {
          return FreezedChild(
            index: widget.index,
            screenSize: widget.size,
            currentDelegate: _delegate,
            delegates: widget.delegates,
            scrollMetrics: model.metrics,
            pastScrolledHeight: pastScrolledHeight,
            scrollFreezeHeight: scrollFreezeHeight,
            setFocusedDelegate: model.setCurrentFocusingIndex,
          );
        },
      ),
    );
  }

  double get _calcPastViewPortHeight {
    return widget.delegates.transform<double>(
          (e, result) => e.freezedScrollHeight(widget.size) + (result ?? 0),
          end: widget.index + 1,
        ) ??
        0;
  }
}
