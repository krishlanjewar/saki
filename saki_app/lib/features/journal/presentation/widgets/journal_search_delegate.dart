import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/journal_entry.dart';

class JournalSearchDelegate extends SearchDelegate<JournalEntry?> {
  final List<JournalEntry> entries;

  JournalSearchDelegate(this.entries);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final lowerQuery = query.toLowerCase();
    
    final results = entries.where((entry) {
      if (lowerQuery.isEmpty) return true;
      
      final matchTitle = entry.title.toLowerCase().contains(lowerQuery);
      final matchContent = entry.content.toLowerCase().contains(lowerQuery);
      final matchMood = entry.mood.name.toLowerCase().contains(lowerQuery);
      final dateString = DateFormat.yMMMd().format(entry.date).toLowerCase();
      final matchDate = dateString.contains(lowerQuery);
      
      return matchTitle || matchContent || matchMood || matchDate;
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('No journal entries found.'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final entry = results[index];
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
            onTap: () {
              close(context, entry);
              context.push('/journal/entry/${entry.id}');
            },
          ),
        );
      },
    );
  }
}
