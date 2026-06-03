import 'package:flutter/material.dart';

/// Gradient Balance Card shown at the top of the expense screen.
/// Displays net balance (income − expenses) plus investment and expense totals.
class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalInvestment,
  });

  final double totalIncome;
  final double totalExpenses;
  final double totalInvestment;

  double get _netBalance => totalIncome - totalExpenses;

  @override
  Widget build(BuildContext context) {
    final isPositive = _netBalance >= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPositive
              ? [const Color(0xFF1B5E20), const Color(0xFF388E3C)]
              : [const Color(0xFF880E4F), const Color(0xFFC2185B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (isPositive
                    ? const Color(0xFF1B5E20)
                    : const Color(0xFF880E4F))
                .withAlpha(60),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Net balance label ──────────────────────────────────────────
          const Text(
            'Current Balance',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _formatCurrency(_netBalance),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),

          // ── Divider ─────────────────────────────────────────────────────
          Container(
            height: 0.8,
            color: Colors.white24,
          ),
          const SizedBox(height: 14),

          // ── Sub-totals row ───────────────────────────────────────────────
          Row(
            children: [
              _SubTotal(
                icon: Icons.trending_up_rounded,
                label: 'Investments',
                amount: totalInvestment,
                color: const Color(0xFFA5D6A7),
              ),
              const SizedBox(width: 16),
              _SubTotal(
                icon: Icons.trending_down_rounded,
                label: 'Expenses',
                amount: totalExpenses,
                color: const Color(0xFFF48FB1),
              ),
              const SizedBox(width: 16),
              _SubTotal(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Income',
                amount: totalIncome,
                color: const Color(0xFF80CBC4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    final prefix = value < 0 ? '-₹' : '₹';
    final abs = value.abs();
    if (abs >= 100000) {
      return '$prefix${(abs / 100000).toStringAsFixed(1)}L';
    }
    if (abs >= 1000) {
      return '$prefix${(abs / 1000).toStringAsFixed(1)}K';
    }
    return '$prefix${abs.toStringAsFixed(0)}';
  }
}

class _SubTotal extends StatelessWidget {
  const _SubTotal({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
  });

  final IconData icon;
  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _format(amount),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String _format(double v) {
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }
}
