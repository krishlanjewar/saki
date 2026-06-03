import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/calendar_event.dart';
import '../../data/calendar_repository.dart';
import '../../../../shared/models/result.dart';

part 'calendar_state_providers.g.dart';

/// Notifier provider to hold the currently selected date.
/// Uses midnight time (00:00:00) to ensure easy date comparisons.
@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Updates the selected date, normalising the time to midnight.
  void selectDate(DateTime date) {
    state = DateTime(date.year, date.month, date.day);
  }
}

/// Notifier provider to hold the currently focused/viewed month and year.
@riverpod
class FocusedDate extends _$FocusedDate {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  /// Move focus to the next month.
  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  /// Move focus to the previous month.
  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }

  /// Set the month and year explicitly.
  void setMonthAndYear(int month, int year) {
    state = DateTime(year, month, 1);
  }
}

/// FutureProvider that fetches the events for the currently selected date.
@riverpod
FutureOr<List<CalendarEvent>> eventsForSelectedDate(Ref ref) async {
  final selectedDate = ref.watch(selectedDateProvider);
  final repo = ref.watch(calendarRepositoryProvider);
  
  final start = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final end = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
  
  final result = await repo.getEvents(start, end);
  return result.when(
    success: (events) => events,
    failure: (error) => throw Exception(error),
  );
}
