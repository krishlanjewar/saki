// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HabitWeekOffset)
final habitWeekOffsetProvider = HabitWeekOffsetProvider._();

final class HabitWeekOffsetProvider
    extends $NotifierProvider<HabitWeekOffset, int> {
  HabitWeekOffsetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitWeekOffsetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitWeekOffsetHash();

  @$internal
  @override
  HabitWeekOffset create() => HabitWeekOffset();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$habitWeekOffsetHash() => r'7e030ccdfce37d39eef87f521cad858f02e321dc';

abstract class _$HabitWeekOffset extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(HabitsNotifier)
final habitsProvider = HabitsNotifierProvider._();

final class HabitsNotifierProvider
    extends $AsyncNotifierProvider<HabitsNotifier, List<Habit>> {
  HabitsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsNotifierHash();

  @$internal
  @override
  HabitsNotifier create() => HabitsNotifier();
}

String _$habitsNotifierHash() => r'75762519e0d58ea130d04787b372bf57c90dce86';

abstract class _$HabitsNotifier extends $AsyncNotifier<List<Habit>> {
  FutureOr<List<Habit>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Habit>>, List<Habit>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Habit>>, List<Habit>>,
              AsyncValue<List<Habit>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(DailyTasksNotifier)
final dailyTasksProvider = DailyTasksNotifierProvider._();

final class DailyTasksNotifierProvider
    extends $AsyncNotifierProvider<DailyTasksNotifier, List<DailyTask>> {
  DailyTasksNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyTasksNotifierHash();

  @$internal
  @override
  DailyTasksNotifier create() => DailyTasksNotifier();
}

String _$dailyTasksNotifierHash() =>
    r'fb7a5d33d358833c7d67d72e2b60e73e2173391e';

abstract class _$DailyTasksNotifier extends $AsyncNotifier<List<DailyTask>> {
  FutureOr<List<DailyTask>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<DailyTask>>, List<DailyTask>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DailyTask>>, List<DailyTask>>,
              AsyncValue<List<DailyTask>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TodayTasksNotifier)
final todayTasksProvider = TodayTasksNotifierProvider._();

final class TodayTasksNotifierProvider
    extends $AsyncNotifierProvider<TodayTasksNotifier, List<TodayTask>> {
  TodayTasksNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayTasksNotifierHash();

  @$internal
  @override
  TodayTasksNotifier create() => TodayTasksNotifier();
}

String _$todayTasksNotifierHash() =>
    r'3a3677991d5effa7958663aa5ea6d14434896541';

abstract class _$TodayTasksNotifier extends $AsyncNotifier<List<TodayTask>> {
  FutureOr<List<TodayTask>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<TodayTask>>, List<TodayTask>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TodayTask>>, List<TodayTask>>,
              AsyncValue<List<TodayTask>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(RemindersNotifier)
final remindersProvider = RemindersNotifierProvider._();

final class RemindersNotifierProvider
    extends $AsyncNotifierProvider<RemindersNotifier, List<Reminder>> {
  RemindersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersNotifierHash();

  @$internal
  @override
  RemindersNotifier create() => RemindersNotifier();
}

String _$remindersNotifierHash() => r'2e0d55b8e41323f15733ac286f0222bb48b6e863';

abstract class _$RemindersNotifier extends $AsyncNotifier<List<Reminder>> {
  FutureOr<List<Reminder>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Reminder>>, List<Reminder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Reminder>>, List<Reminder>>,
              AsyncValue<List<Reminder>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// GitHub-style heatmap data: date → completion count (last 84 days = 12 weeks).

@ProviderFor(contributionData)
final contributionDataProvider = ContributionDataProvider._();

/// GitHub-style heatmap data: date → completion count (last 84 days = 12 weeks).

final class ContributionDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<DateTime, int>>,
          Map<DateTime, int>,
          FutureOr<Map<DateTime, int>>
        >
    with
        $FutureModifier<Map<DateTime, int>>,
        $FutureProvider<Map<DateTime, int>> {
  /// GitHub-style heatmap data: date → completion count (last 84 days = 12 weeks).
  ContributionDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contributionDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contributionDataHash();

  @$internal
  @override
  $FutureProviderElement<Map<DateTime, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<DateTime, int>> create(Ref ref) {
    return contributionData(ref);
  }
}

String _$contributionDataHash() => r'431e7cea7d57aee7d64dcea9a999687b4428ae98';

/// Completion rate for the current week (0.0 – 1.0).

@ProviderFor(weeklyCompletionRate)
final weeklyCompletionRateProvider = WeeklyCompletionRateProvider._();

/// Completion rate for the current week (0.0 – 1.0).

final class WeeklyCompletionRateProvider
    extends $FunctionalProvider<AsyncValue<double>, double, FutureOr<double>>
    with $FutureModifier<double>, $FutureProvider<double> {
  /// Completion rate for the current week (0.0 – 1.0).
  WeeklyCompletionRateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyCompletionRateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyCompletionRateHash();

  @$internal
  @override
  $FutureProviderElement<double> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<double> create(Ref ref) {
    return weeklyCompletionRate(ref);
  }
}

String _$weeklyCompletionRateHash() =>
    r'f8f82d9a97f2fc877e9f05372df268c82ee03970';

/// Current streak: consecutive days where at least 1 task was completed.

@ProviderFor(currentStreak)
final currentStreakProvider = CurrentStreakProvider._();

/// Current streak: consecutive days where at least 1 task was completed.

final class CurrentStreakProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Current streak: consecutive days where at least 1 task was completed.
  CurrentStreakProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentStreakProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentStreakHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return currentStreak(ref);
  }
}

String _$currentStreakHash() => r'f1388752e6928ce3559730d191bcf4a96703669c';
