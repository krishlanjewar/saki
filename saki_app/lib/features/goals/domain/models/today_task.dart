import 'package:freezed_annotation/freezed_annotation.dart';

part 'today_task.freezed.dart';
part 'today_task.g.dart';

/// A one-off task specific to a single day.
/// Filtered at the provider level to only show today's tasks.
@freezed
abstract class TodayTask with _$TodayTask {
  const TodayTask._();

  const factory TodayTask({
    required String id,
    required String name,
    @Default('') String description,
    /// ISO-8601 date string for the day this task belongs to.
    required String date,
    @Default(false) bool isCompleted,
    /// Optional deadline as ISO-8601 datetime string.
    String? deadline,
  }) = _TodayTask;

  factory TodayTask.fromJson(Map<String, dynamic> json) =>
      _$TodayTaskFromJson(json);

  /// The day this task was created, as a DateTime.
  DateTime get taskDate => DateTime.parse(date);

  /// Deadline as a DateTime, if set.
  DateTime? get deadlineDate =>
      deadline != null ? DateTime.tryParse(deadline!) : null;

  /// Whether the deadline has passed (and task is not completed).
  bool get isOverdue {
    final dl = deadlineDate;
    if (dl == null || isCompleted) return false;
    return DateTime.now().isAfter(dl);
  }
}
