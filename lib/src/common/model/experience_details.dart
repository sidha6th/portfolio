import 'package:flutter/widgets.dart';

@immutable
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

  @override
  bool operator ==(covariant ExperienceDetails other) {
    if (identical(this, other)) return true;

    return other.org == org &&
        other.designation == designation &&
        other.begin == begin &&
        other.end == end &&
        other.isPresent == isPresent;
  }

  @override
  int get hashCode {
    return org.hashCode ^
        designation.hashCode ^
        begin.hashCode ^
        end.hashCode ^
        isPresent.hashCode;
  }
}
