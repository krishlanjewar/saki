import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/models/reminder.dart';
import '../providers/goals_provider.dart';

/// Section showing active reminders with the ability to add/delete them.
class RemindersSection extends ConsumerWidget {
  const RemindersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔔', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Reminders',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showAddDialog(context, ref),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A42),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEF5350)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.notifications_outlined, size: 14, color: Color(0xFFEF5350)),
                      SizedBox(width: 4),
                      Text('Set Reminder', style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        color: Color(0xFFEF5350),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          remindersAsync.when(
            data: (reminders) {
              if (reminders.isEmpty) {
                return _RemindersEmpty(onAdd: () => _showAddDialog(context, ref));
              }
              return Column(
                children: reminders.map((r) => _ReminderCard(
                  reminder: r,
                  onDelete: () => ref
                      .read(remindersProvider.notifier)
                      .deleteReminder(r.id),
                )).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    DateTime? lastDate;
    DateTime? notificationDate;
    final fmt = DateFormat('dd MMM yyyy');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E2E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            left: 20, right: 20, top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
                )),
                const SizedBox(height: 16),
                const Text('Set Reminder', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white,
                )),
                const SizedBox(height: 16),

                // Name field
                const Text('Name', style: TextStyle(fontSize: 12, color: Color(0xFFA0A0A0), fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: nameController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDec('E.g. Submit assignment, Pay bills…'),
                ),
                const SizedBox(height: 14),

                // Last date picker
                const Text('Last Date', style: TextStyle(fontSize: 12, color: Color(0xFFA0A0A0), fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                _DatePickerTile(
                  label: lastDate != null ? fmt.format(lastDate!) : 'Select last date',
                  color: const Color(0xFFEF5350),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: lastDate ?? DateTime.now().add(const Duration(days: 7)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                    );
                    if (picked != null) {
                      setState(() {
                        lastDate = picked;
                        // Auto-set notification date to 2 days before
                        notificationDate = picked.subtract(const Duration(days: 2));
                      });
                    }
                  },
                ),
                const SizedBox(height: 14),

                // Notification date picker
                const Text('Notify Me On', style: TextStyle(fontSize: 12, color: Color(0xFFA0A0A0), fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                _DatePickerTile(
                  label: notificationDate != null
                      ? fmt.format(notificationDate!)
                      : 'Auto: 2 days before last date',
                  color: const Color(0xFFFFB74D),
                  onTap: lastDate == null ? null : () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: notificationDate ?? lastDate!.subtract(const Duration(days: 2)),
                      firstDate: DateTime.now(),
                      lastDate: lastDate!,
                    );
                    if (picked != null) setState(() => notificationDate = picked);
                  },
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF5350),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      final name = nameController.text.trim();
                      if (name.isEmpty || lastDate == null) return;
                      final nd = notificationDate ?? lastDate!.subtract(const Duration(days: 2));
                      await ref.read(remindersProvider.notifier).addReminder(
                        Reminder(
                          id: 'rem_${DateTime.now().millisecondsSinceEpoch}',
                          name: name,
                          lastDate: lastDate!.toIso8601String().split('T').first,
                          notificationDate: nd.toIso8601String().split('T').first,
                          notificationId: DateTime.now().millisecondsSinceEpoch % 100000,
                        ),
                      );
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('Set Reminder', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDec(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Color(0xFF666680)),
    filled: true,
    fillColor: const Color(0xFF2A2A3E),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3E3E58))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3E3E58))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1.5)),
  );
}

class _DatePickerTile extends StatelessWidget {
  const _DatePickerTile({required this.label, required this.color, this.onTap});

  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF3E3E58)),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 16, color: color),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 13, color: onTap == null ? const Color(0xFF444460) : color)),
          ],
        ),
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.reminder, required this.onDelete});

  final Reminder reminder;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMM yyyy');
    final daysLeft = reminder.daysRemaining;
    final isPast = daysLeft == 0;
    final urgencyColor = isPast
        ? const Color(0xFFEF5350)
        : daysLeft <= 3
            ? const Color(0xFFFFB74D)
            : const Color(0xFF66BB6A);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E2E42)),
      ),
      child: Row(
        children: [
          // Bell icon with urgency color
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: urgencyColor.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.notifications_outlined, color: urgencyColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.name,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 3),
                Text(
                  'Last date: ${fmt.format(reminder.lastDateTime)}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF888880)),
                ),
                Text(
                  'Notify: ${fmt.format(reminder.notificationDateTime)}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF888880)),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: urgencyColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isPast ? 'Deadline passed' : '$daysLeft day${daysLeft == 1 ? '' : 's'} remaining',
                    style: TextStyle(fontSize: 10, color: urgencyColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, size: 18, color: Color(0xFF666680)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

class _RemindersEmpty extends StatelessWidget {
  const _RemindersEmpty({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF3E3E58)),
        ),
        child: const Column(
          children: [
            Icon(Icons.notifications_none, color: Color(0xFF666680), size: 32),
            SizedBox(height: 8),
            Text('No active reminders', style: TextStyle(color: Color(0xFF666680), fontSize: 13)),
            SizedBox(height: 4),
            Text('Tap to set one', style: TextStyle(color: Color(0xFFEF5350), fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
