import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/app_database.dart';
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
  Future<Result<Transaction, String>> addTransaction(Transaction transaction);
  Future<Result<bool, String>> deleteTransaction(String id);
  Future<Result<InvestmentSummary, String>> getInvestmentSummary();
  Future<Result<ExpenseSummary, String>> getExpenseSummary();
}

class ExpenseRepository implements IExpenseRepository {
  final AppDatabase _db;
  List<Transaction>? _transactions;

  ExpenseRepository(this._db);

  // NOTE: Initial mock data that mirrors the bank statements, loaded if no saved data exists.
  static final List<Transaction> _mockTransactions = [
    Transaction(
      id: 't1',
      description: 'UPI/DR/315533224412/JIBRIL A/PYTM/paytmqr281/Payme',
      amount: 20.0,
      date: DateTime(2023, 6, 4),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't2',
      description: 'CMP MANDATE DEBIT Bajaj Finance Ltd - SI',
      amount: 1578.0,
      date: DateTime(2023, 6, 3),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't3',
      description: 'Mandate fail Chrg txn dt.02062023-Bajaj Finance',
      amount: 295.0,
      date: DateTime(2023, 6, 3),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't4',
      description: 'UPI/DR/315473195844/PayU Pay/INDB/bajafinan/UPI T',
      amount: 1578.0,
      date: DateTime(2023, 6, 3),
      type: TransactionType.debit,
      category: ExpenseCategory.others,
    ),
    Transaction(
      id: 't5',
      description: 'UPI/CR/351979305819/AKASH KU/PUNB/8859571259/Payme',
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

  Future<void> _initIfNeeded() async {
    if (_transactions != null) return;
    try {
      final dataStr = await _db.getString('saki_transactions');
      if (dataStr != null) {
        final List<dynamic> jsonList = jsonDecode(dataStr);
        _transactions = jsonList.map((item) => Transaction.fromJson(item)).toList();
      } else {
        _transactions = List<Transaction>.from(_mockTransactions);
        await _saveToDb();
      }
    } catch (e) {
      _transactions = List<Transaction>.from(_mockTransactions);
    }
  }

  Future<void> _saveToDb() async {
    if (_transactions == null) return;
    try {
      final dataStr = jsonEncode(_transactions!.map((t) => t.toJson()).toList());
      await _db.putString('saki_transactions', dataStr);
    } catch (e) {
      // Suppress or log error
    }
  }

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
    await _initIfNeeded();
    var result = List<Transaction>.from(_transactions!);
    if (from != null) {
      final normalizedFrom = DateTime(from.year, from.month, from.day);
      result = result
          .where((t) => t.date.isAfter(normalizedFrom.subtract(const Duration(seconds: 1))))
          .toList();
    }
    if (to != null) {
      final normalizedTo = DateTime(to.year, to.month, to.day, 23, 59, 59);
      result = result
          .where((t) => t.date.isBefore(normalizedTo.add(const Duration(seconds: 1))))
          .toList();
    }
    result.sort((a, b) => b.date.compareTo(a.date));
    return Result.success(result);
  }

  @override
  Future<Result<Transaction, String>> addTransaction(Transaction transaction) async {
    await _initIfNeeded();
    _transactions!.insert(0, transaction);
    await _saveToDb();
    return Result.success(transaction);
  }

  @override
  Future<Result<bool, String>> deleteTransaction(String id) async {
    await _initIfNeeded();
    final initialLength = _transactions!.length;
    _transactions!.removeWhere((t) => t.id == id);
    if (_transactions!.length < initialLength) {
      await _saveToDb();
      return const Result.success(true);
    }
    return const Result.failure('Transaction not found');
  }

  @override
  Future<Result<InvestmentSummary, String>> getInvestmentSummary() async {
    await _initIfNeeded();
    final investments = _transactions!.where((t) => t.isInvestment).toList();
    final total = investments.fold<double>(0, (sum, t) => sum + t.amount);

    final Map<String, double> grouped = {};
    for (final t in investments) {
      final key = t.investmentCategory ?? t.description;
      grouped[key] = (grouped[key] ?? 0.0) + t.amount;
    }

    final categories = grouped.entries.map((e) {
      return InvestmentCategory(label: e.key, amount: e.value);
    }).toList();

    return Result.success(InvestmentSummary(
      totalBalance: total,
      categories: categories,
    ));
  }

  @override
  Future<Result<ExpenseSummary, String>> getExpenseSummary() async {
    await _initIfNeeded();
    final debits = _transactions!.where((t) => !t.isInvestment && t.type == TransactionType.debit).toList();
    final total = debits.fold<double>(0, (sum, t) => sum + t.amount);

    final Map<String, double> grouped = {};
    for (final t in debits) {
      final key = '${_categoryName(t.category)}\n${t.description}';
      grouped[key] = (grouped[key] ?? 0.0) + t.amount;
    }

    final categories = grouped.entries.map((e) {
      return InvestmentCategory(label: e.key, amount: e.value);
    }).toList();

    return Result.success(ExpenseSummary(
      totalBalance: total,
      categories: categories,
    ));
  }

  String _categoryName(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food: return 'Food';
      case ExpenseCategory.transport: return 'Transport';
      case ExpenseCategory.gifts: return 'Gifts';
      case ExpenseCategory.books: return 'Books';
      case ExpenseCategory.clothes: return 'Clothes';
      case ExpenseCategory.others: return 'Others';
    }
  }
}

@riverpod
IExpenseRepository expenseRepository(Ref ref) {
  return ExpenseRepository(ref.watch(databaseProvider));
}
