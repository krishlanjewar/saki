import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:saki_app/core/database/app_database.dart';
import 'package:saki_app/features/journal/data/services/encryption_service.dart';
import 'package:saki_app/features/journal/domain/models/journal_entry.dart';

part 'journal_repository.g.dart';

const _kJournalEntries = 'saki_journal_entries';
const _kJournalDraft = 'saki_journal_draft';

abstract class IJournalRepository {
  Future<List<JournalEntry>> getEntries();
  Future<void> saveEntries(List<JournalEntry> entries);
  Future<JournalEntry?> getDraft();
  Future<void> saveDraft(JournalEntry? draft);
}

class JournalRepository implements IJournalRepository {
  final AppDatabase _db;
  final EncryptionService _encryptionService;

  JournalRepository(this._db, this._encryptionService);

  @override
  Future<List<JournalEntry>> getEntries() async {
    final raw = await _db.getString(_kJournalEntries);
    if (raw == null) return [];
    try {
      final List<dynamic> list = jsonDecode(raw);
      final entries = list.map((e) => JournalEntry.fromJson(e as Map<String, dynamic>)).toList();
      
      // Decrypt contents
      return entries.map((e) => e.copyWith(
        content: _encryptionService.decrypt(e.content),
      )).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveEntries(List<JournalEntry> entries) async {
    // Encrypt contents before saving
    final encryptedEntries = entries.map((e) => e.copyWith(
      content: _encryptionService.encrypt(e.content),
    )).toList();
    
    await _db.putString(_kJournalEntries, jsonEncode(encryptedEntries.map((e) => e.toJson()).toList()));
  }

  @override
  Future<JournalEntry?> getDraft() async {
    final raw = await _db.getString(_kJournalDraft);
    if (raw == null) return null;
    try {
      final entry = JournalEntry.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      return entry.copyWith(content: _encryptionService.decrypt(entry.content));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveDraft(JournalEntry? draft) async {
    if (draft == null) {
      await _db.delete(_kJournalDraft);
      return;
    }
    final encryptedDraft = draft.copyWith(
      content: _encryptionService.encrypt(draft.content),
    );
    await _db.putString(_kJournalDraft, jsonEncode(encryptedDraft.toJson()));
  }
}

@riverpod
Future<IJournalRepository> journalRepository(Ref ref) async {
  final db = ref.watch(databaseProvider);
  final encryption = await ref.watch(encryptionServiceProvider.future);
  return JournalRepository(db, encryption);
}
