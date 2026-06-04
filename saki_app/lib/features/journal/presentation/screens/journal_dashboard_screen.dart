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
import '../widgets/pin_entry_widget.dart';
import '../widgets/mood_tracking_chart.dart';
import '../../data/services/journal_auth_service.dart';
import '../widgets/journal_search_delegate.dart';
class JournalDashboardScreen extends ConsumerStatefulWidget {
  const JournalDashboardScreen({super.key});

  @override
  ConsumerState<JournalDashboardScreen> createState() => _JournalDashboardScreenState();
}

class _JournalDashboardScreenState extends ConsumerState<JournalDashboardScreen> {
  bool _isAuthenticated = false;
  bool _showPinSetup = false;
  bool _showPinUnlock = false;
  String? _pinError;
  String? _setupPinFirstEntry;

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

  Future<void> _handlePinComplete(String pin) async {
    final hasPin = ref.read(hasPinSetProvider).value ?? false;
    final authService = ref.read(journalAuthServiceProvider);

    if (!hasPin) {
      if (_setupPinFirstEntry == null) {
        setState(() {
          _setupPinFirstEntry = pin;
          _pinError = null;
        });
      } else {
        if (_setupPinFirstEntry == pin) {
          await authService.setPin(pin);
          ref.invalidate(hasPinSetProvider);
          setState(() {
            _isAuthenticated = true;
            _setupPinFirstEntry = null;
            _showPinSetup = false;
          });
          ref.read(localAuthProvider.notifier).unlockWithPin();
        } else {
          setState(() {
            _pinError = 'PINs do not match. Try again.';
            _setupPinFirstEntry = null;
          });
        }
      }
    } else {
      final isValid = await authService.verifyPin(pin);
      if (isValid) {
        setState(() {
          _isAuthenticated = true;
          _showPinUnlock = false;
          _pinError = null;
        });
        ref.read(localAuthProvider.notifier).unlockWithPin();
      } else {
        setState(() {
          _pinError = 'Incorrect PIN';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      final hasPinAsync = ref.watch(hasPinSetProvider);

      return SakiScaffold(
        title: 'Journal',
        body: Center(
          child: hasPinAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            data: (hasPin) {
              if (_showPinSetup) {
                return PinEntryWidget(
                  title: _setupPinFirstEntry == null ? 'Set up Journal PIN' : 'Confirm Journal PIN',
                  subtitle: _setupPinFirstEntry == null ? 'Create a 4-digit PIN' : 'Re-enter your PIN',
                  errorText: _pinError,
                  onComplete: _handlePinComplete,
                );
              }

              if (_showPinUnlock) {
                return PinEntryWidget(
                  title: 'Unlock Journal',
                  subtitle: 'Enter your 4-digit PIN',
                  errorText: _pinError,
                  onComplete: _handlePinComplete,
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Journal is locked', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.fingerprint),
                    onPressed: _authenticate,
                    label: const Text('Unlock with Biometrics'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (hasPin) {
                          _showPinUnlock = true;
                        } else {
                          _showPinSetup = true;
                        }
                        _pinError = null;
                        _setupPinFirstEntry = null;
                      });
                    },
                    child: Text(hasPin ? 'Unlock with PIN' : 'Set up PIN'),
                  )
                ],
              );
            },
          ),
        ),
      );
    }

    final entriesAsync = ref.watch(journalEntriesProvider);
    final stats = ref.watch(journalStatsProvider);

    return SakiScaffold(
      title: 'Journal',
      actions: [
        if (entriesAsync.hasValue)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: JournalSearchDelegate(entriesAsync.value ?? []),
              );
            },
          ),
      ],
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
                        MoodTrackingChart(entries: entries),
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
