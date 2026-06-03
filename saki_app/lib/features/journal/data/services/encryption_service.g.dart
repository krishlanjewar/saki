// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encryption_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(encryptionService)
final encryptionServiceProvider = EncryptionServiceProvider._();

final class EncryptionServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<EncryptionService>,
          EncryptionService,
          FutureOr<EncryptionService>
        >
    with
        $FutureModifier<EncryptionService>,
        $FutureProvider<EncryptionService> {
  EncryptionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'encryptionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$encryptionServiceHash();

  @$internal
  @override
  $FutureProviderElement<EncryptionService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EncryptionService> create(Ref ref) {
    return encryptionService(ref);
  }
}

String _$encryptionServiceHash() => r'16ebd8f99f2835c4af92b17317cb3c77e2c1096c';
