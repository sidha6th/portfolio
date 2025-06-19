import 'package:sidharth/src/common/constants/string.dart';

extension ExtensionOnDateTime on DateTime {
  int monthDifference([DateTime? endDate]) {
    endDate ??= DateTime.now();
    int yDiff = endDate.year - year;
    int mDiff = endDate.month - month;

    return ((yDiff * 12) + mDiff) + 1;
  }

  String formated() {
    return '$day/${_month(this)}/$year\n${_format12Hour(this)}:${minute.toString().padLeft(2, '0')} ${hour >= 12 ? 'PM' : 'AM'}';
  }

  String _format12Hour(DateTime date) {
    final hour = date.hour;
    if (hour == 0) return '12';
    if (hour > 12) return (hour - 12).toString();
    return hour.toString();
  }

  String _month(DateTime date) => KString.months[date.month - 1];
}
