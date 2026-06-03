import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../shared/widgets/saki_scaffold.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_trend_chart.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/summary_cards.dart';
import '../widgets/radar_chart_widget.dart';
import '../widgets/balance_card.dart';
import '../widgets/add_transaction_dialog.dart';
import 'all_transactions_screen.dart';

class ExpenseScreen extends ConsumerWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnsAsync = ref.watch(filteredTransactionsProvider);
    final trendAsync = ref.watch(trendDataProvider);
    final investAsync = ref.watch(investmentSummaryProvider);
    final expenseCardAsync = ref.watch(expenseSummaryProvider);
    final radarAsync = ref.watch(radarChartDataProvider);
    final filter = ref.watch(expenseDateFilterProvider);

    return SakiScaffold(
      title: 'expense',
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. Balance Card derived from investment + expense summaries
              SliverToBoxAdapter(
                child: _BalanceCardSection(
                  investAsync: investAsync,
                  expenseAsync: expenseCardAsync,
                  txnsAsync: txnsAsync,
                ),
              ),

              // 2. Trend Line Chart
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
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
                    error: (e, _) => const SizedBox(
                      height: 140,
                      child: Center(child: Text('Failed to load chart')),
                    ),
                  ),
                ),
              ),

              // 3. Date range filter row (below chart)
              SliverToBoxAdapter(
                child: _DateRangeRow(filter: filter, ref: ref),
              ),

              // 4. Section header: Recent Transactions
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: 0.3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AllTransactionsScreen(),
                          ),
                        ),
                        child: const Text(
                          'View All →',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A148C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 5. Latest 3 transactions
              txnsAsync.when(
                data: (txns) {
                  final latest = txns.take(3).toList();
                  if (latest.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: Text(
                            'No transactions yet. Add one below!',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          final isFirst = index == 0;
                          final isLast = index == latest.length - 1;
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: const BorderSide(
                                    color: Color(0xFFE0E0E0)),
                                right: const BorderSide(
                                    color: Color(0xFFE0E0E0)),
                                top: isFirst
                                    ? const BorderSide(
                                        color: Color(0xFFE0E0E0))
                                    : BorderSide.none,
                                bottom: isLast
                                    ? const BorderSide(
                                        color: Color(0xFFE0E0E0))
                                    : BorderSide.none,
                              ),
                            ),
                            child: TransactionTile(
                                transaction: latest[index]),
                          );
                        },
                        childCount: latest.length,
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
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                        child: Text('Error: $err',
                            style:
                                const TextStyle(color: Colors.red))),
                  ),
                ),
              ),

              // 6. Investment Summary Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: investAsync.when(
                    data: (s) => InvestmentSummaryCard(summary: s),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) =>
                        Center(child: Text('Error: $e')),
                  ),
                ),
              ),

              // 7. Expense Summary Card
              SliverToBoxAdapter(
                child: expenseCardAsync.when(
                  data: (s) => ExpenseSummaryCard(summary: s),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) =>
                      Center(child: Text('Error: $e')),
                ),
              ),

              // 8. Radar Chart
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
                      child: Center(
                          child: Text('Failed to load chart')),
                    ),
                  ),
                ),
              ),

              // Bottom padding for the FABs
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // ── Dual FABs pinned to bottom-right ─────────────────────────────
          Positioned(
            bottom: 24,
            right: 20,
            child: _DualFab(),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Balance Card Section (derives income from credit transactions)
// ─────────────────────────────────────────────────────────────────────────────

class _BalanceCardSection extends StatelessWidget {
  const _BalanceCardSection({
    required this.investAsync,
    required this.expenseAsync,
    required this.txnsAsync,
  });

  final AsyncValue investAsync;
  final AsyncValue expenseAsync;
  final AsyncValue txnsAsync;

  @override
  Widget build(BuildContext context) {
    // We derive income from the raw transaction list
    final income = txnsAsync.whenData((txns) =>
        txns.where((t) => t.isCredit).fold<double>(0, (s, t) => s + t.amount));

    final investTotal = investAsync.whenData((s) => s.totalBalance);
    final expenseTotal = expenseAsync.whenData((s) => s.totalBalance);

    if (income.hasError || investTotal.hasError || expenseTotal.hasError) {
      return const SizedBox.shrink();
    }
    if (income.isLoading || investTotal.isLoading || expenseTotal.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return BalanceCard(
      totalIncome: income.value ?? 0,
      totalExpenses: expenseTotal.value ?? 0,
      totalInvestment: investTotal.value ?? 0,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Date Range Row (below trend chart)
// ─────────────────────────────────────────────────────────────────────────────

class _DateRangeRow extends StatelessWidget {
  const _DateRangeRow({required this.filter, required this.ref});

  final DateRangeFilter filter;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        children: [
          _DateChip(
            label: filter.from != null
                ? 'From: ${formatter.format(filter.from!)}'
                : 'From: date',
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: filter.from ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                ref.read(expenseDateFilterProvider.notifier).setFrom(date);
              }
            },
          ),
          const SizedBox(width: 8),
          _DateChip(
            label: filter.to != null
                ? 'To: ${formatter.format(filter.to!)}'
                : 'To: date',
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: filter.to ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                ref.read(expenseDateFilterProvider.notifier).setTo(date);
              }
            },
          ),
          if (filter.from != null || filter.to != null) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: () =>
                  ref.read(expenseDateFilterProvider.notifier).clear(),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCDD2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '✕ Clear',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE1BEE7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A148C),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dual FABs: Add Expense & Add Investment
// ─────────────────────────────────────────────────────────────────────────────

class _DualFab extends StatefulWidget {
  @override
  State<_DualFab> createState() => _DualFabState();
}

class _DualFabState extends State<_DualFab>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _openDialog(BuildContext context, bool isInvestment) {
    _toggle();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTransactionDialog(isInvestment: isInvestment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // ── Investment FAB (appears when expanded) ─────────────────────────
        ScaleTransition(
          scale: _scaleAnimation,
          child: _MiniChipFab(
            label: 'Add Investment',
            icon: Icons.trending_up_rounded,
            color: const Color(0xFF2E7D32),
            onTap: () => _openDialog(context, true),
          ),
        ),
        const SizedBox(height: 10),

        // ── Expense FAB (appears when expanded) ────────────────────────────
        ScaleTransition(
          scale: _scaleAnimation,
          child: _MiniChipFab(
            label: 'Add Expense',
            icon: Icons.remove_circle_outline,
            color: const Color(0xFF880E4F),
            onTap: () => _openDialog(context, false),
          ),
        ),
        const SizedBox(height: 10),

        // ── Main toggle FAB ────────────────────────────────────────────────
        FloatingActionButton(
          heroTag: 'main_fab',
          onPressed: _toggle,
          backgroundColor: const Color(0xFF4A148C),
          child: AnimatedRotation(
            turns: _isExpanded ? 0.125 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }
}

class _MiniChipFab extends StatelessWidget {
  const _MiniChipFab({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(80),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
