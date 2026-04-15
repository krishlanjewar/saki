import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/saki_scaffold.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_filter_bar.dart';
import '../widgets/expense_trend_chart.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/summary_cards.dart';
import '../widgets/radar_chart_widget.dart';

class ExpenseScreen extends ConsumerWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch main data providers
    final txnsAsync = ref.watch(filteredTransactionsProvider);
    final trendAsync = ref.watch(trendDataProvider);
    final investAsync = ref.watch(investmentSummaryProvider);
    final expenseCardAsync = ref.watch(expenseSummaryProvider);
    final radarAsync = ref.watch(radarChartDataProvider);

    return SakiScaffold(
      title: 'expense',
      // We use a CustomScrollView because there are many disjoint scrollable and static regions
      body: CustomScrollView(
        slivers: [
          // 1. Top filter bar
          const SliverToBoxAdapter(
            child: ExpenseFilterBar(),
          ),

          // 2. Trend Line Chart
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: trendAsync.when(
                data: (data) => ExpenseTrendChart(
                  debitSeries: data.debits,
                  creditSeries: data.credits,
                  labels: data.labels,
                ),
                loading: () => const SizedBox(
                  height: 140,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, _) => const SizedBox(
                  height: 140,
                  child: Center(child: Text('Failed to load chart')),
                ),
              ),
            ),
          ),

          // 3. Transactions List Header (Divider)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
            ),
          ),

          // 4. Transactions List Space
          txnsAsync.when(
            data: (txns) {
              if (txns.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: Text('No transactions found.')),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Add an outer border to the whole list to match design
                      final isFirst = index == 0;
                      final isLast = index == txns.length - 1;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: const BorderSide(color: Color(0xFFE0E0E0)),
                            right: const BorderSide(color: Color(0xFFE0E0E0)),
                            top: isFirst
                                ? const BorderSide(color: Color(0xFFE0E0E0))
                                : BorderSide.none,
                            bottom: isLast
                                ? const BorderSide(color: Color(0xFFE0E0E0))
                                : BorderSide.none,
                          ),
                        ),
                        child: TransactionTile(transaction: txns[index]),
                      );
                    },
                    childCount: txns.length,
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (err, _) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(child: Text('Error loading tranasctions: $err')),
              ),
            ),
          ),

          // 5. Investment Summary Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 4.0, right: 4.0),
              child: investAsync.when(
                data: (summary) => InvestmentSummaryCard(summary: summary),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ),

          // 6. Expense Summary Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: expenseCardAsync.when(
                data: (summary) => ExpenseSummaryCard(summary: summary),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ),

          // 7. Radar Chart
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: radarAsync.when(
                data: (values) => RadarChart(values: values),
                loading: () => const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => const SizedBox(
                  height: 220,
                  child: Center(child: Text('Failed to load chart')),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
