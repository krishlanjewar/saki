// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalEntry _$JournalEntryFromJson(Map<String, dynamic> json) =>
    _JournalEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      mood: $enumDecode(_$MoodEnumMap, json['mood']),
      date: DateTime.parse(json['date'] as String),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      attachedImages:
          (json['attachedImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      voiceNotePath: json['voiceNotePath'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$JournalEntryToJson(_JournalEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'mood': _$MoodEnumMap[instance.mood]!,
      'date': instance.date.toIso8601String(),
      'tags': instance.tags,
      'attachedImages': instance.attachedImages,
      'voiceNotePath': instance.voiceNotePath,
      'isFavorite': instance.isFavorite,
    };

const _$MoodEnumMap = {
  Mood.happy: 'happy',
  Mood.calm: 'calm',
  Mood.excited: 'excited',
  Mood.stressed: 'stressed',
  Mood.sad: 'sad',
};
