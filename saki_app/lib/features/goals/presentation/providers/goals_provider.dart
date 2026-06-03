import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/goals_repository.dart';
import '../../domain/models/daily_task.dart';
import '../../domain/models/habit.dart';
import '../../domain/models/reminder.dart';
import '../../domain/models/today_task.dart';

part 'goals_provider.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Notification service (singleton)
// ─────────────────────────────────────────────────────────────────────────────

final _notificationsPlugin = FlutterLocalNotificationsPlugin();
bool _notificationsInitialised = false;

Future<void> initNotifications() async {
  if (_notificationsInitialised) return;
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  await _notificationsPlugin.initialize(
    const InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    ),
  );
  _notificationsInitialised = true;
}

// ─────────────────────────────────────────────────────────────────────────────
// Current week offset — allows navigating forward/backward through weeks
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class HabitWeekOffset extends _$HabitWeekOffset {
  @override
  int build() => 0; // 0 = current week, -1 = last week, +1 = next week

  void goBack()    => state--;
  void goForward() => state++;
  void reset()     => state = 0;
}

// ─────────────────────────────────────────────────────────────────────────────
// Habits Notifier
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class HabitsNotifier extends _$HabitsNotifier {
  @override
  Future<List<Habit>> build() async {
    final repo = ref.watch(goalsRepositoryProvider);
    return repo.getHabits();
  }

  Future<void> addHabit(Habit habit) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = [...current, habit];
    await repo.saveHabits(updated);
    state = AsyncData(updated);
  }

  Future<void> deleteHabit(String id) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = current.where((h) => h.id != id).toList();
    await repo.saveHabits(updated);
    state = AsyncData(updated);
  }

  Future<void> toggleCompletion(String habitId, DateTime date) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = current.map((h) {
      if (h.id == habitId) return h.toggleOn(date);
      return h;
    }).toList();
    await repo.saveHabits(updated);
    state = AsyncData(updated);
    // Refresh contribution graph
    ref.invalidate(contributionDataProvider);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Daily Tasks Notifier
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class DailyTasksNotifier extends _$DailyTasksNotifier {
  @override
  Future<List<DailyTask>> build() async {
    final repo = ref.watch(goalsRepositoryProvider);
    return repo.getDailyTasks();
  }

  Future<void> addTask(DailyTask task) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = [...current, task];
    await repo.saveDailyTasks(updated);
    state = AsyncData(updated);
  }

  Future<void> updateTask(DailyTask task) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = current.map((t) => t.id == task.id ? task : t).toList();
    await repo.saveDailyTasks(updated);
    state = AsyncData(updated);
  }

  Future<void> deleteTask(String id) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = current.where((t) => t.id != id).toList();
    await repo.saveDailyTasks(updated);
    state = AsyncData(updated);
  }

  Future<void> toggleToday(String id) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = current.map((t) => t.id == id ? t.toggleToday() : t).toList();
    await repo.saveDailyTasks(updated);
    state = AsyncData(updated);
    ref.invalidate(contributionDataProvider);
    ref.invalidate(weeklyCompletionRateProvider);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Today's Tasks Notifier
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class TodayTasksNotifier extends _$TodayTasksNotifier {
  static String _todayKey() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Future<List<TodayTask>> build() async {
    final repo = ref.watch(goalsRepositoryProvider);
    final all = await repo.getTodayTasks();
    // Only expose today's tasks
    return all.where((t) => t.date == _todayKey()).toList();
  }

  Future<void> _saveAll(List<TodayTask> todayTasks) async {
    final repo = ref.read(goalsRepositoryProvider);
    // Load ALL tasks, replace today's, save back
    final all = await repo.getTodayTasks();
    final otherDays = all.where((t) => t.date != _todayKey()).toList();
    await repo.saveTodayTasks([...otherDays, ...todayTasks]);
  }

  Future<void> addTask(TodayTask task) async {
    final current = await future;
    final updated = [...current, task];
    await _saveAll(updated);
    state = AsyncData(updated);
  }

  Future<void> toggleTask(String id) async {
    final current = await future;
    final updated = current.map((t) {
      if (t.id == id) return t.copyWith(isCompleted: !t.isCompleted);
      return t;
    }).toList();
    await _saveAll(updated);
    state = AsyncData(updated);
    ref.invalidate(contributionDataProvider);
    ref.invalidate(weeklyCompletionRateProvider);
  }

  Future<void> deleteTask(String id) async {
    final current = await future;
    final updated = current.where((t) => t.id != id).toList();
    await _saveAll(updated);
    state = AsyncData(updated);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reminders Notifier
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class RemindersNotifier extends _$RemindersNotifier {
  @override
  Future<List<Reminder>> build() async {
    await initNotifications();
    final repo = ref.watch(goalsRepositoryProvider);
    return repo.getReminders();
  }

  Future<void> addReminder(Reminder reminder) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final updated = [...current, reminder];
    await repo.saveReminders(updated);
    state = AsyncData(updated);
    await _scheduleNotification(reminder);
  }

  Future<void> deleteReminder(String id) async {
    final repo = ref.read(goalsRepositoryProvider);
    final current = await future;
    final toDelete = current.firstWhere((r) => r.id == id);
    final updated = current.where((r) => r.id != id).toList();
    await repo.saveReminders(updated);
    state = AsyncData(updated);
    // Cancel the scheduled notification
    await _notificationsPlugin.cancel(toDelete.notificationId);
  }

  Future<void> _scheduleNotification(Reminder reminder) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'saki_reminders',
        'Saki Reminders',
        channelDescription: 'Goal reminder notifications',
        importance: Importance.high,
        priority: Priority.high,
      );
      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

      final notifDate = reminder.notificationDateTime;
      final now = DateTime.now();

      // If notification date is today or past, show immediately.
      // Otherwise we just store the intent; a production app would use
      // WorkManager or a background service for future scheduling.
      if (!notifDate.isAfter(now)) {
        await _notificationsPlugin.show(
          reminder.notificationId,
          '⏰ Reminder: ${reminder.name}',
          'Last date is ${reminder.lastDate}. Don\'t forget!',
          details,
        );
      }
      // NOTE: For future dates we only persist — full scheduling would require
      // the timezone package and exact-alarm permission on Android 12+.
    } catch (_) {
      // Best-effort; silently ignore errors.
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Derived / analytics providers
// ─────────────────────────────────────────────────────────────────────────────

/// GitHub-style heatmap data: date → completion count (last 84 days = 12 weeks).
@riverpod
Future<Map<DateTime, int>> contributionData(Ref ref) async {
  final repo = ref.watch(goalsRepositoryProvider);
  return repo.getContributionData(days: 84);
}

/// Completion rate for the current week (0.0 – 1.0).
@riverpod
Future<double> weeklyCompletionRate(Ref ref) async {
  // NOTE: Use habitsProvider (generated name) not habitsProvider
  final habits = await ref.watch(habitsProvider.future);
  final dailyTasks = await ref.watch(dailyTasksProvider.future);

  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));

  int total = 0;
  int done = 0;

  for (int i = 0; i < 7; i++) {
    final day = monday.add(Duration(days: i));
    if (day.isAfter(now)) break;

    for (final h in habits) {
      total++;
      if (h.isCompletedOn(day)) done++;
    }
    for (final t in dailyTasks) {
      total++;
      final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      if (t.completedDates.contains(key)) done++;
    }
  }

  if (total == 0) return 0.0;
  return done / total;
}

/// Current streak: consecutive days where at least 1 task was completed.
@riverpod
Future<int> currentStreak(Ref ref) async {
  final data = await ref.watch(contributionDataProvider.future);
  int streak = 0;
  var day = DateTime.now();
  day = DateTime(day.year, day.month, day.day);

  while (true) {
    final count = data[day] ?? 0;
    if (count > 0) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    } else {
      break;
    }
  }
  return streak;
}
