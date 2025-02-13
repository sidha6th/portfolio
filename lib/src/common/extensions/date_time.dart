import 'package:intl/intl.dart';

extension ExtensionOnDateTime on DateTime {
  int monthDifference([DateTime? endDate]) {
    endDate ??= DateTime.now();
    int yDiff = endDate.year - year;
    int mDiff = endDate.month - month;

    return ((yDiff * 12) + mDiff) + 1;
  }

  String format([String? newPattern, String? locale]) =>
      DateFormat(newPattern, locale).format(this);
}
