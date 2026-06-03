import 'package:freezed_annotation/freezed_annotation.dart';
import 'journal_entry.dart';

part 'journal_stats.freezed.dart';

@freezed
abstract class JournalStats with _$JournalStats {
  const factory JournalStats({
    @Default(0) int currentStreak,
    @Default(0) int totalEntries,
    @Default(0) int totalWords,
    @Default({}) Map<String, int> tagCounts,
  }) = _JournalStats;
}

class JournalStatsCalculator {
  static JournalStats calculate(List<JournalEntry> entries) {
    if (entries.isEmpty) return const JournalStats();

    int streak = 0;
    int words = 0;
    Map<String, int> tags = {};

    // Sort entries by date descending
    final sorted = List<JournalEntry>.from(entries)..sort((a, b) => b.date.compareTo(a.date));

    // Calculate Streak
    // Improved streak logic
    final uniqueDates = sorted.map((e) => DateTime(e.date.year, e.date.month, e.date.day)).toSet();
    DateTime checkDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    
    if (uniqueDates.contains(checkDay)) {
      streak++;
      checkDay = checkDay.subtract(const Duration(days: 1));
    } else if (uniqueDates.contains(checkDay.subtract(const Duration(days: 1)))) {
       // If missed today but did yesterday, streak is still alive for yesterday
       checkDay = checkDay.subtract(const Duration(days: 1));
       streak++;
       checkDay = checkDay.subtract(const Duration(days: 1));
    }

    while (uniqueDates.contains(checkDay)) {
      streak++;
      checkDay = checkDay.subtract(const Duration(days: 1));
    }

    for (final entry in entries) {
      words += entry.content.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).length;
      for (final tag in entry.tags) {
        tags[tag] = (tags[tag] ?? 0) + 1;
      }
    }

    return JournalStats(
      currentStreak: streak,
      totalEntries: entries.length,
      totalWords: words,
      tagCounts: tags,
    );
  }
}
