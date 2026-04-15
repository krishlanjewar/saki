import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScrapbookCalendarWidget extends StatelessWidget {
  final DateTime focusedDate;

  const ScrapbookCalendarWidget({super.key, required this.focusedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.15),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                    const SizedBox(width: 16),
                    Text(
                      '${DateFormat('MMM').format(focusedDate)} \u25BC ${focusedDate.year} \u25BC', // Using triangle down for drop downs
                      style: GoogleFonts.kalam(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.arrow_forward, size: 20, color: Colors.black87),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Days of week
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                      .map((d) => Text(
                            d,
                            style: GoogleFonts.kalam(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                
                // Dates Grid (mock)
                _buildDatesGrid(),
              ],
            ),
          ),
          
          // Photo corners
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

  Widget _buildDatesGrid() {
    List<Widget> rows = [];
    List<Widget> week = [];
    
    // Calculate first day of month (1 = Monday, 7 = Sunday)
    DateTime firstDayOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    int startingWeekday = firstDayOfMonth.weekday; // 1 to 7

    // Calculate days in month
    int daysInMonth = DateTime(focusedDate.year, focusedDate.month + 1, 0).day;
    
    // Current date for highlighting
    DateTime now = DateTime.now();
    bool isCurrentMonth = now.year == focusedDate.year && now.month == focusedDate.month;
    int currentDay = now.day;

    // Add empty slots before the 1st
    for (int i = 1; i < startingWeekday; i++) {
       week.add(const SizedBox(width: 28)); // Match the size of _buildDate container
    }

    // Add dates
    for (int i = 1; i <= daysInMonth; i++) {
        bool isHighlighted = isCurrentMonth && i == currentDay;
        week.add(_buildDate(i, isHighlighted));
        
        if (week.length == 7) {
            rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: week));
            week = [];
        }
    }

    // Add empty slots after the last day
    if (week.isNotEmpty) {
        while (week.length < 7) {
            week.add(const SizedBox(width: 28));
        }
        rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: week));
    }

    return Column(children: rows);
  }

  Widget _buildDate(int date, bool isHighlighted) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: isHighlighted
          ? BoxDecoration(
              color: const Color(0xFFDF9F49),
              borderRadius: BorderRadius.circular(2),
            )
          : null,
      child: Text(
        '$date',
        style: GoogleFonts.kalam(
          fontSize: 16,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
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
           )
         ),
      ),
    );
  }
}
