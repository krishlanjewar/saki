// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journalAuthService)
final journalAuthServiceProvider = JournalAuthServiceProvider._();

final class JournalAuthServiceProvider
    extends
        $FunctionalProvider<
          JournalAuthService,
          JournalAuthService,
          JournalAuthService
        >
    with $Provider<JournalAuthService> {
  JournalAuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalAuthServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalAuthServiceHash();

  @$internal
  @override
  $ProviderElement<JournalAuthService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalAuthService create(Ref ref) {
    return journalAuthService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalAuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalAuthService>(value),
    );
  }
}

String _$journalAuthServiceHash() =>
    r'd57e8959ef40c64ab42d8108d058ccd414abe52e';
