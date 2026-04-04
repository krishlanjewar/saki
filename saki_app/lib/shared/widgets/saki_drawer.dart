import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class SakiDrawer extends ConsumerWidget {
  const SakiDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text(
              AppStrings.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(AppStrings.home),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text(AppStrings.calendar),
            onTap: () {
              Navigator.pop(context);
              context.go('/calendar');
            },
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: const Text(AppStrings.expenses),
            onTap: () {
              Navigator.pop(context);
              context.go('/expenses');
            },
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text(AppStrings.studyTimer),
            onTap: () {
              Navigator.pop(context);
              context.go('/study-timer');
            },
          ),
        ],
      ),
    );
  }
}
