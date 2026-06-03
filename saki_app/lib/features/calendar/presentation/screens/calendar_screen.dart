import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../shared/widgets/saki_drawer.dart';
import '../providers/calendar_state_providers.dart';
import '../widgets/scrapbook_widgets.dart';
import '../widgets/analysis_chart.dart';
import '../widgets/scrapbook_calendar_widget.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3EEDF), // paper like background
      drawer: const SakiDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 80, bottom: 40),
              child: isWide ? const _WideLayout() : const _NarrowLayout(),
            ),

            // Hamburger Menu Icon (floating on top left)
            Positioned(
              top: 16,
              left: 16,
              child: Builder(
                builder: (BuildContext iconContext) {
                  return IconButton(
                    icon: const Icon(Icons.menu, size: 36, color: Colors.black87),
                    tooltip: 'Open navigation drawer',
                    onPressed: () {
                      Scaffold.of(iconContext).openDrawer();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              ScrapbookCalendarWidget(),
              SizedBox(height: 8),
              _AnalysisCard(),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              _PlansCard(),
              _InvestmentCard(),
              _ExpensesCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ScrapbookCalendarWidget(),
        SizedBox(height: 8),
        _PlansCard(),
        _AnalysisCard(),
        _InvestmentCard(),
        _ExpensesCard(),
      ],
    );
  }
}

class _PlansCard extends ConsumerWidget {
  const _PlansCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsForSelectedDateProvider);

    return ScrapbookCard(
      color: const Color(0xFF67B2A9),
      title: 'Plans',
      tapes: [
        TapeDecor(
          alignment: Alignment.topLeft,
          angle: -0.2,
          color: const Color(0xFFFA9A76),
          striped: true,
          offsetDx: -10,
          offsetDy: -10,
        ),
        TapeDecor(
          alignment: Alignment.topRight,
          angle: 0.2,
          color: const Color(0xFFFA9A76),
          striped: true,
          offsetDx: 10,
          offsetDy: -10,
        ),
      ],
      child: eventsAsync.when(
        data: (events) {
          final plans = events.where((e) => e.category == 'plan').toList();

          if (plans.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No plans scheduled for this date.',
                style: GoogleFonts.kalam(
                  fontSize: 16,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: plans.map((plan) {
                return StickyNote(
                  color: const Color(0xFFF7B9C4),
                  title: plan.title,
                  subtitle: DateFormat('h:mm a').format(plan.startTime),
                  footer: plan.description,
                );
              }).toList(),
            ),
          );
        },
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(color: Colors.black54),
          ),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error loading plans',
            style: GoogleFonts.kalam(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class _AnalysisCard extends ConsumerWidget {
  const _AnalysisCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsForSelectedDateProvider);

    return ScrapbookCard(
      color: const Color(0xFFF29B4F),
      title: 'Analysis',
      hasFold: true,
      child: eventsAsync.when(
        data: (events) {
          final tasks = events.where((e) => e.category == 'task').toList();
          final completed = tasks.where((t) => t.isCompleted).toList();
          final remaining = tasks.where((t) => !t.isCompleted).toList();

          final total = tasks.length;
          final percentage = total == 0 ? 0.0 : completed.length / total;

          if (tasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No tasks to analyze for this date.',
                style: GoogleFonts.kalam(
                  fontSize: 16,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...completed.map((t) => Container(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: StickyNote(
                            color: const Color(0xFFAFD59D),
                            title: 'Task - DONE:',
                            subtitle: '${t.title}\n${t.description ?? ""}',
                          ),
                        )),
                    ...remaining.map((t) => Container(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: StickyNote(
                            color: const Color(0xFFF0756B),
                            title: 'Task - Remain',
                            subtitle: '${t.title}\n${t.description ?? ""}',
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 8),
                child: AnalysisChart(percentage: percentage),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(color: Colors.black54),
          ),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error loading analysis',
            style: GoogleFonts.kalam(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class _InvestmentCard extends ConsumerWidget {
  const _InvestmentCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsForSelectedDateProvider);

    return eventsAsync.when(
      data: (events) {
        final investments = events.where((e) => e.category == 'investment').toList();
        final totalInvested = investments.fold<double>(0, (sum, item) => sum + (item.amount ?? 0));

        return ScrapbookCard(
          color: const Color(0xFFD4B144),
          title: 'Investment',
          titleTrailing: Text(
            '₹ ${totalInvested.toStringAsFixed(0)} INVESTED',
            style: GoogleFonts.kalam(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          tapes: [
            TapeDecor(
              alignment: Alignment.topLeft,
              angle: -0.15,
              color: const Color(0xFFB19B4B),
              offsetDx: -10,
              offsetDy: -10,
            ),
            TapeDecor(
              alignment: Alignment.topRight,
              angle: 0.15,
              color: const Color(0xFFB19B4B),
              offsetDx: 10,
              offsetDy: -10,
            ),
          ],
          child: investments.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No investments recorded for this date.',
                    style: GoogleFonts.kalam(
                      fontSize: 16,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: investments.map((inv) {
                      return StickyNote(
                        color: const Color(0xFFAFD59D),
                        title: 'Investment - ₹ ${inv.amount?.toStringAsFixed(0)}',
                        subtitle: inv.title,
                      );
                    }).toList(),
                  ),
                ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }
}

class _ExpensesCard extends ConsumerWidget {
  const _ExpensesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsForSelectedDateProvider);

    return eventsAsync.when(
      data: (events) {
        final expenses = events.where((e) => e.category == 'expense').toList();
        final totalExpenses = expenses.fold<double>(0, (sum, item) => sum + (item.amount ?? 0));

        return ScrapbookCard(
          color: const Color(0xFFE4A4A2),
          title: 'Expenses',
          titleTrailing: Text(
            '₹ ${totalExpenses.toStringAsFixed(0)} TOTAL',
            style: GoogleFonts.kalam(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          child: expenses.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No expenses recorded for this date.',
                    style: GoogleFonts.kalam(
                      fontSize: 16,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: expenses.map((exp) {
                      return StickyNote(
                        color: const Color(0xFFF0756B),
                        title: 'Expense: ${exp.title}',
                        subtitle: '${exp.description ?? ""}\n₹ ${exp.amount?.toStringAsFixed(0)}',
                      );
                    }).toList(),
                  ),
                ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }
}
