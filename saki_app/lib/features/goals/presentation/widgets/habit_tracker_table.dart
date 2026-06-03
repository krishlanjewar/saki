import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/habit.dart';
import '../providers/goals_provider.dart';

/// A weekly habits tracker table with navigation arrows.
/// Rows = habits, Columns = Mon–Sun of the selected week.
class HabitTrackerTable extends ConsumerWidget {
  const HabitTrackerTable({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final weekOffset  = ref.watch(habitWeekOffsetProvider);

    // Calculate the Mon of the displayed week
    final now = DateTime.now();
    final thisMonday = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    final weekStart = thisMonday.add(Duration(days: 7 * weekOffset));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section header + week navigator ─────────────────────────────
          Row(
            children: [
              const Text('📋', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Habit Tracker',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              _WeekNavButton(
                icon: Icons.chevron_left,
                onTap: () => ref.read(habitWeekOffsetProvider.notifier).goBack(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  _weekLabel(weekStart),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFA0A0A0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _WeekNavButton(
                icon: Icons.chevron_right,
                onTap: weekOffset >= 0
                    ? null // Can't navigate to the future
                    : () => ref.read(habitWeekOffsetProvider.notifier).goForward(),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Table ────────────────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2E2E42)),
            ),
            child: Column(
              children: [
                // Header row
                _TableHeaderRow(weekStart: weekStart),
                const Divider(height: 1, color: Color(0xFF2E2E42)),

                // Habit rows
                habitsAsync.when(
                  data: (habits) {
                    if (habits.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            'No habits yet. Add one!',
                            style: TextStyle(color: Color(0xFF666680)),
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: habits.asMap().entries.map((entry) {
                        final isLast = entry.key == habits.length - 1;
                        return _HabitRow(
                          habit: entry.value,
                          weekStart: weekStart,
                          isLast: isLast,
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Error: $e'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Add Habit button ─────────────────────────────────────────────
          _AddHabitButton(),
        ],
      ),
    );
  }

  String _weekLabel(DateTime monday) {
    final sunday = monday.add(const Duration(days: 6));
    if (monday.month == sunday.month) {
      return '${_monthAbbr(monday.month)} ${monday.day}–${sunday.day}';
    }
    return '${_monthAbbr(monday.month)} ${monday.day} – ${_monthAbbr(sunday.month)} ${sunday.day}';
  }

  String _monthAbbr(int m) =>
      const ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
             'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m];
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _WeekNavButton extends StatelessWidget {
  const _WeekNavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 20,
          color: onTap == null ? const Color(0xFF3E3E58) : const Color(0xFF9C88FF),
        ),
      ),
    );
  }
}

class _TableHeaderRow extends StatelessWidget {
  const _TableHeaderRow({required this.weekStart});

  final DateTime weekStart;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 110), // habit name column
          ...List.generate(7, (i) {
            final day = weekStart.add(Duration(days: i));
            final isToday = day.year == now.year &&
                day.month == now.month &&
                day.day == now.day;
            return Expanded(
              child: Column(
                children: [
                  Text(
                    ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isToday
                          ? const Color(0xFF9C88FF)
                          : const Color(0xFF666680),
                    ),
                  ),
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 9,
                      color: isToday
                          ? const Color(0xFF9C88FF)
                          : const Color(0xFF444460),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _HabitRow extends ConsumerWidget {
  const _HabitRow({
    required this.habit,
    required this.weekStart,
    required this.isLast,
  });

  final Habit habit;
  final DateTime weekStart;
  final bool isLast;

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF6C63FF);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitColor = _parseColor(habit.colorHex);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              // Habit name + streak
              SizedBox(
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.name,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (habit.currentStreak > 0)
                        Text(
                          '🔥 ${habit.currentStreak}d',
                          style: TextStyle(
                            fontSize: 9,
                            color: habitColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Day cells
              ...List.generate(7, (i) {
                final day = weekStart.add(Duration(days: i));
                final isDone = habit.isCompletedOn(day);
                final isFuture = day.isAfter(DateTime.now());

                return Expanded(
                  child: GestureDetector(
                    onTap: isFuture
                        ? null
                        : () => ref
                            .read(habitsProvider.notifier)
                            .toggleCompletion(habit.id, day),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, anim) => ScaleTransition(
                        scale: anim,
                        child: child,
                      ),
                      child: Container(
                        key: ValueKey('${habit.id}_${day.toIso8601String()}_$isDone'),
                        margin: const EdgeInsets.all(3),
                        height: 28,
                        decoration: BoxDecoration(
                          color: isFuture
                              ? const Color(0xFF1A1A2E)
                              : isDone
                                  ? habitColor.withAlpha(200)
                                  : const Color(0xFF2A2A3E),
                          borderRadius: BorderRadius.circular(6),
                          border: isDone
                              ? Border.all(color: habitColor, width: 1)
                              : null,
                        ),
                        child: Center(
                          child: isFuture
                              ? null
                              : Text(
                                  isDone ? '✓' : '·',
                                  style: TextStyle(
                                    fontSize: isDone ? 14 : 18,
                                    color: isDone
                                        ? Colors.white
                                        : const Color(0xFF3E3E58),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, indent: 10, endIndent: 10, color: Color(0xFF2E2E42)),
      ],
    );
  }
}

class _AddHabitButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showAddHabitDialog(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A42),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF6C63FF), width: 1),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Color(0xFF9C88FF), size: 16),
            SizedBox(width: 6),
            Text(
              'Add Habit',
              style: TextStyle(
                color: Color(0xFF9C88FF),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddHabitDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    String selectedColor = '#42A5F5';
    final colors = [
      '#42A5F5', '#66BB6A', '#FFA726', '#AB47BC',
      '#EF5350', '#26C6DA', '#FF7043', '#9CCC65',
    ];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E2E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            left: 20, right: 20, top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Add Habit', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white,
              )),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Habit name (e.g. Drink Water)'),
              ),
              const SizedBox(height: 16),
              const Text('Color', style: TextStyle(
                fontSize: 12, color: Color(0xFFA0A0A0), fontWeight: FontWeight.w600,
              )),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: colors.map((hex) {
                  final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
                  final isSelected = hex == selectedColor;
                  return GestureDetector(
                    onTap: () => setState(() => selectedColor = hex),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: Colors.white, width: 2.5) : null,
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;
                    await ref.read(habitsProvider.notifier).addHabit(
                      Habit(
                        id: 'h_${DateTime.now().millisecondsSinceEpoch}',
                        name: name,
                        colorHex: selectedColor,
                      ),
                    );
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Add Habit', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFF666680)),
    filled: true,
    fillColor: const Color(0xFF2A2A3E),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF3E3E58)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF3E3E58)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5),
    ),
  );
}
