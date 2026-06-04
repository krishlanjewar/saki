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

String _$journalEntriesHash() => r'8a7e181b9f73eb50bd8cbcedd4d728fb2f245f77';

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

String _$journalStatsHash() => r'e5e21ba9ff5ecf034084a5908cda3a99156d7885';

@ProviderFor(hasPinSet)
final hasPinSetProvider = HasPinSetProvider._();

final class HasPinSetProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  HasPinSetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasPinSetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasPinSetHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return hasPinSet(ref);
  }
}

String _$hasPinSetHash() => r'25c25da1b906ebd386df69a3526089bd9c97f9f8';

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

String _$localAuthHash() => r'78fc15c9f699070381b0030442b796f7da6d320c';

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
