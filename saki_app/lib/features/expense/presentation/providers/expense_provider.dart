import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/expense.dart';
import '../../data/expense_repository.dart';

part 'expense_provider.g.dart';

@riverpod
class ExpenseList extends _$ExpenseList {
  @override
  FutureOr<List<Expense>> build() async {
    final repo = ref.watch(expenseRepositoryProvider);
    final result = await repo.getExpenses();

    return result.when(
      success: (expenses) => expenses,
      failure: (error) => throw Exception(error),
    );
  }
}
