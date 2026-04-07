// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Calendar)
final calendarProvider = CalendarProvider._();

final class CalendarProvider
    extends $AsyncNotifierProvider<Calendar, List<CalendarEvent>> {
  CalendarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarHash();

  @$internal
  @override
  Calendar create() => Calendar();
}

String _$calendarHash() => r'2cfc3a6fb556cd8b7bfa0687bc52aeaacfec6735';

abstract class _$Calendar extends $AsyncNotifier<List<CalendarEvent>> {
  FutureOr<List<CalendarEvent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CalendarEvent>>, List<CalendarEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CalendarEvent>>, List<CalendarEvent>>,
              AsyncValue<List<CalendarEvent>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
