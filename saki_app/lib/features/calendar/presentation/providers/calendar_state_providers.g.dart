// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier provider to hold the currently selected date.
/// Uses midnight time (00:00:00) to ensure easy date comparisons.

@ProviderFor(SelectedDate)
final selectedDateProvider = SelectedDateProvider._();

/// Notifier provider to hold the currently selected date.
/// Uses midnight time (00:00:00) to ensure easy date comparisons.
final class SelectedDateProvider
    extends $NotifierProvider<SelectedDate, DateTime> {
  /// Notifier provider to hold the currently selected date.
  /// Uses midnight time (00:00:00) to ensure easy date comparisons.
  SelectedDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedDateHash();

  @$internal
  @override
  SelectedDate create() => SelectedDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$selectedDateHash() => r'0cf41666183e49b01af22660456bd8efa1e8fcae';

/// Notifier provider to hold the currently selected date.
/// Uses midnight time (00:00:00) to ensure easy date comparisons.

abstract class _$SelectedDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier provider to hold the currently focused/viewed month and year.

@ProviderFor(FocusedDate)
final focusedDateProvider = FocusedDateProvider._();

/// Notifier provider to hold the currently focused/viewed month and year.
final class FocusedDateProvider
    extends $NotifierProvider<FocusedDate, DateTime> {
  /// Notifier provider to hold the currently focused/viewed month and year.
  FocusedDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'focusedDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$focusedDateHash();

  @$internal
  @override
  FocusedDate create() => FocusedDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$focusedDateHash() => r'7344f9d1745a58c915a3030d5ac01a1d029acec6';

/// Notifier provider to hold the currently focused/viewed month and year.

abstract class _$FocusedDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// FutureProvider that fetches the events for the currently selected date.

@ProviderFor(eventsForSelectedDate)
final eventsForSelectedDateProvider = EventsForSelectedDateProvider._();

/// FutureProvider that fetches the events for the currently selected date.

final class EventsForSelectedDateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CalendarEvent>>,
          List<CalendarEvent>,
          FutureOr<List<CalendarEvent>>
        >
    with
        $FutureModifier<List<CalendarEvent>>,
        $FutureProvider<List<CalendarEvent>> {
  /// FutureProvider that fetches the events for the currently selected date.
  EventsForSelectedDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsForSelectedDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsForSelectedDateHash();

  @$internal
  @override
  $FutureProviderElement<List<CalendarEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CalendarEvent>> create(Ref ref) {
    return eventsForSelectedDate(ref);
  }
}

String _$eventsForSelectedDateHash() =>
    r'5222655a3d08e914d5997c862a01347ba52b87c0';
