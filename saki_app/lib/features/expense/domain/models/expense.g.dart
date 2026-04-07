// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
  id: json['id'] as String,
  amount: (json['amount'] as num).toDouble(),
  title: json['title'] as String,
  date: DateTime.parse(json['date'] as String),
  category: json['category'] as String?,
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'title': instance.title,
  'date': instance.date.toIso8601String(),
  'category': instance.category,
};
