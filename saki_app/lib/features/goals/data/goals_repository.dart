import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/habit.dart';
import '../domain/models/daily_task.dart';
import '../domain/models/today_task.dart';
import '../domain/models/reminder.dart';

part 'goals_repository.g.dart';

// ── SharedPreferences keys ───────────────────────────────────────────────────
const _kHabits       = 'saki_goals_habits';
const _kDailyTasks   = 'saki_goals_daily_tasks';
const _kTodayTasks   = 'saki_goals_today_tasks';
const _kReminders    = 'saki_goals_reminders';

/// Repository for all Goals data. Uses SharedPreferences as the local store.
/// Each entity list is serialised as a JSON string.
abstract class IGoalsRepository {
  Future<List<Habit>>     getHabits();
  Future<void>            saveHabits(List<Habit> habits);

  Future<List<DailyTask>> getDailyTasks();
  Future<void>            saveDailyTasks(List<DailyTask> tasks);

  Future<List<TodayTask>> getTodayTasks();
  Future<void>            saveTodayTasks(List<TodayTask> tasks);

  Future<List<Reminder>>  getReminders();
  Future<void>            saveReminders(List<Reminder> reminders);

  /// Builds a map of date → completedCount for the contribution graph.
  /// Aggregates across habits, daily tasks, and today tasks for the last [days].
  Future<Map<DateTime, int>> getContributionData({int days = 84});
}

class GoalsRepository implements IGoalsRepository {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _p async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ── Habits ─────────────────────────────────────────────────────────────────
  @override
  Future<List<Habit>> getHabits() async {
    final prefs = await _p;
    final raw = prefs.getString(_kHabits);
    if (raw == null) return _defaultHabits();
    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((e) => Habit.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return _defaultHabits();
    }
  }

  @override
  Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await _p;
    await prefs.setString(_kHabits, jsonEncode(habits.map((h) => h.toJson()).toList()));
  }

  // ── Daily Tasks ────────────────────────────────────────────────────────────
  @override
  Future<List<DailyTask>> getDailyTasks() async {
    final prefs = await _p;
    final raw = prefs.getString(_kDailyTasks);
    if (raw == null) return _defaultDailyTasks();
    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((e) => DailyTask.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return _defaultDailyTasks();
    }
  }

  @override
  Future<void> saveDailyTasks(List<DailyTask> tasks) async {
    final prefs = await _p;
    await prefs.setString(_kDailyTasks, jsonEncode(tasks.map((t) => t.toJson()).toList()));
  }

  // ── Today Tasks ────────────────────────────────────────────────────────────
  @override
  Future<List<TodayTask>> getTodayTasks() async {
    final prefs = await _p;
    final raw = prefs.getString(_kTodayTasks);
    if (raw == null) return [];
    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((e) => TodayTask.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveTodayTasks(List<TodayTask> tasks) async {
    final prefs = await _p;
    await prefs.setString(_kTodayTasks, jsonEncode(tasks.map((t) => t.toJson()).toList()));
  }

  // ── Reminders ──────────────────────────────────────────────────────────────
  @override
  Future<List<Reminder>> getReminders() async {
    final prefs = await _p;
    final raw = prefs.getString(_kReminders);
    if (raw == null) return [];
    try {
      final List<dynamic> list = jsonDecode(raw);
      return list.map((e) => Reminder.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveReminders(List<Reminder> reminders) async {
    final prefs = await _p;
    await prefs.setString(_kReminders, jsonEncode(reminders.map((r) => r.toJson()).toList()));
  }

  // ── Contribution Data ──────────────────────────────────────────────────────
  @override
  Future<Map<DateTime, int>> getContributionData({int days = 84}) async {
    final habits     = await getHabits();
    final dailyTasks = await getDailyTasks();
    final todayTasks = await getTodayTasks();

    final result = <DateTime, int>{};
    final now = DateTime.now();

    for (int i = 0; i < days; i++) {
      final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final key = _dateKey(day);
      int count = 0;

      // Count habit completions
      for (final habit in habits) {
        if (habit.completions[key] == true) count++;
      }

      // Count daily task completions
      for (final task in dailyTasks) {
        if (task.completedDates.contains(key)) count++;
      }

      // Count today task completions
      for (final task in todayTasks) {
        if (task.date == key && task.isCompleted) count++;
      }

      result[day] = count;
    }

    return result;
  }

  // ── Default seed data ──────────────────────────────────────────────────────

  static List<Habit> _defaultHabits() => [
    const Habit(id: 'h1', name: 'Drink Water',  colorHex: '#42A5F5'),
    const Habit(id: 'h2', name: 'Exercise',     colorHex: '#66BB6A'),
    const Habit(id: 'h3', name: 'Read',         colorHex: '#FFA726'),
    const Habit(id: 'h4', name: 'Meditate',     colorHex: '#AB47BC'),
  ];

  static List<DailyTask> _defaultDailyTasks() => [
    const DailyTask(id: 'dt1', name: 'Morning journaling', category: DailyTaskCategory.study),
    const DailyTask(id: 'dt2', name: 'Evening walk',       category: DailyTaskCategory.health),
  ];

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

@riverpod
IGoalsRepository goalsRepository(Ref ref) => GoalsRepository();
