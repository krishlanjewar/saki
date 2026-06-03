// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reflection_prompts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dailyPrompt)
final dailyPromptProvider = DailyPromptProvider._();

final class DailyPromptProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  DailyPromptProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyPromptProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyPromptHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return dailyPrompt(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$dailyPromptHash() => r'4d04eb0d3c9f68d13e054c99c9ac27d65e507cbb';
