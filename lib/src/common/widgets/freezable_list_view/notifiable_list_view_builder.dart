import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/helper/visitor_info_logger.dart';
import 'package:sidharth/src/common/model/delegate/base_stickable_widget_delegate.dart';
import 'package:sidharth/src/common/state_management/notifier_register.dart';
import 'package:sidharth/src/common/widgets/box/loading_indicator.dart';
import 'package:sidharth/src/common/widgets/box/under_development_indicator.dart';
import 'package:sidharth/src/common/widgets/freezable_list_view/child_wrapper.dart';
import 'package:sidharth/src/common/widgets/text/loading_info_text.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/screen_size_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/sticky_metrics_notifier.dart';

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
  final List<Widget> Function()? foregroundWidgetBuilder;
  final List<StickableDelegate Function(int index)> delegates;

  @override
  State<NotifiableLisViewBuilder> createState() =>
      _NotifiableLisViewBuilderState();
}

class _NotifiableLisViewBuilderState extends State<NotifiableLisViewBuilder>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  late final state = StickyMetricsState.create(_delegates, context.screenSize);
  late final _delegates = List.generate(widget.delegates.length, (index) {
    return widget.delegates[index](index);
  }, growable: false);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _precacheImages(context);
      context.read<LoadingNotifier>().startLoading(
        _scrollController,
        whenCompleted: VisitorInfoLogger.instance.logInfo,
      );
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    context.read<ScreenSizeNotifier>().onChangeSize(context.screenSize);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotifierRegister(
      create: (context) => StickyMetricsNotifier(state),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: widget.padding,
            physics: widget.physics,
            clipBehavior: Clip.none,
            controller: _scrollController,
            restorationId: widget.restorationId,
            child: Column(
              children: List.generate(
                growable: false,
                widget.delegates.length,
                (index) => ChildWrapper(
                  index: index,
                  delegates: _delegates,
                  scrollController: _scrollController,
                ),
              ),
            ),
          ),
          if (widget.isUnderDevelopment) const UnderDevelopmentIndicator(),
          if (widget.foregroundWidgetBuilder != null)
            ...widget.foregroundWidgetBuilder!(),
          const FullScreenLoadingIndicator(),
          const LoadingInfoTextWidget(),
        ],
      ),
    );
  }

  void _precacheImages(BuildContext context) {
    Future.wait([
      precacheImage(Assets.images.jpeg.image.provider(), context),
      for (final png in Assets.images.png.values)
        precacheImage(png.provider(), context),
    ]);
  }
}
