import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_entry.freezed.dart';
part 'journal_entry.g.dart';

enum Mood { happy, calm, excited, stressed, sad }

@freezed
abstract class JournalEntry with _$JournalEntry {
  const factory JournalEntry({
    required String id,
    required String title,
    required String content, // This will be encrypted when stored
    required Mood mood,
    required DateTime date,
    @Default([]) List<String> tags,
    @Default([]) List<String> attachedImages,
    String? voiceNotePath,
    @Default(false) bool isFavorite,
  }) = _JournalEntry;

  factory JournalEntry.fromJson(Map<String, dynamic> json) => _$JournalEntryFromJson(json);
}
