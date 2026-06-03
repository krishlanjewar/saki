import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/expense_repository.dart';
import '../../domain/models/transaction.dart';
import '../../../../shared/models/result.dart';
import '../providers/expense_provider.dart';
import '../widgets/transaction_tile.dart';

/// Full-screen list of all transactions with date-filter, swipe-to-delete,
/// and a FAB to add new transactions.
class AllTransactionsScreen extends ConsumerWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnsAsync = ref.watch(filteredTransactionsProvider);
    final filter = ref.watch(expenseDateFilterProvider);
    final formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'All Transactions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A1A),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        actions: [
          // Filter chip row inside the AppBar for quick date tweaking
          if (filter.from != null || filter.to != null)
            TextButton(
              onPressed: () =>
                  ref.read(expenseDateFilterProvider.notifier).clear(),
              child: const Text(
                'Clear filters',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4A148C),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // ── Active date-filter banner ────────────────────────────────────
          if (filter.from != null || filter.to != null)
            Container(
              width: double.infinity,
              color: const Color(0xFFEDE7F6),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                _buildFilterLabel(filter, formatter),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4A148C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // ── Transaction list ─────────────────────────────────────────────
          Expanded(
            child: txnsAsync.when(
              data: (txns) {
                if (txns.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            size: 56, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'No transactions found',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: txns.length,
                  itemBuilder: (context, index) {
                    return _SwipeToDeleteTile(transaction: txns[index]);
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Text(
                  'Error: $err',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildFilterLabel(DateRangeFilter filter, DateFormat fmt) {
    if (filter.from != null && filter.to != null) {
      return 'Showing ${fmt.format(filter.from!)} – ${fmt.format(filter.to!)}';
    } else if (filter.from != null) {
      return 'From ${fmt.format(filter.from!)}';
    } else {
      return 'Until ${fmt.format(filter.to!)}';
    }
  }
}

/// Wraps [TransactionTile] with a swipe-to-delete action using [Dismissible].
class _SwipeToDeleteTile extends ConsumerWidget {
  const _SwipeToDeleteTile({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: const Color(0xFFB71C1C),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 26),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete transaction?'),
            content: Text(
              'Remove "${transaction.description}" from your records?',
              style: const TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFB71C1C),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) async {
        final result = await ref
            .read(expenseRepositoryProvider)
            .deleteTransaction(transaction.id);
        result.when(
          success: (_) {
            ref.invalidate(filteredTransactionsProvider);
            ref.invalidate(trendDataProvider);
            ref.invalidate(investmentSummaryProvider);
            ref.invalidate(expenseSummaryProvider);
            ref.invalidate(radarChartDataProvider);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Transaction deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          failure: (error) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Could not delete: $error'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        );
      },
      child: TransactionTile(transaction: transaction),
    );
  }
}
