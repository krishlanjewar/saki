import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/journal_entry.dart';
import '../providers/journal_providers.dart';
import '../../domain/services/reflection_prompts.dart';
import '../widgets/mood_selector.dart';

class JournalEntryScreen extends ConsumerStatefulWidget {
  final String? entryId;
  const JournalEntryScreen({super.key, this.entryId});

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  Mood _selectedMood = Mood.calm;
  List<String> _tags = [];
  JournalEntry? _existingEntry;

  @override
  void initState() {
    super.initState();
    if (widget.entryId != null) {
      // Load existing entry
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final entries = ref.read(journalEntriesProvider).asData?.value ?? [];
        try {
          _existingEntry = entries.firstWhere((e) => e.id == widget.entryId);
          _titleController.text = _existingEntry!.title;
          _contentController.text = _existingEntry!.content;
          setState(() {
            _selectedMood = _existingEntry!.mood;
            _tags = List.from(_existingEntry!.tags);
          });
        } catch (_) {}
      });
    } else {
      // Load draft if available
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final draft = ref.read(journalDraftProvider).asData?.value;
        if (draft != null) {
          _titleController.text = draft.title;
          _contentController.text = draft.content;
          setState(() {
            _selectedMood = draft.mood;
            _tags = List.from(draft.tags);
          });
        }
      });
    }

    _titleController.addListener(_onContentChanged);
    _contentController.addListener(_onContentChanged);
  }

  void _onContentChanged() {
    if (widget.entryId == null) {
      // Auto-save draft
      final draft = JournalEntry(
        id: 'draft',
        title: _titleController.text,
        content: _contentController.text,
        mood: _selectedMood,
        date: DateTime.now(),
        tags: _tags,
      );
      ref.read(journalDraftProvider.notifier).saveDraft(draft);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    if (_titleController.text.isEmpty && _contentController.text.isEmpty) {
      context.pop();
      return;
    }

    final entry = JournalEntry(
      id: _existingEntry?.id ?? const Uuid().v4(),
      title: _titleController.text.isEmpty ? 'Untitled' : _titleController.text,
      content: _contentController.text,
      mood: _selectedMood,
      date: _existingEntry?.date ?? DateTime.now(),
      tags: _tags,
    );

    if (_existingEntry != null) {
      await ref.read(journalEntriesProvider.notifier).updateEntry(entry);
    } else {
      await ref.read(journalEntriesProvider.notifier).addEntry(entry);
      // Clear draft
      await ref.read(journalDraftProvider.notifier).saveDraft(null);
    }

    if (mounted) {
      context.pop();
    }
  }

  void _showAddTagDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final ctrl = TextEditingController();
        return AlertDialog(
          title: const Text('Add Tag'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(hintText: 'e.g. Work, Health'),
          ),
          actions: [
            TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (ctrl.text.isNotEmpty) {
                  setState(() => _tags.add(ctrl.text));
                  _onContentChanged();
                }
                context.pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyPromptText = ref.watch(dailyPromptProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entryId != null ? 'Edit Entry' : 'New Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveEntry,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.entryId == null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Prompt: $dailyPromptText',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),

            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            const Text('How are you feeling?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            MoodSelector(
              selectedMood: _selectedMood,
              onChanged: (mood) {
                setState(() => _selectedMood = mood);
                _onContentChanged();
              },
            ),
            
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ..._tags.map((tag) => Chip(
                  label: Text(tag),
                  onDeleted: () {
                    setState(() => _tags.remove(tag));
                    _onContentChanged();
                  },
                )),
                ActionChip(
                  label: const Text('Add Tag'),
                  avatar: const Icon(Icons.add, size: 16),
                  onPressed: _showAddTagDialog,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: 'Start writing...',
                border: InputBorder.none,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            
            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.mic), onPressed: () {}), // TODO: Speech to text
            IconButton(icon: const Icon(Icons.image), onPressed: () {}), // TODO: Image picker
            IconButton(icon: const Icon(Icons.notification_add), onPressed: () {}), // TODO: Reminders
            const Spacer(),
            TextButton(onPressed: _saveEntry, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
