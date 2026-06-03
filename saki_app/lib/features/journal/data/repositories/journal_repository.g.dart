// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journalRepository)
final journalRepositoryProvider = JournalRepositoryProvider._();

final class JournalRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IJournalRepository>,
          IJournalRepository,
          FutureOr<IJournalRepository>
        >
    with
        $FutureModifier<IJournalRepository>,
        $FutureProvider<IJournalRepository> {
  JournalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<IJournalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IJournalRepository> create(Ref ref) {
    return journalRepository(ref);
  }
}

String _$journalRepositoryHash() => r'c68fa411020c50fc63d205b48bd34b2ca30320b2';
