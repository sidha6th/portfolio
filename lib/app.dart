import 'package:flutter/material.dart';
import 'package:sidharth/src/core/theme/theme.dart';
import 'package:sidharth/src/modules/dashboard/presentation/dashboard.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: const Dashboard(),
    );
  }
}
