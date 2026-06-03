import 'package:flutter/material.dart';
import '../../../../shared/widgets/saki_scaffold.dart';
import '../widgets/motivational_banner.dart';
import '../widgets/streak_card.dart';
import '../widgets/contribution_graph.dart';
import '../widgets/habit_tracker_table.dart';
import '../widgets/daily_tasks_section.dart';
import '../widgets/today_tasks_section.dart';
import '../widgets/reminders_section.dart';

/// The main Goals screen composing all sections in a scrollable layout.
class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SakiScaffold(
      title: 'goals',
      body: CustomScrollView(
        slivers: [
          // ── 1. Daily motivational quote ────────────────────────────────
          const SliverToBoxAdapter(child: MotivationalBanner()),

          // ── 2. Streak + weekly summary card ───────────────────────────
          const SliverToBoxAdapter(child: StreakCard()),

          // ── 3. Contribution graph (GitHub heatmap) ────────────────────
          const SliverToBoxAdapter(child: ContributionGraph()),

          // ── Divider ───────────────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionDivider()),

          // ── 4. Habit tracker table ────────────────────────────────────
          const SliverToBoxAdapter(child: HabitTrackerTable()),

          // ── Divider ───────────────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionDivider()),

          // ── 5. Daily tasks ────────────────────────────────────────────
          const SliverToBoxAdapter(child: DailyTasksSection()),

          // ── Divider ───────────────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionDivider()),

          // ── 6. Today's tasks ──────────────────────────────────────────
          const SliverToBoxAdapter(child: TodayTasksSection()),

          // ── Divider ───────────────────────────────────────────────────
          SliverToBoxAdapter(child: _SectionDivider()),

          // ── 7. Reminders ──────────────────────────────────────────────
          const SliverToBoxAdapter(child: RemindersSection()),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Divider(color: Color(0xFF2E2E42), thickness: 1, height: 1),
    );
  }
}
