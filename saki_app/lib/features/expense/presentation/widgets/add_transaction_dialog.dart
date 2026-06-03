import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saki_app/shared/models/result.dart';
import '../../data/expense_repository.dart';
import '../../domain/models/transaction.dart';
import '../providers/expense_provider.dart';

/// Modal bottom sheet for adding a new expense or investment transaction.
/// Validates all fields before submission and shows a snackbar on success/error.
class AddTransactionDialog extends ConsumerStatefulWidget {
  const AddTransactionDialog({super.key, required this.isInvestment});

  /// Whether the user is adding an investment (true) or an expense/income (false).
  final bool isInvestment;

  @override
  ConsumerState<AddTransactionDialog> createState() =>
      _AddTransactionDialogState();
}

class _AddTransactionDialogState extends ConsumerState<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _investCatController = TextEditingController();

  TransactionType _type = TransactionType.debit;
  ExpenseCategory _category = ExpenseCategory.others;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Investments default to debit (money going out)
    _type = TransactionType.debit;
  }

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    _investCatController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final amount = double.parse(_amountController.text.trim());
    final transaction = Transaction(
      id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      description: _descController.text.trim(),
      amount: amount,
      date: _selectedDate,
      type: _type,
      category: _category,
      isInvestment: widget.isInvestment,
      investmentCategory: widget.isInvestment && _investCatController.text.isNotEmpty
          ? _investCatController.text.trim()
          : null,
    );

    final result =
        await ref.read(expenseRepositoryProvider).addTransaction(transaction);

    if (!mounted) return;
    setState(() => _isLoading = false);

    result.when(
      success: (_) {
        // Invalidate all providers that depend on transactions so UI refreshes
        ref.invalidate(filteredTransactionsProvider);
        ref.invalidate(trendDataProvider);
        ref.invalidate(investmentSummaryProvider);
        ref.invalidate(expenseSummaryProvider);
        ref.invalidate(radarChartDataProvider);

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.isInvestment
                  ? 'Investment added successfully'
                  : 'Transaction added successfully',
            ),
            backgroundColor: const Color(0xFF2E7D32),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      failure: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add: $error'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.isInvestment
        ? const Color(0xFF33691E)
        : const Color(0xFF4A148C);
    final bgColor = widget.isInvestment
        ? const Color(0xFFF1F8E9)
        : const Color(0xFFF3E5F5);
    final title = widget.isInvestment ? 'Add Investment' : 'Add Transaction';

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Handle bar ──────────────────────────────────────────────
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: accentColor.withAlpha(80),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Title ────────────────────────────────────────────────────
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 20),

              // ── Description ──────────────────────────────────────────────
              _FormField(
                controller: _descController,
                label: 'Description',
                hint: 'E.g. Zomato order, Mutual fund SIP…',
                accentColor: accentColor,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 14),

              // ── Amount ───────────────────────────────────────────────────
              _FormField(
                controller: _amountController,
                label: 'Amount (₹)',
                hint: '0.00',
                accentColor: accentColor,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  final parsed = double.tryParse(v.trim());
                  if (parsed == null || parsed <= 0) return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // ── Date picker ───────────────────────────────────────────────
              _LabelText(label: 'Date', accentColor: accentColor),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentColor.withAlpha(60)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 16, color: accentColor),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('dd MMM yyyy').format(_selectedDate),
                        style: TextStyle(
                          fontSize: 14,
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // ── Investment-only: bucket label ────────────────────────────
              if (widget.isInvestment) ...[
                _FormField(
                  controller: _investCatController,
                  label: 'Investment Category (optional)',
                  hint: 'E.g. Stocks, Mutual Fund, FD…',
                  accentColor: accentColor,
                ),
                const SizedBox(height: 14),
              ],

              // ── Non-investment: transaction type & category ───────────────
              if (!widget.isInvestment) ...[
                _LabelText(
                    label: 'Transaction Type', accentColor: accentColor),
                const SizedBox(height: 6),
                _SegmentedRow(
                  options: const ['Expense', 'Income'],
                  selectedIndex: _type == TransactionType.debit ? 0 : 1,
                  accentColor: accentColor,
                  onChanged: (i) => setState(() => _type =
                      i == 0 ? TransactionType.debit : TransactionType.credit),
                ),
                const SizedBox(height: 14),
                _LabelText(label: 'Category', accentColor: accentColor),
                const SizedBox(height: 6),
                _CategoryDropdown(
                  value: _category,
                  accentColor: accentColor,
                  onChanged: (cat) {
                    if (cat != null) setState(() => _category = cat);
                  },
                ),
                const SizedBox(height: 14),
              ],

              // ── Submit button ─────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _LabelText extends StatelessWidget {
  const _LabelText({required this.label, required this.accentColor});

  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: accentColor,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.accentColor,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Color accentColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelText(label: label, accentColor: accentColor),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accentColor.withAlpha(60)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accentColor.withAlpha(60)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: accentColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _SegmentedRow extends StatelessWidget {
  const _SegmentedRow({
    required this.options,
    required this.selectedIndex,
    required this.accentColor,
    required this.onChanged,
  });

  final List<String> options;
  final int selectedIndex;
  final Color accentColor;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(options.length, (i) {
        final isSelected = i == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              margin: EdgeInsets.only(right: i < options.length - 1 ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? accentColor : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accentColor.withAlpha(80)),
              ),
              child: Text(
                options[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: isSelected ? Colors.white : accentColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.value,
    required this.accentColor,
    required this.onChanged,
  });

  final ExpenseCategory value;
  final Color accentColor;
  final ValueChanged<ExpenseCategory?> onChanged;

  String _label(ExpenseCategory cat) {
    switch (cat) {
      case ExpenseCategory.food:
        return '🍕 Food';
      case ExpenseCategory.transport:
        return '🚗 Transport';
      case ExpenseCategory.gifts:
        return '🎁 Gifts';
      case ExpenseCategory.books:
        return '📚 Books';
      case ExpenseCategory.clothes:
        return '👗 Clothes';
      case ExpenseCategory.others:
        return '📦 Others';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withAlpha(60)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ExpenseCategory>(
          value: value,
          isExpanded: true,
          style: TextStyle(
            fontSize: 14,
            color: accentColor,
            fontWeight: FontWeight.w600,
          ),
          items: ExpenseCategory.values
              .map(
                (cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(_label(cat)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
