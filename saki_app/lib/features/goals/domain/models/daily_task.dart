import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_task.freezed.dart';
part 'daily_task.g.dart';

/// Category for daily tasks.
enum DailyTaskCategory { health, study, work, other }

extension DailyTaskCategoryLabel on DailyTaskCategory {
  String get label {
    switch (this) {
      case DailyTaskCategory.health: return 'Health';
      case DailyTaskCategory.study:  return 'Study';
      case DailyTaskCategory.work:   return 'Work';
      case DailyTaskCategory.other:  return 'Other';
    }
  }

  String get emoji {
    switch (this) {
      case DailyTaskCategory.health: return '💪';
      case DailyTaskCategory.study:  return '📚';
      case DailyTaskCategory.work:   return '💼';
      case DailyTaskCategory.other:  return '⭐';
    }
  }
}

/// A task that repeats every day. Completion is tracked per-date.
@freezed
abstract class DailyTask with _$DailyTask {
  const DailyTask._();

  const factory DailyTask({
    required String id,
    required String name,
    @Default(DailyTaskCategory.other) DailyTaskCategory category,
    /// ISO date strings on which this task was completed.
    @Default([]) List<String> completedDates,
  }) = _DailyTask;

  factory DailyTask.fromJson(Map<String, dynamic> json) =>
      _$DailyTaskFromJson(json);

  static String _todayKey() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  /// Whether this task is already completed today.
  bool get isCompletedToday => completedDates.contains(_todayKey());

  /// Toggles today's completion and returns the updated task.
  DailyTask toggleToday() {
    final key = _todayKey();
    final updated = List<String>.from(completedDates);
    if (updated.contains(key)) {
      updated.remove(key);
    } else {
      updated.add(key);
    }
    return copyWith(completedDates: updated);
  }
}
