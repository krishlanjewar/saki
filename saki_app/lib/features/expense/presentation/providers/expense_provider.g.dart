// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExpenseDateFilter)
final expenseDateFilterProvider = ExpenseDateFilterProvider._();

final class ExpenseDateFilterProvider
    extends $NotifierProvider<ExpenseDateFilter, DateRangeFilter> {
  ExpenseDateFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseDateFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseDateFilterHash();

  @$internal
  @override
  ExpenseDateFilter create() => ExpenseDateFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateRangeFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateRangeFilter>(value),
    );
  }
}

String _$expenseDateFilterHash() => r'607dc5a3334d0bc96f3d8bcea32dc2b9a979a42f';

abstract class _$ExpenseDateFilter extends $Notifier<DateRangeFilter> {
  DateRangeFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateRangeFilter, DateRangeFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateRangeFilter, DateRangeFilter>,
              DateRangeFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

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

/// Filtered transaction list reacting to [ExpenseDateFilter].

@ProviderFor(filteredTransactions)
final filteredTransactionsProvider = FilteredTransactionsProvider._();

/// Filtered transaction list reacting to [ExpenseDateFilter].

final class FilteredTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Transaction>>,
          List<Transaction>,
          FutureOr<List<Transaction>>
        >
    with
        $FutureModifier<List<Transaction>>,
        $FutureProvider<List<Transaction>> {
  /// Filtered transaction list reacting to [ExpenseDateFilter].
  FilteredTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTransactionsHash();

  @$internal
  @override
  $FutureProviderElement<List<Transaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Transaction>> create(Ref ref) {
    return filteredTransactions(ref);
  }
}

String _$filteredTransactionsHash() =>
    r'7de753be1166f2520261787529892760063d1c24';

@ProviderFor(investmentSummary)
final investmentSummaryProvider = InvestmentSummaryProvider._();

final class InvestmentSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<InvestmentSummary>,
          InvestmentSummary,
          FutureOr<InvestmentSummary>
        >
    with
        $FutureModifier<InvestmentSummary>,
        $FutureProvider<InvestmentSummary> {
  InvestmentSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'investmentSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$investmentSummaryHash();

  @$internal
  @override
  $FutureProviderElement<InvestmentSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<InvestmentSummary> create(Ref ref) {
    return investmentSummary(ref);
  }
}

String _$investmentSummaryHash() => r'1666c1fe8637124cc74079b4066f98ca30035029';

@ProviderFor(expenseSummary)
final expenseSummaryProvider = ExpenseSummaryProvider._();

final class ExpenseSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExpenseSummary>,
          ExpenseSummary,
          FutureOr<ExpenseSummary>
        >
    with $FutureModifier<ExpenseSummary>, $FutureProvider<ExpenseSummary> {
  ExpenseSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseSummaryHash();

  @$internal
  @override
  $FutureProviderElement<ExpenseSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ExpenseSummary> create(Ref ref) {
    return expenseSummary(ref);
  }
}

String _$expenseSummaryHash() => r'8c9e1ea5a3c53a75e458de55cf08b2142c2d5bed';

/// Returns a map of category → normalised value (0.0–1.0) for the radar chart.

@ProviderFor(radarChartData)
final radarChartDataProvider = RadarChartDataProvider._();

/// Returns a map of category → normalised value (0.0–1.0) for the radar chart.

final class RadarChartDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<ExpenseCategory, double>>,
          Map<ExpenseCategory, double>,
          FutureOr<Map<ExpenseCategory, double>>
        >
    with
        $FutureModifier<Map<ExpenseCategory, double>>,
        $FutureProvider<Map<ExpenseCategory, double>> {
  /// Returns a map of category → normalised value (0.0–1.0) for the radar chart.
  RadarChartDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'radarChartDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$radarChartDataHash();

  @$internal
  @override
  $FutureProviderElement<Map<ExpenseCategory, double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<ExpenseCategory, double>> create(Ref ref) {
    return radarChartData(ref);
  }
}

String _$radarChartDataHash() => r'30074c91459c9a2ac1f87e660af383235bdd19ed';

/// Returns two lists of (offset, value) used to draw the trend lines.

@ProviderFor(trendData)
final trendDataProvider = TrendDataProvider._();

/// Returns two lists of (offset, value) used to draw the trend lines.

final class TrendDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<
            ({List<double> credits, List<double> debits, List<String> labels})
          >,
          ({List<double> credits, List<double> debits, List<String> labels}),
          FutureOr<
            ({List<double> credits, List<double> debits, List<String> labels})
          >
        >
    with
        $FutureModifier<
          ({List<double> credits, List<double> debits, List<String> labels})
        >,
        $FutureProvider<
          ({List<double> credits, List<double> debits, List<String> labels})
        > {
  /// Returns two lists of (offset, value) used to draw the trend lines.
  TrendDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendDataHash();

  @$internal
  @override
  $FutureProviderElement<
    ({List<double> credits, List<double> debits, List<String> labels})
  >
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({List<double> credits, List<double> debits, List<String> labels})>
  create(Ref ref) {
    return trendData(ref);
  }
}

String _$trendDataHash() => r'4ecbad0dc9bcf008e5afb8067ece7784673d9b5e';
