// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyTask _$DailyTaskFromJson(Map<String, dynamic> json) => _DailyTask(
  id: json['id'] as String,
  name: json['name'] as String,
  category:
      $enumDecodeNullable(_$DailyTaskCategoryEnumMap, json['category']) ??
      DailyTaskCategory.other,
  completedDates:
      (json['completedDates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$DailyTaskToJson(_DailyTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$DailyTaskCategoryEnumMap[instance.category]!,
      'completedDates': instance.completedDates,
    };

const _$DailyTaskCategoryEnumMap = {
  DailyTaskCategory.health: 'health',
  DailyTaskCategory.study: 'study',
  DailyTaskCategory.work: 'work',
  DailyTaskCategory.other: 'other',
};
