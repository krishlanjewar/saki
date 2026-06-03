import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

/// A reminder with a last-date deadline and a scheduled notification date.
@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String name,
    /// ISO-8601 date string for the deadline.
    required String lastDate,
    /// ISO-8601 date string for when the notification fires.
    required String notificationDate,
    /// The flutter_local_notifications notification ID for cancellation.
    required int notificationId,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

extension ReminderX on Reminder {
  DateTime get lastDateTime => DateTime.parse(lastDate);
  DateTime get notificationDateTime => DateTime.parse(notificationDate);

  /// Days remaining until the last date.
  int get daysRemaining =>
      lastDateTime.difference(DateTime.now()).inDays.clamp(0, 999);
}
