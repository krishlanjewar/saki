import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/expense_provider.dart';

class ExpenseFilterBar extends ConsumerWidget {
  const ExpenseFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(expenseDateFilterProvider);
    final formatter = DateFormat('dd/MM/yyyy');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          _DateButton(
            label: filter.from != null
                ? 'From: ${formatter.format(filter.from!)}'
                : 'From : date',
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: filter.from ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                ref.read(expenseDateFilterProvider.notifier).setFrom(date);
              }
            },
          ),
          const SizedBox(width: 8),
          _DateButton(
            label: filter.to != null
                ? 'To: ${formatter.format(filter.to!)}'
                : 'To: date',
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: filter.to ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                ref.read(expenseDateFilterProvider.notifier).setTo(date);
              }
            },
          ),
          const Spacer(),
          _DateButton(
            label: 'ADD transaction',
            onTap: () {
              // TODO: Implement Add Transaction Dialog
            },
          ),
        ],
      ),
    );
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE1BEE7), // Light purple matching design
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A148C),
          ),
        ),
      ),
    );
  }
}
