import 'package:flutter/material.dart' show Color, Colors;

class AppColors {
  const AppColors._();

  static const black = Color.fromARGB(255, 24, 24, 29);
  static const transparent = Color.fromARGB(100, 24, 24, 29);
  static const black26 = Colors.black26;
  static const black45 = Colors.black45;
  static const white = Colors.white;
  static const cyan = Colors.cyan;
  static const grey = Colors.grey;
  static const offWhite = Color(0xffF8F8F8);
  static const blue = Color(0xff4083ff);
  static const lightBlue = Color(0xff4fa4ff);
  static const yellow = Colors.amber;
  static const shadow = [black, transparent, Colors.transparent];
  static const shadowStops = <double>[0.25, 0.5, 1];

  static const shadowInverse = [Colors.transparent, transparent, black];
  static const inverseShadowStops = <double>[0, 0.5, 0.75];
}
