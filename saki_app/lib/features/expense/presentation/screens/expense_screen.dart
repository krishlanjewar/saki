import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/saki_scaffold.dart';
import '../../../../core/constants/app_strings.dart';
import 'providers/expense_provider.dart';

class ExpenseScreen extends ConsumerWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(expenseProvider);

    return SakiScaffold(
      title: AppStrings.expenses,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add expense logic
        },
        child: const Icon(Icons.add),
      ),
      body: expenseState.when(
        data: (expenses) {
          if (expenses.isEmpty) {
             return const Center(child: Text('No expenses recorded yet.'));
          }
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ListTile(
                title: Text(expense.title),
                subtitle: Text(expense.category ?? 'Uncategorized'),
                trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
