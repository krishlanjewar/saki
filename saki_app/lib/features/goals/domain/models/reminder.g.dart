// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  name: json['name'] as String,
  lastDate: json['lastDate'] as String,
  notificationDate: json['notificationDate'] as String,
  notificationId: (json['notificationId'] as num).toInt(),
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'lastDate': instance.lastDate,
  'notificationDate': instance.notificationDate,
  'notificationId': instance.notificationId,
};
