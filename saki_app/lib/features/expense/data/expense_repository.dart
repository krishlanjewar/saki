import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/models/result.dart';
import '../domain/models/expense.dart';

part 'expense_repository.g.dart';

abstract class IExpenseRepository {
  Future<Result<List<Expense>, String>> getExpenses();
  Future<Result<Expense, String>> addExpense(Expense expense);
}

class ExpenseRepository implements IExpenseRepository {
  @override
  Future<Result<List<Expense>, String>> getExpenses() async {
    return const Result.success([]);
  }

  @override
  Future<Result<Expense, String>> addExpense(Expense expense) async {
    return Result.success(expense);
  }
}

@riverpod
IExpenseRepository expenseRepository(Ref ref) {
  return ExpenseRepository();
}
