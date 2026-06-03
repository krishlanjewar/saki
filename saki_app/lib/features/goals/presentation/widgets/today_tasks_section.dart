import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/models/today_task.dart';
import '../providers/goals_provider.dart';

/// Section showing tasks specific to today only, with deadline support.
class TodayTasksSection extends ConsumerWidget {
  const TodayTasksSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(todayTasksProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('⚡', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  "Today's Tasks",
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
                    border: Border.all(color: const Color(0xFFFFB74D)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14, color: Color(0xFFFFB74D)),
                      SizedBox(width: 4),
                      Text('Add', style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        color: Color(0xFFFFB74D),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          tasksAsync.when(
            data: (tasks) {
              if (tasks.isEmpty) {
                return _TodayEmptyState(onAdd: () => _showAddDialog(context, ref));
              }
              return Column(
                children: tasks.map((task) => _TodayTaskTile(
                  task: task,
                  onToggle: () => ref
                      .read(todayTasksProvider.notifier)
                      .toggleTask(task.id),
                  onDelete: () => ref
                      .read(todayTasksProvider.notifier)
                      .deleteTask(task.id),
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
    final descController = TextEditingController();
    DateTime? deadline;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
              )),
              const SizedBox(height: 16),
              const Text("Add Today's Task", style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white,
              )),
              const SizedBox(height: 16),
              _inputField(nameController, 'Task name', autofocus: true),
              const SizedBox(height: 12),
              _inputField(descController, 'Description (optional)'),
              const SizedBox(height: 12),
              // Deadline picker
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: deadline ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => deadline = picked);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A3E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF3E3E58)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFFFFB74D)),
                      const SizedBox(width: 10),
                      Text(
                        deadline != null
                            ? 'Deadline: ${DateFormat('dd MMM yyyy').format(deadline!)}'
                            : 'Set deadline (optional)',
                        style: TextStyle(
                          color: deadline != null ? const Color(0xFFFFB74D) : const Color(0xFF666680),
                          fontSize: 13,
                        ),
                      ),
                      if (deadline != null) ...[
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => deadline = null),
                          child: const Icon(Icons.close, size: 14, color: Color(0xFF666680)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB74D),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    final name = nameController.text.trim();
                    if (name.isEmpty) return;
                    final now = DateTime.now();
                    final dateKey = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
                    await ref.read(todayTasksProvider.notifier).addTask(
                      TodayTask(
                        id: 'tt_${now.millisecondsSinceEpoch}',
                        name: name,
                        description: descController.text.trim(),
                        date: dateKey,
                        deadline: deadline?.toIso8601String(),
                      ),
                    );
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text("Add Task", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController ctrl, String hint, {bool autofocus = false}) {
    return TextField(
      controller: ctrl,
      autofocus: autofocus,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF666680)),
        filled: true,
        fillColor: const Color(0xFF2A2A3E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3E3E58))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3E3E58))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFFFB74D), width: 1.5)),
      ),
    );
  }
}

class _TodayTaskTile extends StatelessWidget {
  const _TodayTaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  final TodayTask task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isDone = task.isCompleted;
    final isOverdue = task.isOverdue;
    final deadline = task.deadlineDate;

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFB71C1C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isOverdue
                ? const Color(0xFFEF5350).withAlpha(120)
                : isDone
                    ? const Color(0xFF66BB6A).withAlpha(80)
                    : const Color(0xFF2E2E42),
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDone ? const Color(0xFF66BB6A) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDone
                        ? const Color(0xFF66BB6A)
                        : isOverdue
                            ? const Color(0xFFEF5350)
                            : const Color(0xFF4E4E68),
                    width: 1.5,
                  ),
                ),
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDone ? const Color(0xFF666680) : Colors.white,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      task.description,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF888880)),
                    ),
                  ],
                  if (deadline != null) ...[
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 10,
                          color: isOverdue ? const Color(0xFFEF5350) : const Color(0xFFFFB74D),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          isOverdue
                              ? 'Overdue!'
                              : 'Due ${DateFormat('MMM d, h:mm a').format(deadline)}',
                          style: TextStyle(
                            fontSize: 10,
                            color: isOverdue ? const Color(0xFFEF5350) : const Color(0xFFFFB74D),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, size: 16, color: Color(0xFF666680)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayEmptyState extends StatelessWidget {
  const _TodayEmptyState({required this.onAdd});

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
            Icon(Icons.today_outlined, color: Color(0xFF666680), size: 32),
            SizedBox(height: 8),
            Text("No tasks for today", style: TextStyle(color: Color(0xFF666680), fontSize: 13)),
            SizedBox(height: 4),
            Text('Tap to add one', style: TextStyle(color: Color(0xFFFFB74D), fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
