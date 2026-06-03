// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goalsRepository)
final goalsRepositoryProvider = GoalsRepositoryProvider._();

final class GoalsRepositoryProvider
    extends
        $FunctionalProvider<
          IGoalsRepository,
          IGoalsRepository,
          IGoalsRepository
        >
    with $Provider<IGoalsRepository> {
  GoalsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsRepositoryHash();

  @$internal
  @override
  $ProviderElement<IGoalsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IGoalsRepository create(Ref ref) {
    return goalsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IGoalsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IGoalsRepository>(value),
    );
  }
}

String _$goalsRepositoryHash() => r'c995d83b18115019400bf933a901c1758094b463';
