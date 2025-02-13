import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';

ThemeData theme() => ThemeData(
      primaryColor: AppColors.black,
      scrollbarTheme: ScrollbarThemeData(
        thickness: WidgetStateProperty.resolveWith(
          (states) => 0,
        ),
      ),
    );
