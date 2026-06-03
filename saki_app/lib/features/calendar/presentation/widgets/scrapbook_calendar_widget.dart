import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../providers/calendar_state_providers.dart';

class ScrapbookCalendarWidget extends ConsumerStatefulWidget {
  const ScrapbookCalendarWidget({super.key});

  @override
  ConsumerState<ScrapbookCalendarWidget> createState() => _ScrapbookCalendarWidgetState();
}

class _ScrapbookCalendarWidgetState extends ConsumerState<ScrapbookCalendarWidget> {
  late PageController _pageController;
  late int _initialPage;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Initialize PageView index relative to year 2000 (month index since Jan 2000)
    final focusedDate = ref.read(focusedDateProvider);
    _initialPage = _pageIndexFromDate(focusedDate);
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Calculate month/year from page index
  DateTime _dateFromPageIndex(int index) {
    final year = 2000 + index ~/ 12;
    final month = index % 12 + 1;
    return DateTime(year, month, 1);
  }

  // Calculate page index from month/year
  int _pageIndexFromDate(DateTime date) {
    return (date.year - 2000) * 12 + (date.month - 1);
  }

  void _onPageChanged(int index) {
    if (_isAnimating) return;
    final date = _dateFromPageIndex(index);
    ref.read(focusedDateProvider.notifier).setMonthAndYear(date.month, date.year);
  }

  Future<void> _animateToMonth(DateTime targetDate) async {
    if (!_pageController.hasClients) return;
    final targetIndex = _pageIndexFromDate(targetDate);
    final currentIndex = _pageController.page?.round() ?? _initialPage;

    if (currentIndex != targetIndex) {
      _isAnimating = true;
      await _pageController.animateToPage(
        targetIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _isAnimating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedDate = ref.watch(focusedDateProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    // Listen to FocusedDate provider state changes to update PageView programmatically
    ref.listen<DateTime>(focusedDateProvider, (previous, next) {
      final currentControllerPage = _pageController.hasClients ? _pageController.page?.round() : null;
      final targetIndex = _pageIndexFromDate(next);
      if (currentControllerPage != targetIndex) {
        _animateToMonth(next);
      }
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 800;
    final horizontalMargin = isWide ? 40.0 : 16.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            offset: const Offset(4, 6),
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                      tooltip: 'Previous Month',
                      onPressed: () {
                        ref.read(focusedDateProvider.notifier).previousMonth();
                      },
                    ),
                    const SizedBox(width: 8),
                    _buildMonthYearDropdowns(focusedDate),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward, size: 20, color: Colors.black87),
                      tooltip: 'Next Month',
                      onPressed: () {
                        ref.read(focusedDateProvider.notifier).nextMonth();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Days of week header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                      .map((d) => ExcludeSemantics(
                            child: Text(
                              d,
                              style: GoogleFonts.kalam(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),

                // Swipable PageView dates grid
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      final monthDate = _dateFromPageIndex(index);
                      return _buildMonthPage(monthDate, selectedDate);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Photo corners for scrapbook design
          Positioned(
            top: 0,
            left: 0,
            child: _buildPhotoCorner(true, true),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _buildPhotoCorner(true, false),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: _buildPhotoCorner(false, true),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildPhotoCorner(false, false),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthYearDropdowns(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    // Restrict dropdown options to a standard 15-year window
    final years = List<int>.generate(15, (i) => 2020 + i);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Month Dropdown Selection
        Semantics(
          label: 'Select Month',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: date.month,
              icon: const SizedBox.shrink(),
              dropdownColor: Colors.white,
              style: GoogleFonts.kalam(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              selectedItemBuilder: (BuildContext context) {
                return months.map<Widget>((String m) {
                  return Text(
                    '$m \u25BC',
                    style: GoogleFonts.kalam(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }).toList();
              },
              items: months.asMap().entries.map((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key + 1,
                  child: Text(
                    entry.value,
                    style: GoogleFonts.kalam(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  ref.read(focusedDateProvider.notifier).setMonthAndYear(val, date.year);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Year Dropdown Selection
        Semantics(
          label: 'Select Year',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: date.year,
              icon: const SizedBox.shrink(),
              dropdownColor: Colors.white,
              style: GoogleFonts.kalam(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              selectedItemBuilder: (BuildContext context) {
                return years.map<Widget>((int y) {
                  return Text(
                    '$y \u25BC',
                    style: GoogleFonts.kalam(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }).toList();
              },
              items: years.map((int y) {
                return DropdownMenuItem<int>(
                  value: y,
                  child: Text(
                    '$y',
                    style: GoogleFonts.kalam(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  ref.read(focusedDateProvider.notifier).setMonthAndYear(date.month, val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthPage(DateTime pageDate, DateTime selectedDate) {
    List<Widget> rows = [];
    List<Widget> week = [];

    // Calculate start day of month (1 = Monday, 7 = Sunday)
    final firstDayOfMonth = DateTime(pageDate.year, pageDate.month, 1);
    final startingWeekday = firstDayOfMonth.weekday;

    // Calculate days in month
    final daysInMonth = DateTime(pageDate.year, pageDate.month + 1, 0).day;

    // Pad lead-in empty slots for alignment
    for (int i = 1; i < startingWeekday; i++) {
      week.add(const SizedBox(width: 32, height: 32));
    }

    // Add days
    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(pageDate.year, pageDate.month, i);
      final isSelected = date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;

      week.add(_buildDate(date, isSelected));

      if (week.length == 7) {
        rows.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: week),
        ));
        week = [];
      }
    }

    // Pad trailing empty slots for the last week
    if (week.isNotEmpty) {
      while (week.length < 7) {
        week.add(const SizedBox(width: 32, height: 32));
      }
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: week),
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }

  Widget _buildDate(DateTime date, bool isSelected) {
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

    final formattedAccessibilityDate = DateFormat('EEEE, MMMM d, y').format(date);

    return Semantics(
      label: isSelected
          ? 'Selected date, $formattedAccessibilityDate'
          : isToday
              ? 'Today, $formattedAccessibilityDate'
              : formattedAccessibilityDate,
      button: true,
      selected: isSelected,
      child: Container(
        width: 32,
        height: 32,
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: InkWell(
          onTap: () {
            ref.read(selectedDateProvider.notifier).selectDate(date);
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            alignment: Alignment.center,
            decoration: isSelected
                ? BoxDecoration(
                    color: const Color(0xFFDF9F49),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(1, 2),
                        blurRadius: 2,
                      ),
                    ],
                  )
                : isToday
                    ? BoxDecoration(
                        border: Border.all(color: const Color(0xFFDF9F49), width: 1.5),
                        borderRadius: BorderRadius.circular(4),
                      )
                    : null,
            child: Text(
              '${date.day}',
              style: GoogleFonts.kalam(
                fontSize: 16,
                fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCorner(bool isTop, bool isLeft) {
    return Padding(
      padding: EdgeInsets.only(
        top: isTop ? 4 : 0,
        bottom: isTop ? 0 : 4,
        left: isLeft ? 4 : 0,
        right: isLeft ? 0 : 4,
      ),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          border: Border(
            top: isTop ? const BorderSide(color: Colors.black26, width: 2) : BorderSide.none,
            bottom: !isTop ? const BorderSide(color: Colors.black26, width: 2) : BorderSide.none,
            left: isLeft ? const BorderSide(color: Colors.black26, width: 2) : BorderSide.none,
            right: !isLeft ? const BorderSide(color: Colors.black26, width: 2) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
