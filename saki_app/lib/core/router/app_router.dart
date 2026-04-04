import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/expense/presentation/screens/expense_screen.dart';
import '../../features/study_timer/presentation/screens/study_timer_screen.dart';
// Note: Other feature screens go here

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter appRouter(AppRouterRef ref) {
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
        path: '/study-timer',
        builder: (context, state) => const StudyTimerScreen(),
      ),
      // Add other routes here following feature-first architecture
    ],
  );
}
