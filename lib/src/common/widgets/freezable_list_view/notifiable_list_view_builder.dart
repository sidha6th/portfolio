import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:sidharth/src/common/extensions/build_context_extension.dart';
import 'package:sidharth/src/common/helper/visitor_info_logger.dart';
import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';
import 'package:sidharth/src/common/widgets/box/loading_indicator.dart';
import 'package:sidharth/src/common/widgets/box/under_development_indicator.dart';
import 'package:sidharth/src/common/widgets/freezable_list_view/child_wrapper.dart';
import 'package:sidharth/src/common/widgets/text/loading_info_text.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_event.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_state.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_event.dart';

class NotifiableLisViewBuilder extends StatefulWidget {
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
  final List<FreezedWidgetDelegate> delegates;
  final List<Widget> Function(Size windowSize)? foregroundWidgetBuilder;

  @override
  State<NotifiableLisViewBuilder> createState() =>
      _NotifiableLisViewBuilderState();
}

class _NotifiableLisViewBuilderState extends State<NotifiableLisViewBuilder> {
  late final scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _startPageLoading(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final windowSize = constraints.biggest;
        return Stack(
          children: [
            SingleChildScrollView(
              padding: widget.padding,
              physics: widget.physics,
              clipBehavior: Clip.none,
              controller: scrollController,
              restorationId: widget.restorationId,
              child: BlocBuilder<LoadingHandlerBloc, LoadingHandlerState>(
                buildWhen: (previous, current) =>
                    previous != current && !current.isLoading,
                builder: (_, loadingState) {
                  return Column(
                    children: List.generate(
                      growable: false,
                      widget.delegates.length,
                      (index) => ChildWrapper(
                        index: index,
                        size: windowSize,
                        delegates: widget.delegates,
                        hasInitialized: !loadingState.isLoading,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.isUnderDevelopment)
              UnderDevelopmentIndicator(size: windowSize),
            if (widget.foregroundWidgetBuilder != null)
              ...widget.foregroundWidgetBuilder!(windowSize),
            FullScreenLoadingIndicator(size: windowSize),
            const LoadingInfoTextWidget(),
          ],
        );
      },
    );
  }

  void _whenLoadingCompleted() {
    final bloc = context.scrollObsBloc;
    scrollController.addListener(() {
      bloc.add(UpdateScrollMetrics(scrollController.offset));
    });
  }

  void _startPageLoading(BuildContext context) {
    context.loadingHandlerBloc.add(
      StartLoadPage(
        scrollController,
        onFinish: _whenLoadingCompleted,
        onStart: () => const VisitorInfoLogger().logInfo(),
      ),
    );
  }
}
