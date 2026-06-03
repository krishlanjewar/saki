import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/result.dart';
import '../domain/models/calendar_event.dart';

part 'calendar_repository.g.dart';

abstract class ICalendarRepository {
  Future<Result<List<CalendarEvent>, String>> getEvents(DateTime start, DateTime end);
  Future<Result<CalendarEvent, String>> addEvent(CalendarEvent event);
}

class CalendarRepository implements ICalendarRepository {
  static final DateTime _today = DateTime.now();

  static DateTime _dateAt(int dayOffset, {int hour = 9, int minute = 0}) {
    final target = _today.add(Duration(days: dayOffset));
    return DateTime(target.year, target.month, target.day, hour, minute);
  }

  // NOTE: Pre-populated list of events with diverse categories (plan, task, investment, expense)
  // seeded relative to today's date.
  static final List<CalendarEvent> _mockEvents = [
    // --- TODAY ---
    CalendarEvent(
      id: 'e1',
      title: 'Task: Team Meeting',
      startTime: _dateAt(0, hour: 10),
      endTime: _dateAt(0, hour: 11),
      description: 'Review project roadmap',
      category: 'plan',
    ),
    CalendarEvent(
      id: 'e2',
      title: 'Task: Brainstorming',
      startTime: _dateAt(0, hour: 14),
      endTime: _dateAt(0, hour: 15),
      description: 'Generate new ideas',
      category: 'plan',
    ),
    CalendarEvent(
      id: 'e3',
      title: 'Submit Q1 review',
      startTime: _dateAt(0, hour: 9),
      endTime: _dateAt(0, hour: 10),
      description: 'remark -',
      category: 'task',
      isCompleted: true,
    ),
    CalendarEvent(
      id: 'e4',
      title: 'Task body',
      startTime: _dateAt(0, hour: 11),
      endTime: _dateAt(0, hour: 12),
      description: 'reason-',
      category: 'task',
      isCompleted: false,
    ),
    CalendarEvent(
      id: 'e5',
      title: 'Task - Remain',
      startTime: _dateAt(0, hour: 16),
      endTime: _dateAt(0, hour: 17),
      description: 'Task body reason-',
      category: 'task',
      isCompleted: false,
    ),
    CalendarEvent(
      id: 'e6',
      title: 'Task - DONE:',
      startTime: _dateAt(0, hour: 17, minute: 30),
      endTime: _dateAt(0, hour: 18),
      description: 'Submit Q1 review remark -',
      category: 'task',
      isCompleted: true,
    ),
    CalendarEvent(
      id: 'e7',
      title: 'Stocks purchase',
      startTime: _dateAt(0, hour: 12),
      endTime: _dateAt(0, hour: 12, minute: 30),
      category: 'investment',
      amount: 5000,
    ),
    CalendarEvent(
      id: 'e8',
      title: 'Mutual Fund',
      startTime: _dateAt(0, hour: 13),
      endTime: _dateAt(0, hour: 13, minute: 30),
      category: 'investment',
      amount: 5000,
    ),
    CalendarEvent(
      id: 'e9',
      title: 'Savings bond',
      startTime: _dateAt(0, hour: 15),
      endTime: _dateAt(0, hour: 15, minute: 30),
      category: 'investment',
      amount: 5000,
    ),
    CalendarEvent(
      id: 'e10',
      title: 'Expense: Lunch',
      startTime: _dateAt(0, hour: 13),
      endTime: _dateAt(0, hour: 14),
      description: 'Team outing',
      category: 'expense',
      amount: 450,
    ),
    CalendarEvent(
      id: 'e11',
      title: 'Expense: Transport',
      startTime: _dateAt(0, hour: 18),
      endTime: _dateAt(0, hour: 18, minute: 30),
      description: 'Taxi fare',
      category: 'expense',
      amount: 820,
    ),
    CalendarEvent(
      id: 'e12',
      title: 'Expense: Supplies',
      startTime: _dateAt(0, hour: 10),
      endTime: _dateAt(0, hour: 10, minute: 30),
      description: 'Office stationery',
      category: 'expense',
      amount: 300,
    ),

    // --- TOMORROW ---
    CalendarEvent(
      id: 'e13',
      title: 'Task: Client Call',
      startTime: _dateAt(1, hour: 10),
      endTime: _dateAt(1, hour: 11),
      description: 'Discuss feedback',
      category: 'plan',
    ),
    CalendarEvent(
      id: 'e14',
      title: 'Design Review',
      startTime: _dateAt(1, hour: 11),
      endTime: _dateAt(1, hour: 12),
      category: 'task',
      isCompleted: false,
    ),
    CalendarEvent(
      id: 'e15',
      title: 'Code Refactoring',
      startTime: _dateAt(1, hour: 14),
      endTime: _dateAt(1, hour: 16),
      category: 'task',
      isCompleted: true,
    ),
    CalendarEvent(
      id: 'e16',
      title: 'Crypto Investment',
      startTime: _dateAt(1, hour: 12),
      endTime: _dateAt(1, hour: 12, minute: 30),
      category: 'investment',
      amount: 2500,
    ),
    CalendarEvent(
      id: 'e17',
      title: 'Expense: Grocery shopping',
      startTime: _dateAt(1, hour: 17),
      endTime: _dateAt(1, hour: 18),
      category: 'expense',
      amount: 1200,
    ),

    // --- YESTERDAY ---
    CalendarEvent(
      id: 'e18',
      title: 'Task: Project Kickoff',
      startTime: _dateAt(-1, hour: 9),
      endTime: _dateAt(-1, hour: 10),
      description: 'Align on deliverables',
      category: 'plan',
    ),
    CalendarEvent(
      id: 'e19',
      title: 'Setup repository',
      startTime: _dateAt(-1, hour: 10),
      endTime: _dateAt(-1, hour: 11),
      category: 'task',
      isCompleted: true,
    ),
    CalendarEvent(
      id: 'e20',
      title: 'Expense: Dinner with client',
      startTime: _dateAt(-1, hour: 20),
      endTime: _dateAt(-1, hour: 22),
      category: 'expense',
      amount: 3500,
    ),
  ];

  @override
  Future<Result<List<CalendarEvent>, String>> getEvents(DateTime start, DateTime end) async {
    // Normalise start and end times
    final startVal = DateTime(start.year, start.month, start.day);
    final endVal = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final filtered = _mockEvents.where((e) {
      return e.startTime.isAfter(startVal.subtract(const Duration(seconds: 1))) &&
             e.startTime.isBefore(endVal.add(const Duration(seconds: 1)));
    }).toList();
    return Result.success(filtered);
  }

  @override
  Future<Result<CalendarEvent, String>> addEvent(CalendarEvent event) async {
    _mockEvents.add(event);
    return Result.success(event);
  }
}

@riverpod
ICalendarRepository calendarRepository(Ref ref) {
  return CalendarRepository();
}
