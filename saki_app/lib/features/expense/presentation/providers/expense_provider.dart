import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/expense.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/investment_category.dart';
import '../../data/expense_repository.dart';

part 'expense_provider.g.dart';

// ---------------------------------------------------------------------------
// Date-range filter state
// ---------------------------------------------------------------------------

/// Holds the from/to date filter applied to the transaction list.
@freezed
class DateRangeFilter with _$DateRangeFilter {
  const factory DateRangeFilter({
    DateTime? from,
    DateTime? to,
  }) = _DateRangeFilter;
}

@riverpod
class ExpenseDateFilter extends _$ExpenseDateFilter {
  @override
  DateRangeFilter build() => const DateRangeFilter();

  void setFrom(DateTime? date) => state = state.copyWith(from: date);
  void setTo(DateTime? date) => state = state.copyWith(to: date);
  void clear() => state = const DateRangeFilter();
}

// ---------------------------------------------------------------------------
// Transaction list provider
// ---------------------------------------------------------------------------

@riverpod
class ExpenseList extends _$ExpenseList {
  @override
  FutureOr<List<Expense>> build() async {
    final repo = ref.watch(expenseRepositoryProvider);
    final result = await repo.getExpenses();
    return result.when(
      success: (expenses) => expenses,
      failure: (error) => throw Exception(error),
    );
  }
}

/// Filtered transaction list reacting to [ExpenseDateFilter].
@riverpod
Future<List<Transaction>> filteredTransactions(Ref ref) async {
  final repo = ref.watch(expenseRepositoryProvider);
  final filter = ref.watch(expenseDateFilterProvider);
  final result = await repo.getTransactions(from: filter.from, to: filter.to);
  return result.when(
    success: (txns) => txns,
    failure: (error) => throw Exception(error),
  );
}

// ---------------------------------------------------------------------------
// Investment & Expense summary providers
// ---------------------------------------------------------------------------

@riverpod
Future<InvestmentSummary> investmentSummary(Ref ref) async {
  final repo = ref.watch(expenseRepositoryProvider);
  final result = await repo.getInvestmentSummary();
  return result.when(
    success: (summary) => summary,
    failure: (error) => throw Exception(error),
  );
}

@riverpod
Future<ExpenseSummary> expenseSummary(Ref ref) async {
  final repo = ref.watch(expenseRepositoryProvider);
  final result = await repo.getExpenseSummary();
  return result.when(
    success: (summary) => summary,
    failure: (error) => throw Exception(error),
  );
}

// ---------------------------------------------------------------------------
// Radar chart data: spending per ExpenseCategory
// ---------------------------------------------------------------------------

/// Returns a map of category → normalised value (0.0–1.0) for the radar chart.
@riverpod
Future<Map<ExpenseCategory, double>> radarChartData(Ref ref) async {
  final txnAsync = await ref.watch(filteredTransactionsProvider.future);
  final debitTxns = txnAsync.where((t) => !t.isCredit).toList();

  final totals = <ExpenseCategory, double>{
    for (final cat in ExpenseCategory.values) cat: 0.0,
  };
  for (final txn in debitTxns) {
    totals[txn.category] = (totals[txn.category] ?? 0) + txn.amount;
  }

  final maxValue = totals.values.reduce((a, b) => a > b ? a : b);
  if (maxValue == 0) return totals;

  return totals.map((cat, value) => MapEntry(cat, value / maxValue));
}

// ---------------------------------------------------------------------------
// Trend line data: daily aggregated credit vs debit for the chart
// ---------------------------------------------------------------------------

/// Returns two lists of (offset, value) used to draw the trend lines.
@riverpod
Future<({List<double> debits, List<double> credits, List<String> labels})>
    trendData(Ref ref) async {
  final txns = await ref.watch(filteredTransactionsProvider.future);
  if (txns.isEmpty) {
    return (debits: [], credits: [], labels: []);
  }

  // Group by date (keep only the last 10 unique dates).
  final grouped = <DateTime, ({double debit, double credit})>{};
  for (final txn in txns) {
    final day = DateTime(txn.date.year, txn.date.month, txn.date.day);
    final current = grouped[day] ?? (debit: 0.0, credit: 0.0);
    grouped[day] = txn.isCredit
        ? (debit: current.debit, credit: current.credit + txn.amount)
        : (debit: current.debit + txn.amount, credit: current.credit);
  }

  final sortedDays = grouped.keys.toList()..sort();
  final last = sortedDays.length > 10
      ? sortedDays.sublist(sortedDays.length - 10)
      : sortedDays;

  final debits = last.map((d) => grouped[d]!.debit).toList();
  final credits = last.map((d) => grouped[d]!.credit).toList();
  final labels = last.map((d) => '${d.day}/${d.month}').toList();

  return (debits: debits, credits: credits, labels: labels);
}
