import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../domain/models/journal_entry.dart';
import '../../domain/models/journal_stats.dart';
import '../widgets/github_streak_chart.dart';
import '../../../../shared/widgets/saki_scaffold.dart';

import '../providers/journal_providers.dart';

class JournalDashboardScreen extends ConsumerStatefulWidget {
  const JournalDashboardScreen({super.key});

  @override
  ConsumerState<JournalDashboardScreen> createState() => _JournalDashboardScreenState();
}

class _JournalDashboardScreenState extends ConsumerState<JournalDashboardScreen> {
  bool _isAuthenticated = true;
//  = false ;
  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    final didAuth = await ref.read(localAuthProvider.notifier).authenticate();
    if (didAuth && mounted) {
      setState(() {
        _isAuthenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return SakiScaffold(
        title: 'Journal',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Journal is locked'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Unlock'),
              )
            ],
          ),
        ),
      );
    }

    final entriesAsync = ref.watch(journalEntriesProvider);
    final stats = ref.watch(journalStatsProvider);

    return SakiScaffold(
      title: 'Journal',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/journal/new'),
        icon: const Icon(Icons.edit),
        label: const Text('New Entry'),
      ),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (entries) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatsRow(stats),
                      const SizedBox(height: 24),
                      const Text('Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      GithubStreakChart(entries: entries),
                      const SizedBox(height: 24),
                      if (entries.isNotEmpty) ...[
                        const Text('Mood Trends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 200,
                          child: _buildMoodChart(entries),
                        ),
                        const SizedBox(height: 24),
                      ],
                      const Text('Recent Entries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              if (entries.isEmpty)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No entries yet. Start writing!'),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entry = entries.reversed.toList()[index];
                      return _buildEntryCard(context, entry);
                    },
                    childCount: entries.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 80)), // Space for FAB
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsRow(JournalStats stats) {
    return Row(
      children: [
        _buildStatCard('Streak', '${stats.currentStreak} Days', Icons.local_fire_department, Colors.orange),
        const SizedBox(width: 16),
        _buildStatCard('Entries', '${stats.totalEntries}', Icons.book, Colors.blue),
        const SizedBox(width: 16),
        _buildStatCard('Words', '${stats.totalWords}', Icons.text_snippet, Colors.green),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodChart(List<JournalEntry> entries) {
    // Simple mock of mood mapping to Y-axis for fl_chart
    // 0 = sad, 1 = stressed, 2 = calm, 3 = happy, 4 = excited
    Map<Mood, double> moodValues = {
      Mood.sad: 0,
      Mood.stressed: 1,
      Mood.calm: 2,
      Mood.happy: 3,
      Mood.excited: 4,
    };

    final recentEntries = entries.toList()..sort((a, b) => a.date.compareTo(b.date));
    final displayEntries = recentEntries.length > 7 ? recentEntries.sublist(recentEntries.length - 7) : recentEntries;

    List<FlSpot> spots = [];
    for (int i = 0; i < displayEntries.length; i++) {
      spots.add(FlSpot(i.toDouble(), moodValues[displayEntries[i].mood]!));
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryCard(BuildContext context, JournalEntry entry) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          entry.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(DateFormat.MMMd().format(entry.date)),
        onTap: () => context.push('/journal/entry/${entry.id}'),
      ),
    );
  }
}
