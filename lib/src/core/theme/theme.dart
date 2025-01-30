import 'package:flutter/material.dart';

final theme = ThemeData(
  scrollbarTheme: ScrollbarThemeData(
    thickness: WidgetStateProperty.resolveWith(
      (states) => 0,
    ),
  ),
);
