import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../domain/models/journal_entry.dart';

class MoodTrackingChart extends StatefulWidget {
  final List<JournalEntry> entries;

  const MoodTrackingChart({super.key, required this.entries});

  @override
  State<MoodTrackingChart> createState() => _MoodTrackingChartState();
}

class _MoodTrackingChartState extends State<MoodTrackingChart> {
  String _selectedRange = '7 days';
  final List<String> _ranges = [
    "3 days (don't aggregate days)",
    '7 days',
    '30 days',
    '90 days',
    '365 days'
  ];

  final Map<Mood, int> _moodValues = {
    Mood.sad: 0,
    Mood.stressed: 1,
    Mood.calm: 2,
    Mood.happy: 3,
    Mood.excited: 4,
  };

  final Map<int, String> _moodEmojis = {
    0: '😢',
    1: '🙁',
    2: '😐',
    3: '🙂',
    4: '😊',
  };

  final Map<int, Color> _moodColors = {
    0: const Color(0xFF425360),
    1: const Color(0xFF514B5A),
    2: const Color(0xFF575252),
    3: const Color(0xFF5D5443),
    4: const Color(0xFF4A5D4E),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdown(),
        const SizedBox(height: 16),
        _buildChart(),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedRange,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          dropdownColor: const Color(0xFF2C2C2C),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          isExpanded: true,
          items: _ranges.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedRange = newValue;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildChart() {
    final daysToDisplay = _getDaysForRange();
    final processedData = _processEntries(daysToDisplay);
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final minDate = today.subtract(Duration(days: daysToDisplay - 1));
    final maxDate = today.add(const Duration(days: 1));
    
    final minX = minDate.millisecondsSinceEpoch.toDouble();
    final maxX = maxDate.millisecondsSinceEpoch.toDouble();
    
    List<FlSpot> spots = [];
    for (var point in processedData) {
      spots.add(FlSpot(point.date.millisecondsSinceEpoch.toDouble(), point.moodValue));
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 16, right: 16, bottom: 8),
      child: Stack(
        children: [
          // Custom Background Grid
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 40), // Match reserved sizes
              child: _buildCustomGrid(daysToDisplay),
            ),
          ),
          // FlChart
          LineChart(
            LineChartData(
              minX: minX,
              maxX: maxX,
              minY: -0.5, // Padding for top and bottom so dots don't get clipped
              maxY: 4.5,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value == value.roundToDouble() && value >= 0 && value <= 4) {
                        return Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF8BA58D), // slight background for emoji like in screenshot
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              _moodEmojis[value.toInt()]!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 40,
                    interval: 1,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      // Centering logic: shift it by half a day visually
                      return Transform.translate(
                        offset: const Offset(20, 0), // Push right to roughly center under column
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            DateFormat('dd MMM').format(date),
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    },
                    interval: _getBottomInterval(daysToDisplay),
                    reservedSize: 40,
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.cyan.withValues(alpha: 0.6),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 5,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: _getMoodColor(spot.y),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(double y) {
    return _moodColors[y.round().clamp(0, 4)] ?? Colors.white;
  }

  double _getBottomInterval(int days) {
    if (days <= 7) return const Duration(days: 1).inMilliseconds.toDouble();
    if (days <= 30) return const Duration(days: 7).inMilliseconds.toDouble();
    if (days <= 90) return const Duration(days: 15).inMilliseconds.toDouble();
    return const Duration(days: 60).inMilliseconds.toDouble();
  }

  int _getDaysForRange() {
    switch (_selectedRange) {
      case "3 days (don't aggregate days)": return 3;
      case '7 days': return 7;
      case '30 days': return 30;
      case '90 days': return 90;
      case '365 days': return 365;
      default: return 7;
    }
  }

  Widget _buildCustomGrid(int columns) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        final rowHeight = height / 5;
        final colWidth = width / columns;

        List<Widget> gridCells = [];
        for (int r = 0; r < 5; r++) {
          for (int c = 0; c < columns; c++) {
            final isOddCol = c % 2 != 0;
            final baseColor = _moodColors[4 - r]!; 
            final color = isOddCol ? baseColor.withValues(alpha: 0.7) : baseColor;
            
            gridCells.add(
              Positioned(
                top: r * rowHeight,
                left: c * colWidth,
                width: colWidth,
                height: rowHeight,
                child: Container(
                  color: color,
                ),
              ),
            );
          }
        }

        return Stack(children: gridCells);
      },
    );
  }

  List<_DataPoint> _processEntries(int daysToDisplay) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final sorted = widget.entries.toList()..sort((a, b) => a.date.compareTo(b.date));
    final minDate = today.subtract(Duration(days: daysToDisplay - 1));
    
    if (_selectedRange == "3 days (don't aggregate days)") {
      final recent = sorted.where((e) => e.date.isAfter(minDate)).toList();
      return recent.map((e) => _DataPoint(e.date, _moodValues[e.mood]!.toDouble())).toList();
    }
    
    Map<DateTime, List<int>> grouped = {};
    for (var entry in sorted) {
      final date = DateTime(entry.date.year, entry.date.month, entry.date.day, 12); 
      if (date.isBefore(minDate)) continue;
      
      grouped.putIfAbsent(date, () => []);
      grouped[date]!.add(_moodValues[entry.mood]!);
    }
    
    List<_DataPoint> points = [];
    grouped.forEach((date, values) {
      final avg = values.reduce((a, b) => a + b) / values.length;
      points.add(_DataPoint(date, avg));
    });
    
    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }
}

class _DataPoint {
  final DateTime date;
  final double moodValue;
  _DataPoint(this.date, this.moodValue);
}
