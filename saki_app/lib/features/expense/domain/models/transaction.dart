// ignore_for_file: unused_element
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// Type of transaction – credit adds to balance, debit reduces it.
enum TransactionType { credit, debit }

/// Category for spending analytics shown in the radar chart.
enum ExpenseCategory { food, transport, gifts, books, clothes, others }

@freezed
abstract class Transaction with _$Transaction {
  const Transaction._();

  const factory Transaction({
    required String id,
    required String description,
    required double amount,
    required DateTime date,
    required TransactionType type,
    @Default(ExpenseCategory.others) ExpenseCategory category,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  /// Returns true when this is money coming in.
  bool get isCredit => type == TransactionType.credit;
}
