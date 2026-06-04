import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/journal_entry.dart';

class JournalSearchDelegate extends SearchDelegate<JournalEntry?> {
  final List<JournalEntry> entries;

  DateTime? _selectedDate;
  Mood? _selectedMood;
  String? _selectedTag;

  final Map<Mood, String> _moodEmojis = {
    Mood.sad: '😢',
    Mood.stressed: '🙁',
    Mood.calm: '😐',
    Mood.happy: '🙂',
    Mood.excited: '😊',
  };

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
    return StatefulBuilder(
      builder: (context, setState) {
        final lowerQuery = query.toLowerCase();
        
        final results = entries.where((entry) {
          if (_selectedDate != null) {
            if (entry.date.year != _selectedDate!.year || 
                entry.date.month != _selectedDate!.month || 
                entry.date.day != _selectedDate!.day) {
              return false;
            }
          }

          if (_selectedMood != null) {
            if (entry.mood != _selectedMood) {
              return false;
            }
          }

          if (_selectedTag != null) {
            if (!entry.tags.contains(_selectedTag)) {
              return false;
            }
          }

          if (lowerQuery.isEmpty) return true;
          
          final matchTitle = entry.title.toLowerCase().contains(lowerQuery);
          final matchContent = entry.content.toLowerCase().contains(lowerQuery);
          final matchMood = entry.mood.name.toLowerCase().contains(lowerQuery);
          final dateString = DateFormat.yMMMd().format(entry.date).toLowerCase();
          final matchDate = dateString.contains(lowerQuery);
          
          return matchTitle || matchContent || matchMood || matchDate;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  FilterChip(
                    avatar: const Icon(Icons.calendar_today, size: 16),
                    label: Text(_selectedDate == null ? 'Any Date' : DateFormat('MMM d, yyyy').format(_selectedDate!)),
                    selected: _selectedDate != null,
                    onSelected: (bool selected) async {
                      if (!selected) {
                        setState(() => _selectedDate = null);
                      } else {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                        }
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    avatar: _selectedMood == null 
                        ? const Icon(Icons.emoji_emotions_outlined, size: 16) 
                        : Text(_moodEmojis[_selectedMood]!),
                    label: Text(_selectedMood == null ? 'Any Mood' : _selectedMood!.name.toUpperCase()),
                    selected: _selectedMood != null,
                    onSelected: (bool selected) {
                      if (!selected) {
                        setState(() => _selectedMood = null);
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return SafeArea(
                              child: Wrap(
                                children: Mood.values.map((mood) {
                                  return ListTile(
                                    leading: Text(_moodEmojis[mood] ?? '😐', style: const TextStyle(fontSize: 24)),
                                    title: Text(mood.name.toUpperCase()),
                                    onTap: () {
                                      Navigator.pop(ctx);
                                      setState(() => _selectedMood = mood);
                                    },
                                  );
                                }).toList(),
                              )
                            );
                          }
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    avatar: const Icon(Icons.tag, size: 16),
                    label: Text(_selectedTag ?? 'Any Tag'),
                    selected: _selectedTag != null,
                    onSelected: (bool selected) {
                      if (!selected) {
                        setState(() => _selectedTag = null);
                      } else {
                        final allTags = entries.expand((e) => e.tags).toSet().toList()..sort();
                        if (allTags.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No tags found in entries.')));
                          return;
                        }
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return SafeArea(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: allTags.map((tag) {
                                    return ListTile(
                                      leading: const Icon(Icons.local_offer_outlined),
                                      title: Text(tag),
                                      onTap: () {
                                        Navigator.pop(ctx);
                                        setState(() => _selectedTag = tag);
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            );
                          }
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: results.isEmpty 
                ? const Center(child: Text('No journal entries found.'))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final entry = results[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: ListTile(
                          leading: Text(_moodEmojis[entry.mood] ?? '😐', style: const TextStyle(fontSize: 24)),
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
                  ),
            ),
          ],
        );
      }
    );
  }
}
