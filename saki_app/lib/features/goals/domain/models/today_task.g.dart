// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodayTask _$TodayTaskFromJson(Map<String, dynamic> json) => _TodayTask(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  date: json['date'] as String,
  isCompleted: json['isCompleted'] as bool? ?? false,
  deadline: json['deadline'] as String?,
);

Map<String, dynamic> _$TodayTaskToJson(_TodayTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'date': instance.date,
      'isCompleted': instance.isCompleted,
      'deadline': instance.deadline,
    };
