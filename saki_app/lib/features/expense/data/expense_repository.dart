import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/result.dart';
import '../domain/models/expense.dart';
import '../domain/models/transaction.dart';
import '../domain/models/investment_category.dart';

part 'expense_repository.g.dart';

abstract class IExpenseRepository {
  Future<Result<List<Expense>, String>> getExpenses();
  Future<Result<Expense, String>> addExpense(Expense expense);
  Future<Result<List<Transaction>, String>> getTransactions({
    DateTime? from,
    DateTime? to,
  });
  Future<Result<InvestmentSummary, String>> getInvestmentSummary();
  Future<Result<ExpenseSummary, String>> getExpenseSummary();
}

class ExpenseRepository implements IExpenseRepository {
  // NOTE: Mock data mirrors the bank statement shown in the UI design.
  static final List<Transaction> _mockTransactions = [
    Transaction(
      id: 't1',
      description:
          'TRANSFER TO\n4897696162090 -\nUPI/DR/315533224412\n/JIBRIL\nA/PYTM/paytmqr281/Payme',
      amount: 20.0,
      date: DateTime(2023, 6, 4),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't2',
      description: '- CMP MANDATE DEBIT\nBajaj Finance Ltd - SI',
      amount: 1578.0,
      date: DateTime(2023, 6, 3),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't3',
      description:
          '-Mandate fail Chrg txn\ndt.02062023-Bajaj\nFinance',
      amount: 295.0,
      date: DateTime(2023, 6, 3),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't4',
      description:
          'TRANSFER TO\n4897695162091 -\nUPI/DR/315473195844\n/PayU\nPay/INDB/bajafinan/UP\nI T',
      amount: 1578.0,
      date: DateTime(2023, 6, 3),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't5',
      description:
          'TRANSFER FROM\n4897736162097 -\nUPI/CR/351979305819\n/AKASH\nKU/PUNB/8859571259\n/Payme',
      amount: 3250.0,
      date: DateTime(2023, 6, 2),
      type: TransactionType.credit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't6',
      description: 'ZOMATO ORDER - Food delivery',
      amount: 450.0,
      date: DateTime(2023, 5, 31),
      type: TransactionType.debit,
      category: ExpenseCategory.food,
    ),
    Transaction(
      id: 't7',
      description: 'OLA RIDE - Airport drop',
      amount: 820.0,
      date: DateTime(2023, 5, 30),
      type: TransactionType.debit,
      category: ExpenseCategory.transport,
    ),
    Transaction(
      id: 't8',
      description: 'AMAZON - Books purchase',
      amount: 1200.0,
      date: DateTime(2023, 5, 28),
      type: TransactionType.debit,
      category: ExpenseCategory.books,
    ),
    Transaction(
      id: 't9',
      description: 'MYNTRA - Clothes shopping',
      amount: 2400.0,
      date: DateTime(2023, 5, 25),
      type: TransactionType.debit,
      category: ExpenseCategory.clothes,
    ),
    Transaction(
      id: 't10',
      description: 'Birthday gift - Priya',
      amount: 600.0,
      date: DateTime(2023, 5, 20),
      type: TransactionType.debit,
      category: ExpenseCategory.gifts,
    ),
  ];

  @override
  Future<Result<List<Expense>, String>> getExpenses() async {
    return const Result.success([]);
  }

  @override
  Future<Result<Expense, String>> addExpense(Expense expense) async {
    return Result.success(expense);
  }

  @override
  Future<Result<List<Transaction>, String>> getTransactions({
    DateTime? from,
    DateTime? to,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var result = List<Transaction>.from(_mockTransactions);
    if (from != null) {
      result = result
          .where((t) => t.date.isAfter(from.subtract(const Duration(days: 1))))
          .toList();
    }
    if (to != null) {
      result = result
          .where((t) => t.date.isBefore(to.add(const Duration(days: 1))))
          .toList();
    }
    result.sort((a, b) => b.date.compareTo(a.date));
    return Result.success(result);
  }

  @override
  Future<Result<InvestmentSummary, String>> getInvestmentSummary() async {
    return const Result.success(
      InvestmentSummary(
        totalBalance: 1000000,
        categories: [
          InvestmentCategory(label: 'Stocks purchase', amount: 5000),
          InvestmentCategory(label: 'Mutual Fund', amount: 5000),
          InvestmentCategory(label: 'Savings bond', amount: 5000),
        ],
      ),
    );
  }

  @override
  Future<Result<ExpenseSummary, String>> getExpenseSummary() async {
    return const Result.success(
      ExpenseSummary(
        totalBalance: 1000,
        categories: [
          InvestmentCategory(label: 'Lunch\nTeam outing', amount: 450),
          InvestmentCategory(label: 'Transport\nTaxi fare', amount: 820),
          InvestmentCategory(label: 'Supplies\nOffice stationery', amount: 300),
        ],
      ),
    );
  }
}

@riverpod
IExpenseRepository expenseRepository(Ref ref) {
  return ExpenseRepository();
}
