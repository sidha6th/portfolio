import 'package:flutter/material.dart';

class AutoLayoutAdjustableWidget extends StatelessWidget {
  const AutoLayoutAdjustableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const SizedBox();
      },
    );
  }
}
