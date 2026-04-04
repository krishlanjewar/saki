import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/result.dart';
import '../domain/models/calendar_event.dart';

part 'calendar_repository.g.dart';

abstract class ICalendarRepository {
  Future<Result<List<CalendarEvent>, String>> getEvents(DateTime start, DateTime end);
  Future<Result<CalendarEvent, String>> addEvent(CalendarEvent event);
}

class CalendarRepository implements ICalendarRepository {
  @override
  Future<Result<List<CalendarEvent>, String>> getEvents(DateTime start, DateTime end) async {
    // Implement data fetching
    return const Result.success([]);
  }

  @override
  Future<Result<CalendarEvent, String>> addEvent(CalendarEvent event) async {
    // Implement data saving
    return Result.success(event);
  }
}

@riverpod
ICalendarRepository calendarRepository(CalendarRepositoryRef ref) {
  return CalendarRepository();
}
