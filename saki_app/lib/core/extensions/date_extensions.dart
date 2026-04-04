import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  /// Formats the date as 'MMM dd, yyyy' (e.g., Oct 24, 2026)
  String toFormattedDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Formats the date as 'HH:mm'
  String toFormattedTime() {
    return DateFormat('HH:mm').format(this);
  }
  
  /// Checks if this date is the same day as another date
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
