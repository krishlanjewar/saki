import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/goals_provider.dart';

/// Shows current streak, longest streak, and weekly completion percentage.
class StreakCard extends ConsumerWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(currentStreakProvider);
    final weeklyAsync = ref.watch(weeklyCompletionRateProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2E2E42), width: 1),
      ),
      child: Row(
        children: [
          // ── Streak counter ─────────────────────────────────────────────
          Expanded(
            child: _StatCell(
              icon: '🔥',
              label: 'Current Streak',
              value: streakAsync.when(
                data: (s) => '$s day${s == 1 ? '' : 's'}',
                loading: () => '…',
                error: (_, _) => '0 days',
              ),
              valueColor: const Color(0xFFFF6B35),
            ),
          ),
          Container(width: 1, height: 50, color: const Color(0xFF2E2E42)),
          // ── Weekly rate ────────────────────────────────────────────────
          Expanded(
            child: weeklyAsync.when(
              data: (rate) => _WeeklyRateCell(rate: rate),
              loading: () => const _StatCell(
                icon: '📊',
                label: 'This Week',
                value: '…',
                valueColor: Color(0xFF66BB6A),
              ),
              error: (_, _) => const _StatCell(
                icon: '📊',
                label: 'This Week',
                value: '0%',
                valueColor: Color(0xFF66BB6A),
              ),
            ),
          ),
          Container(width: 1, height: 50, color: const Color(0xFF2E2E42)),
          // ── Best day ────────────────────────────────────────────────────
          Expanded(
            child: ref.watch(contributionDataProvider).when(
              data: (data) {
                final maxCount = data.values.isEmpty
                    ? 0
                    : data.values.reduce((a, b) => a > b ? a : b);
                return _StatCell(
                  icon: '⭐',
                  label: 'Best Day',
                  value: '$maxCount tasks',
                  valueColor: const Color(0xFFFFD700),
                );
              },
              loading: () => const _StatCell(
                icon: '⭐',
                label: 'Best Day',
                value: '…',
                valueColor: Color(0xFFFFD700),
              ),
              error: (_, _) => const _StatCell(
                icon: '⭐',
                label: 'Best Day',
                value: '0',
                valueColor: Color(0xFFFFD700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String icon;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFFA0A0A0),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _WeeklyRateCell extends StatelessWidget {
  const _WeeklyRateCell({required this.rate});

  final double rate;

  @override
  Widget build(BuildContext context) {
    final percent = (rate * 100).round();
    final color = percent >= 80
        ? const Color(0xFF66BB6A)
        : percent >= 50
            ? const Color(0xFFFFB74D)
            : const Color(0xFFEF5350);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📊', style: TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            '$percent%',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'This Week',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFFA0A0A0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
