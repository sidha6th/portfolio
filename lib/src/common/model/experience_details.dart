final class ExperienceDetails {
  const ExperienceDetails({
    required this.org,
    required this.designation,
    required this.begin,
    required DateTime this.end,
  }) : isPresent = false;

  const ExperienceDetails.present({
    required this.org,
    required this.designation,
    required this.begin,
  })  : end = null,
        isPresent = true;

  bool isCurrent(DateTime date) {
    if (isPresent) {
      return date.isAtSameMomentAs(begin) || date.isAfter(begin);
    }
    return date.isBefore(end!) &&
        (date.isAtSameMomentAs(begin) || date.isAfter(begin));
  }

  bool isPast(DateTime dateTime) {
    if (isPresent) {
      final today = DateTime.now();
      return dateTime.isBefore(begin) &&
          dateTime.isAtSameMomentAs(DateTime(today.year, today.month));
    }

    return dateTime.isAfter(end!);
  }

  final String org;
  final String designation;
  final DateTime begin;
  final DateTime? end;
  final bool isPresent;
}
