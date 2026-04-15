// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'investment_category.freezed.dart';
part 'investment_category.g.dart';

/// A single investment bucket (stocks, mutual funds, savings bond, etc.)
@freezed
abstract class InvestmentCategory with _$InvestmentCategory {
  const factory InvestmentCategory({
    required String label,
    required double amount,
  }) = _InvestmentCategory;

  factory InvestmentCategory.fromJson(Map<String, dynamic> json) =>
      _$InvestmentCategoryFromJson(json);
}

/// Holds the overall investment summary shown on the expense screen.
@freezed
abstract class InvestmentSummary with _$InvestmentSummary {
  const factory InvestmentSummary({
    required double totalBalance,
    required List<InvestmentCategory> categories,
  }) = _InvestmentSummary;

  factory InvestmentSummary.fromJson(Map<String, dynamic> json) =>
      _$InvestmentSummaryFromJson(json);
}

/// Holds the overall expense summary (daily spend buckets).
@freezed
abstract class ExpenseSummary with _$ExpenseSummary {
  const factory ExpenseSummary({
    required double totalBalance,
    required List<InvestmentCategory> categories,
  }) = _ExpenseSummary;

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSummaryFromJson(json);
}
