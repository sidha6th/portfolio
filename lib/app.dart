import 'package:flutter/material.dart'
    show
        BuildContext,
        MaterialApp,
        State,
        StatefulWidget,
        Widget,
        WidgetsBinding,
        precacheImage;
import 'package:flutter_bloc/flutter_bloc.dart'
    show MultiBlocProvider, BlocProvider;
import 'package:sidharth/gen/assets.gen.dart';
import 'package:sidharth/src/core/theme/theme.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/loading_handler/loading_handler_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/blocs/scroll_observer/scroll_observer_bloc.dart';
import 'package:sidharth/src/modules/dashboard/presentation/dashboard.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    _precacheImages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoadingHandlerBloc()),
        BlocProvider(create: (_) => ScrollObserverBloc()),
      ],
      child: MaterialApp(theme: theme(), home: const Dashboard()),
    );
  }

  void _precacheImages(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => Future.wait([
        precacheImage(Assets.images.jpeg.image.provider(), context),
        for (final png in Assets.images.png.values)
          precacheImage(png.provider(), context),
      ]),
    );
  }
}
