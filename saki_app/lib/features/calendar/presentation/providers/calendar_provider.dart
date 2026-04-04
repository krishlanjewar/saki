import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/calendar_event.dart';
import '../../data/calendar_repository.dart';

part 'calendar_provider.g.dart';

@riverpod
class Calendar extends _$Calendar {
  @override
  FutureOr<List<CalendarEvent>> build() async {
    final repo = ref.watch(calendarRepositoryProvider);
    final now = DateTime.now();
    final result = await repo.getEvents(now, now.add(const Duration(days: 30)));
    
    return result.when(
      success: (events) => events,
      failure: (error) => throw Exception(error),
    );
  }
}
