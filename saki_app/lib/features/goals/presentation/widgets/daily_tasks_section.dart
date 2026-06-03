import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/daily_task.dart';
import '../providers/goals_provider.dart';

/// Displays all daily tasks with completion toggles, edit and delete options.
class DailyTasksSection extends ConsumerWidget {
  const DailyTasksSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(dailyTasksProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🗓️', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Daily Tasks',
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
                    border: Border.all(color: const Color(0xFF6C63FF)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14, color: Color(0xFF9C88FF)),
                      SizedBox(width: 4),
                      Text('Add', style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        color: Color(0xFF9C88FF),
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
                return _EmptyState(
                  message: 'No daily tasks yet',
                  onAdd: () => _showAddDialog(context, ref),
                );
              }
              return Column(
                children: tasks.map((task) {
                  return _DailyTaskTile(
                    task: task,
                    onToggle: () => ref
                        .read(dailyTasksProvider.notifier)
                        .toggleToday(task.id),
                    onDelete: () => ref
                        .read(dailyTasksProvider.notifier)
                        .deleteTask(task.id),
                    onEdit: () => _showEditDialog(context, ref, task),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref, [DailyTask? existing]) async {
    final nameController = TextEditingController(text: existing?.name ?? '');
    var category = existing?.category ?? DailyTaskCategory.other;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => _TaskModal(
          title: existing == null ? 'Add Daily Task' : 'Edit Daily Task',
          nameController: nameController,
          category: category,
          onCategoryChanged: (c) => setState(() => category = c),
          onSave: () async {
            final name = nameController.text.trim();
            if (name.isEmpty) return;
            if (existing == null) {
              await ref.read(dailyTasksProvider.notifier).addTask(
                DailyTask(
                  id: 'dt_${DateTime.now().millisecondsSinceEpoch}',
                  name: name,
                  category: category,
                ),
              );
            } else {
              await ref.read(dailyTasksProvider.notifier).updateTask(
                existing.copyWith(name: name, category: category),
              );
            }
            if (ctx.mounted) Navigator.pop(ctx);
          },
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref, DailyTask task) =>
      _showAddDialog(context, ref, task);
}

class _DailyTaskTile extends StatelessWidget {
  const _DailyTaskTile({
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  final DailyTask task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final isDone = task.isCompletedToday;
    final catColor = _catColor(task.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDone ? const Color(0xFF66BB6A).withAlpha(100) : const Color(0xFF2E2E42),
        ),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDone ? const Color(0xFF66BB6A) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isDone ? const Color(0xFF66BB6A) : const Color(0xFF4E4E68),
                  width: 1.5,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
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
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: catColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${task.category.emoji} ${task.category.label}',
                    style: TextStyle(fontSize: 9, color: catColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF666680)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, size: 16, color: Color(0xFF666680)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }

  Color _catColor(DailyTaskCategory cat) {
    switch (cat) {
      case DailyTaskCategory.health: return const Color(0xFF66BB6A);
      case DailyTaskCategory.study:  return const Color(0xFF42A5F5);
      case DailyTaskCategory.work:   return const Color(0xFFFFB74D);
      case DailyTaskCategory.other:  return const Color(0xFFAB47BC);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared modal widget
// ─────────────────────────────────────────────────────────────────────────────

class _TaskModal extends StatelessWidget {
  const _TaskModal({
    required this.title,
    required this.nameController,
    required this.category,
    required this.onCategoryChanged,
    required this.onSave,
  });

  final String title;
  final TextEditingController nameController;
  final DailyTaskCategory category;
  final ValueChanged<DailyTaskCategory> onCategoryChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white,
          )),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDec('Task name'),
          ),
          const SizedBox(height: 14),
          const Text('Category', style: TextStyle(fontSize: 12, color: Color(0xFFA0A0A0), fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: DailyTaskCategory.values.map((cat) {
              final isSelected = cat == category;
              return GestureDetector(
                onTap: () => onCategoryChanged(cat),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6C63FF) : const Color(0xFF2A2A3E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF6C63FF) : const Color(0xFF3E3E58),
                    ),
                  ),
                  child: Text(
                    '${cat.emoji} ${cat.label}',
                    style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFFA0A0A0),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onSave,
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
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
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 1.5)),
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message, required this.onAdd});

  final String message;
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
          border: Border.all(
            color: const Color(0xFF3E3E58),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            const Icon(Icons.add_circle_outline, color: Color(0xFF666680), size: 32),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(color: Color(0xFF666680), fontSize: 13)),
            const SizedBox(height: 4),
            const Text('Tap to add one', style: TextStyle(color: Color(0xFF6C63FF), fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
