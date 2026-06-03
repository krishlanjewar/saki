import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saki_app/features/calendar/presentation/providers/calendar_state_providers.dart';

void main() {
  group('SelectedDate Provider Tests', () {
    test('initial state should be today at midnight', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final selectedDate = container.read(selectedDateProvider);
      final now = DateTime.now();
      
      expect(selectedDate.year, equals(now.year));
      expect(selectedDate.month, equals(now.month));
      expect(selectedDate.day, equals(now.day));
      expect(selectedDate.hour, equals(0));
      expect(selectedDate.minute, equals(0));
    });

    test('selectDate should update state to target date at midnight', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final target = DateTime(2026, 12, 25, 15, 30);
      container.read(selectedDateProvider.notifier).selectDate(target);

      final selectedDate = container.read(selectedDateProvider);
      expect(selectedDate.year, equals(2026));
      expect(selectedDate.month, equals(12));
      expect(selectedDate.day, equals(25));
      expect(selectedDate.hour, equals(0));
      expect(selectedDate.minute, equals(0));
    });
  });

  group('FocusedDate Provider Tests', () {
    test('initial state should be first day of current month', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final focusedDate = container.read(focusedDateProvider);
      final now = DateTime.now();

      expect(focusedDate.year, equals(now.year));
      expect(focusedDate.month, equals(now.month));
      expect(focusedDate.day, equals(1));
    });

    test('nextMonth should increment month correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(focusedDateProvider.notifier).setMonthAndYear(12, 2025);
      container.read(focusedDateProvider.notifier).nextMonth();

      final focusedDate = container.read(focusedDateProvider);
      expect(focusedDate.year, equals(2026));
      expect(focusedDate.month, equals(1));
    });

    test('previousMonth should decrement month correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(focusedDateProvider.notifier).setMonthAndYear(1, 2026);
      container.read(focusedDateProvider.notifier).previousMonth();

      final focusedDate = container.read(focusedDateProvider);
      expect(focusedDate.year, equals(2025));
      expect(focusedDate.month, equals(12));
    });
  });

  group('Events for Selected Date Provider Tests', () {
    test('should fetch mock events for the selected date', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Select today (offset 0 in mock database)
      final now = DateTime.now();
      container.read(selectedDateProvider.notifier).selectDate(now);

      // Watch eventsForSelectedDateProvider
      final events = await container.read(eventsForSelectedDateProvider.future);

      // Verify that we loaded the seeded mock events for today
      // e.g. 'Task: Team Meeting', 'Task: Brainstorming', 'Submit Q1 review'
      expect(events, isNotEmpty);
      final titles = events.map((e) => e.title).toList();
      expect(titles, contains('Task: Team Meeting'));
      expect(titles, contains('Task: Brainstorming'));
      expect(titles, contains('Submit Q1 review'));
      
      // Check filtering is working (category matches)
      final plans = events.where((e) => e.category == 'plan').toList();
      expect(plans.length, equals(2));
      
      final tasks = events.where((e) => e.category == 'task').toList();
      expect(tasks.length, equals(4));

      final investments = events.where((e) => e.category == 'investment').toList();
      expect(investments.length, equals(3));
    });
  });
}
