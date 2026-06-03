import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

/// A single trackable habit with weekly completion records.
@freezed
abstract class Habit with _$Habit {
  const Habit._();

  const factory Habit({
    required String id,
    required String name,
    /// Hex color string e.g. "#6C63FF"
    @Default('#6C63FF') String colorHex,
    /// Keys are ISO date strings ("yyyy-MM-dd"), values are completion bools.
    @Default({}) Map<String, bool> completions,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  /// Returns true if this habit was marked done on [date].
  bool isCompletedOn(DateTime date) {
    final key = _dateKey(date);
    return completions[key] ?? false;
  }

  /// Toggles the completion state for [date] and returns an updated Habit.
  Habit toggleOn(DateTime date) {
    final key = _dateKey(date);
    final updated = Map<String, bool>.from(completions);
    updated[key] = !(updated[key] ?? false);
    return copyWith(completions: updated);
  }

  /// Counts consecutive days completed ending today (streak).
  int get currentStreak {
    int streak = 0;
    var day = DateTime.now();
    while (true) {
      if (isCompletedOn(day)) {
        streak++;
        day = day.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
