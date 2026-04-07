// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const CalendarEvent._();

  const factory CalendarEvent({
    required String id,
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    String? description,
    @Default(false) bool isAllDay,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}
