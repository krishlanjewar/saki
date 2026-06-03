import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/expense/presentation/screens/expense_screen.dart';
import '../../features/goals/presentation/screens/goals_screen.dart';
import '../../features/study_timer/presentation/screens/study_timer_screen.dart';
import '../../features/journal/presentation/screens/journal_dashboard_screen.dart';
import '../../features/journal/presentation/screens/journal_entry_screen.dart';

import '../../shared/widgets/saki_scaffold.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: '/expenses',
        builder: (context, state) => const ExpenseScreen(),
      ),
      GoRoute(
        path: '/goals',
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: '/period',
        builder: (context, state) => const _PlaceholderScreen(title: 'Period'),
      ),
      GoRoute(
        path: '/journal',
        builder: (context, state) => const JournalDashboardScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const JournalEntryScreen(),
          ),
          GoRoute(
            path: 'entry/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              return JournalEntryScreen(entryId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/design',
        builder: (context, state) => const _PlaceholderScreen(title: 'Design'),
      ),
      GoRoute(
        path: '/study-timer',
        builder: (context, state) => const StudyTimerScreen(),
      ),
      GoRoute(
        path: '/boobs',
        builder: (context, state) => const _PlaceholderScreen(title: "BOOKS"),
      ),
    ],
  );
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return SakiScaffold(
      title: title,
      body: Center(
        child: Text(
          '$title Feature Coming Soon',
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}
