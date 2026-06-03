// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
  id: json['id'] as String,
  description: json['description'] as String,
  amount: (json['amount'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  category:
      $enumDecodeNullable(_$ExpenseCategoryEnumMap, json['category']) ??
      ExpenseCategory.others,
  isInvestment: json['isInvestment'] as bool? ?? false,
  investmentCategory: json['investmentCategory'] as String?,
);

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'category': _$ExpenseCategoryEnumMap[instance.category]!,
      'isInvestment': instance.isInvestment,
      'investmentCategory': instance.investmentCategory,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.credit: 'credit',
  TransactionType.debit: 'debit',
};

const _$ExpenseCategoryEnumMap = {
  ExpenseCategory.food: 'food',
  ExpenseCategory.transport: 'transport',
  ExpenseCategory.gifts: 'gifts',
  ExpenseCategory.books: 'books',
  ExpenseCategory.clothes: 'clothes',
  ExpenseCategory.others: 'others',
};
