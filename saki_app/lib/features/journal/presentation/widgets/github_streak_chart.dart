import 'package:flutter/material.dart';
import '../../domain/models/journal_entry.dart';

class GithubStreakChart extends StatelessWidget {
  final List<JournalEntry> entries;
  
  const GithubStreakChart({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    // Generate last 84 days (12 weeks)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Create a set of dates that have entries
    final entryDates = entries.map((e) => DateTime(e.date.year, e.date.month, e.date.day)).toSet();

    List<Widget> columns = [];
    
    // We want 12 columns, 7 rows
    for (int week = 11; week >= 0; week--) {
      List<Widget> days = [];
      for (int dayOfWeek = 0; dayOfWeek < 7; dayOfWeek++) {
        // Calculate date for this cell
        // We want the last column to end on today or end of this week
        int daysAgo = (week * 7) + (6 - dayOfWeek);
        DateTime cellDate = today.subtract(Duration(days: daysAgo));
        
        // Is it in the future? (if we align to end of week instead of today)
        // Here we just map directly from 84 days ago up to today
        
        bool hasEntry = entryDates.contains(cellDate);
        
        days.add(
          Container(
            margin: const EdgeInsets.all(2),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: hasEntry ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(2),
            ),
          )
        );
      }
      columns.add(Column(children: days));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true, // start scrolled to the right (latest)
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: columns,
      ),
    );
  }
}
