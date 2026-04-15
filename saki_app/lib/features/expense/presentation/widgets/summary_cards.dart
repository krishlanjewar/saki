import 'package:flutter/material.dart';
import '../../domain/models/investment_category.dart';

/// The yellow "Investment" banner card with category sticky-note chips.
class InvestmentSummaryCard extends StatelessWidget {
  const InvestmentSummaryCard({super.key, required this.summary});

  final InvestmentSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF176), // sticky-note yellow
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Investment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF33691E),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  '${_formatAmount(summary.totalBalance)} BALANCE',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF33691E),
                  ),
                ),
              ],
            ),
          ),
          // Chips row
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 6,
              children: summary.categories
                  .map((cat) => _StickyChip(category: cat))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(0)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }
}

/// The pink "Expenses" banner card with category sticky-note chips.
class ExpenseSummaryCard extends StatelessWidget {
  const ExpenseSummaryCard({super.key, required this.summary});

  final ExpenseSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF176),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Expenses',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF880E4F),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  '${_formatAmount(summary.totalBalance)}Balance',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF880E4F),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 6,
              children: summary.categories
                  .map(
                    (cat) => _StickyChip(
                      category: cat,
                      chipColor: const Color(0xFFF48FB1),
                      textColor: const Color(0xFF880E4F),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(0)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }
}

/// A sticky-note style chip for investment/expense sub-categories.
class _StickyChip extends StatelessWidget {
  const _StickyChip({
    required this.category,
    this.chipColor = const Color(0xFFA5D6A7),
    this.textColor = const Color(0xFF1B5E20),
  });

  final InvestmentCategory category;
  final Color chipColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Investment - ₹${category.amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          Text(
            category.label,
            style: TextStyle(
              fontSize: 9,
              color: textColor.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
