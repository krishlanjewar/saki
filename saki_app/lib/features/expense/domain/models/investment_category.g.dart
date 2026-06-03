// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvestmentCategory _$InvestmentCategoryFromJson(Map<String, dynamic> json) =>
    _InvestmentCategory(
      label: json['label'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$InvestmentCategoryToJson(_InvestmentCategory instance) =>
    <String, dynamic>{'label': instance.label, 'amount': instance.amount};

_InvestmentSummary _$InvestmentSummaryFromJson(Map<String, dynamic> json) =>
    _InvestmentSummary(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => InvestmentCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvestmentSummaryToJson(_InvestmentSummary instance) =>
    <String, dynamic>{
      'totalBalance': instance.totalBalance,
      'categories': instance.categories,
    };

_ExpenseSummary _$ExpenseSummaryFromJson(Map<String, dynamic> json) =>
    _ExpenseSummary(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => InvestmentCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExpenseSummaryToJson(_ExpenseSummary instance) =>
    <String, dynamic>{
      'totalBalance': instance.totalBalance,
      'categories': instance.categories,
    };
