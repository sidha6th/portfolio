import 'package:flutter/material.dart' show runApp, WidgetsFlutterBinding;
import 'package:provider/provider.dart';
import 'package:sidharth/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(const App());
}
