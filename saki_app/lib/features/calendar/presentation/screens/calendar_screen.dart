import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/widgets/saki_drawer.dart';
import '../widgets/scrapbook_widgets.dart';
import '../widgets/analysis_chart.dart';
import '../widgets/scrapbook_calendar_widget.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EEDF), // paper like background
      drawer: const SakiDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            // A subtle texture overlay could go here in a real app
            
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 80, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Calendar Component
                  ScrapbookCalendarWidget(focusedDate: DateTime.now()),
                  
                  const SizedBox(height: 20),
                  
                  // Plans Section
                  ScrapbookCard(
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          StickyNote(
                            color: const Color(0xFFF7B9C4),
                            title: 'Task: Team Meeting',
                            subtitle: '22/5/26',
                            footer: 'Review project roadmap',
                          ),
                          StickyNote(
                            color: const Color(0xFFE2E2E2), // white-ish
                            title: 'Task: Client Call',
                            subtitle: '22/5/26',
                            footer: 'Discuss feedback',
                          ),
                          StickyNote(
                            color: const Color(0xFFF7B9C4),
                            title: 'Task: Brainstorming',
                            subtitle: '22/5/26',
                            footer: 'Generate new ideas',
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Analysis Section
                  ScrapbookCard(
                    color: const Color(0xFFF29B4F),
                    title: 'Analysis',
                    hasFold: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // DONE
                                  Expanded(
                                    child: StickyNote(
                                      color: const Color(0xFFAFD59D),
                                      title: 'Task - DONE:',
                                      subtitle: 'Submit Q1 review\nremark -',
                                    ),
                                  ),
                                  // Remain
                                  Expanded(
                                    child: StickyNote(
                                      color: const Color(0xFFF0756B),
                                      title: 'Task - Remain',
                                      subtitle: 'Task body\nreason-',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: StickyNote(
                                      color: const Color(0xFFF0756B),
                                      title: 'Task - Remain',
                                      subtitle: 'Task body\nreason-',
                                    ),
                                  ),
                                  Expanded(
                                    child: StickyNote(
                                      color: const Color(0xFFAFD59D),
                                      title: 'Task - DONE:',
                                      subtitle: 'Submit Q1 review\nremark -',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Circular Progress
                        const Padding(
                          padding: EdgeInsets.only(top: 20, right: 10),
                          child: AnalysisChart(percentage: 0.4),
                        ),
                      ],
                    ),
                  ),

                  // Investment Section
                  ScrapbookCard(
                    color: const Color(0xFFD4B144),
                    title: 'Investment',
                    titleTrailing: Text(
                      '1000000 BALANCE',
                      style: GoogleFonts.kalam(fontSize: 22, color: Colors.black87),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                         children: [
                            StickyNote(
                               color: const Color(0xFFAFD59D),
                               title: 'Investment - ₹ 5000',
                               subtitle: 'Stocks purchase',
                            ),
                            StickyNote(
                               color: const Color(0xFFAFD59D),
                               title: 'Investment - ₹ 5000',
                               subtitle: 'Mutual Fund',
                            ),
                            StickyNote(
                               color: const Color(0xFFAFD59D),
                               title: 'Investment - ₹ 5000',
                               subtitle: 'Savings bond',
                            ),
                         ],
                      ),
                    ),
                  ),

                  // Expenses Section
                  ScrapbookCard(
                     color: const Color(0xFFE4A4A2),
                     title: 'Expenses',
                     titleTrailing: Text(
                       '1000 Balance',
                       style: GoogleFonts.kalam(fontSize: 22, color: Colors.black87),
                     ),
                     child: SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Row(
                         children: [
                            StickyNote(
                               color: const Color(0xFFF0756B),
                               title: 'Expense: Lunch',
                               subtitle: 'Team outing',
                            ),
                            StickyNote(
                               color: const Color(0xFFF0756B),
                               title: 'Expense: Transport',
                               subtitle: 'Taxi fare',
                            ),
                            StickyNote(
                               color: const Color(0xFFF0756B),
                               title: 'Expense: Supplies',
                               subtitle: 'Office stationery',
                            ),
                         ],
                       ),
                     ),
                  ),
                  
                ],
              ),
            ),
            
            // Hamburger Menu Icon (floating on top left)
            Positioned(
              top: 16,
              left: 16,
              child: Builder(
                builder: (BuildContext iconContext) {
                  return IconButton(
                    icon: const Icon(Icons.menu, size: 36, color: Colors.black87),
                    onPressed: () {
                      Scaffold.of(iconContext).openDrawer();
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
