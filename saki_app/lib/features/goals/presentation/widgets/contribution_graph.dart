import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/goals_provider.dart';

/// A GitHub-style contribution heatmap showing 12 weeks of task completions.
/// Color intensity = number of tasks completed that day.
class ContributionGraph extends ConsumerWidget {
  const ContributionGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(contributionDataProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Contribution Graph', emoji: '🌿'),
          const SizedBox(height: 12),
          dataAsync.when(
            data: (data) => _HeatmapGrid(data: data),
            loading: () => const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}

class _HeatmapGrid extends StatelessWidget {
  const _HeatmapGrid({required this.data});

  final Map<DateTime, int> data;

  // 12 weeks × 7 days
  static const int _weeks = 12;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Start from the Monday of the week 12 weeks ago
    final todayWeekday = now.weekday; // 1=Mon, 7=Sun
    final weekStart = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: todayWeekday - 1 + (_weeks - 1) * 7));

    final maxCount = data.values.isEmpty
        ? 1
        : math.max(1, data.values.reduce(math.max));

    // Build column per week
    final weekColumns = List.generate(_weeks, (weekIndex) {
      return Column(
        children: List.generate(7, (dayIndex) {
          final day = weekStart.add(
            Duration(days: weekIndex * 7 + dayIndex),
          );
          // Don't show future cells
          final isFuture = day.isAfter(now);
          final count = isFuture ? 0 : (data[DateTime(day.year, day.month, day.day)] ?? 0);
          return _HeatCell(
            count: count,
            maxCount: maxCount,
            isFuture: isFuture,
            day: day,
          );
        }),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Week day labels
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Y-axis labels
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Column(
                children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                    .map(
                      (d) => SizedBox(
                        height: 14,
                        child: Text(
                          d,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF666680),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            // Grid
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true, // Show most recent on the right
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: weekColumns,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Less ',
              style: TextStyle(fontSize: 9, color: Color(0xFF666680)),
            ),
            for (int i = 0; i <= 4; i++)
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: _cellColor(i, 4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            const Text(
              ' More',
              style: TextStyle(fontSize: 9, color: Color(0xFF666680)),
            ),
          ],
        ),
      ],
    );
  }

  static Color _cellColor(int count, int max) {
    if (count == 0) return const Color(0xFF2A2A3E);
    final intensity = (count / max).clamp(0.0, 1.0);
    // Interpolate from light green to deep green
    final r = (40  + (0   - 40)  * intensity).round();
    final g = (100 + (180 - 100) * intensity).round();
    final b = (40  + (50  - 40)  * intensity).round();
    return Color.fromARGB(255, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255));
  }
}

class _HeatCell extends StatelessWidget {
  const _HeatCell({
    required this.count,
    required this.maxCount,
    required this.isFuture,
    required this.day,
  });

  final int count;
  final int maxCount;
  final bool isFuture;
  final DateTime day;

  Color get _color {
    if (isFuture) return const Color(0xFF1A1A2E);
    if (count == 0) return const Color(0xFF2A2A3E);
    final intensity = (count / maxCount).clamp(0.0, 1.0);
    final r = (40  + (0   - 40)  * intensity).round();
    final g = (100 + (180 - 100) * intensity).round();
    final b = (40  + (50  - 40)  * intensity).round();
    return Color.fromARGB(255, r.clamp(0, 255), g.clamp(0, 255), b.clamp(0, 255));
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isFuture
          ? ''
          : '${DateFormat('MMM d').format(day)}: $count task${count == 1 ? '' : 's'}',
      child: Container(
        width: 12,
        height: 12,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

/// Reusable section header for the Goals screen.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.emoji});

  final String title;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFFFFFFFF),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
