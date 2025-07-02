import 'package:flutter/material.dart'
    show MaterialApp, StatelessWidget, Widget, BuildContext;
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/state_management/notifier_register.dart';
import 'package:sidharth/src/core/theme/theme.dart';
import 'package:sidharth/src/modules/dashboard/presentation/dashboard.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/loading_notifier.dart';
import 'package:sidharth/src/modules/dashboard/presentation/view_model/screen_size_notifier.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return NotifierRegister(
      create: (_) => ScreenSizeNotifier(context.screenSize),
      child: NotifierRegister(
        create: (context) => LoadingNotifier(),
        child: MaterialApp(theme: theme(), home: const Dashboard()),
      ),
    );
  }
}
