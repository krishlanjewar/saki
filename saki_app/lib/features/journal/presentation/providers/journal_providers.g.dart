// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JournalEntries)
final journalEntriesProvider = JournalEntriesProvider._();

final class JournalEntriesProvider
    extends $AsyncNotifierProvider<JournalEntries, List<JournalEntry>> {
  JournalEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalEntriesHash();

  @$internal
  @override
  JournalEntries create() => JournalEntries();
}

String _$journalEntriesHash() => r'8141ff7f49482c5420fede7a66690651b2d87e97';

abstract class _$JournalEntries extends $AsyncNotifier<List<JournalEntry>> {
  FutureOr<List<JournalEntry>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<JournalEntry>>, List<JournalEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<JournalEntry>>, List<JournalEntry>>,
              AsyncValue<List<JournalEntry>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(JournalDraft)
final journalDraftProvider = JournalDraftProvider._();

final class JournalDraftProvider
    extends $AsyncNotifierProvider<JournalDraft, JournalEntry?> {
  JournalDraftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalDraftProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalDraftHash();

  @$internal
  @override
  JournalDraft create() => JournalDraft();
}

String _$journalDraftHash() => r'9b277251df9c752407ecfea00cf84c7e00815957';

abstract class _$JournalDraft extends $AsyncNotifier<JournalEntry?> {
  FutureOr<JournalEntry?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<JournalEntry?>, JournalEntry?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<JournalEntry?>, JournalEntry?>,
              AsyncValue<JournalEntry?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(journalStats)
final journalStatsProvider = JournalStatsProvider._();

final class JournalStatsProvider
    extends $FunctionalProvider<JournalStats, JournalStats, JournalStats>
    with $Provider<JournalStats> {
  JournalStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalStatsHash();

  @$internal
  @override
  $ProviderElement<JournalStats> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JournalStats create(Ref ref) {
    return journalStats(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalStats>(value),
    );
  }
}

String _$journalStatsHash() => r'1356b6aa5da2461b3b2812af4e8de323d50c9208';

@ProviderFor(LocalAuth)
final localAuthProvider = LocalAuthProvider._();

final class LocalAuthProvider extends $AsyncNotifierProvider<LocalAuth, bool> {
  LocalAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localAuthHash();

  @$internal
  @override
  LocalAuth create() => LocalAuth();
}

String _$localAuthHash() => r'548d7a82d50c260949eed61218f28e4b2192295a';

abstract class _$LocalAuth extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
