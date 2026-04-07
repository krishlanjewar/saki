// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpenseList)
final expenseListProvider = ExpenseListProvider._();

final class ExpenseListProvider
    extends $AsyncNotifierProvider<ExpenseList, List<Expense>> {
  ExpenseListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseListHash();

  @$internal
  @override
  ExpenseList create() => ExpenseList();
}

String _$expenseListHash() => r'63bdbaa4228a46089c1f4d9cbff85d04519fc77f';

abstract class _$ExpenseList extends $AsyncNotifier<List<Expense>> {
  FutureOr<List<Expense>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Expense>>, List<Expense>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Expense>>, List<Expense>>,
              AsyncValue<List<Expense>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
