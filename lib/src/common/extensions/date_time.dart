extension ExtensionOnDateTime on DateTime {
  int monthDifference([DateTime? endDate]) {
    endDate ??= DateTime.now();
    int yDiff = endDate.year - year;
    int mDiff = endDate.month - month;

    return ((yDiff * 12) + mDiff) + 1;
  }

  List<int> calculateMonthsPast([DateTime? endDate]) {
    final startDate = this;
    final today = endDate ?? DateTime.now();

    List<int> monthsList = [];

    DateTime current = startDate;
    int currentYear = startDate.year;
    int monthsInCurrentYear = 0;

    while (current.isBefore(today) ||
        (current.year == today.year && current.month == today.month)) {
      if (current.year != currentYear) {
        monthsList.add(monthsInCurrentYear);
        monthsInCurrentYear = 0;
        currentYear = current.year;
      }

      monthsInCurrentYear++;
      current = incrementMonth(current);
    }
    if (monthsInCurrentYear > 0) {
      monthsList.add(monthsInCurrentYear);
    }

    return monthsList;
  }

  DateTime incrementMonth(DateTime date) {
    int newYear = date.year;
    int newMonth = date.month + 1;
    if (newMonth > 12) {
      newYear += 1;
      newMonth = 1;
    }

    return DateTime(newYear, newMonth, date.day);
  }
}
