import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SakiDrawer extends ConsumerWidget {
  const SakiDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: const Color(0xFFF7F5FC), // Pale lavender background
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        side: BorderSide(color: Color(0xFFB19CD9), width: 1.5), // Subtle purple border
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFD9D7E0),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFB19CD9), width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFEBE6F8),
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '<3 saki',
                    style: TextStyle(
                      color: Color(0xFF4B4953),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _DrawerItem(
                    title: 'HOME',
                    icon: Icons.tv_outlined,
                    isSelected: currentPath == '/',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/');
                    },
                  ),
                  _DrawerItem(
                    title: 'CALENDER',
                    icon: Icons.calendar_today_outlined,
                    trailingText: '24',
                    isSelected: currentPath == '/calendar',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/calendar');
                    },
                  ),
                  _DrawerItem(
                    title: 'GOALS',
                    icon: Icons.star_border_rounded,
                    isSelected: currentPath == '/goals',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/goals');
                    },
                  ),
                  _DrawerItem(
                    title: 'EXPENSE',
                    icon: Icons.language, // Matches the globe icon
                    trailingText: '1000',
                    isSelected: currentPath == '/expenses',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/expenses');
                    },
                  ),
                  _DrawerItem(
                    title: 'PERIOD',
                    icon: Icons.sentiment_satisfied_alt,
                    trailingText: '2-7',
                    isSelected: currentPath == '/period',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/period');
                    },
                  ),
                  _DrawerItem(
                    title: 'JOURNAL',
                    icon: Icons.folder_outlined,
                    isSelected: currentPath == '/journal',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/journal');
                    },
                  ),
                  _DrawerItem(
                    title: 'DESION',
                    icon: Icons.light_mode_outlined,
                    isSelected: currentPath == '/design',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/design');
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Color(0xFFD9D7E0), thickness: 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'coming soon',
                      style: TextStyle(
                        color: Color(0xFF4B4953),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  _DrawerItem(
                    title: 'Study timer',
                    icon: Icons.alarm_on_outlined,
                    isSelected: currentPath == '/study-timer',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/study-timer');
                    },
                  ),
                  _DrawerItem(
                    title: "BOOB'S",
                    icon: Icons.landscape_outlined,
                    isSelected: currentPath == '/boobs',
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/boobs');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? trailingText;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.icon,
    this.trailingText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEBE6F8) : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        leading: Icon(
          icon,
          color: const Color(0xFF4B4953),
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF4B4953),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        trailing: trailingText != null
            ? Text(
                trailingText!,
                style: const TextStyle(
                  color: Color(0xFF4B4953),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              )
            : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        dense: true,
      ),
    );
  }
}
