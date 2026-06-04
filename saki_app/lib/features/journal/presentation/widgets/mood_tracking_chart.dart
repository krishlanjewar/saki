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
  String _selectedRange = '7 Days'; // default
  final List<String> _ranges = [
    '3 Days',
    '7 Days',
    '30 Days',
    '90 Days',
    '365 Days'
  ];

  final Map<Mood, int> _moodValues = {
    Mood.sad: 0,
    Mood.stressed: 1,
    Mood.calm: 2,
    Mood.happy: 3,
    Mood.excited: 4,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = theme.colorScheme.surface;
    
    return Card(
      elevation: isDark ? 4 : 1,
      shadowColor: isDark ? Colors.black45 : Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildChartArea(context),
            const SizedBox(height: 16),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final containerColor = isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100;
    final outlineColor = isDark ? Colors.white10 : Colors.black12;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mood Analytics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: onSurface,
            letterSpacing: -0.5,
          ),
        ),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: outlineColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedRange,
              icon: Icon(Icons.keyboard_arrow_down, color: theme.colorScheme.onSurfaceVariant, size: 20),
              dropdownColor: containerColor,
              style: TextStyle(
                color: onSurface, 
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              borderRadius: BorderRadius.circular(12),
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
        ),
      ],
    );
  }

  Widget _buildChartArea(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          // 1. Background Zones
          Positioned(
            left: 40,
            right: 0,
            top: 0,
            bottom: 40, // Reserved for X-axis labels
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.green.withValues(alpha: 0.06))),
                Expanded(child: Container(color: Colors.orange.withValues(alpha: 0.06))),
                Expanded(child: Container(color: Colors.grey.withValues(alpha: 0.06))),
                Expanded(child: Container(color: Colors.purple.withValues(alpha: 0.06))),
                Expanded(child: Container(color: Colors.blue.withValues(alpha: 0.06))),
              ],
            ),
          ),
          
          // 2. Scrollable Chart
          Positioned.fill(
            left: 40,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartWidth = _calculateChartWidth(constraints.maxWidth);
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true, // Auto-scroll to most recent (right)
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: chartWidth,
                    child: _buildLineChart(context),
                  ),
                );
              },
            ),
          ),
          
          // 3. Fixed Y-axis (Emojis)
          Positioned(
            left: 0,
            top: 0,
            bottom: 40,
            width: 40,
            child: const Column(
              children: [
                Expanded(child: Center(child: Text('😊', style: TextStyle(fontSize: 20)))),
                Expanded(child: Center(child: Text('🙂', style: TextStyle(fontSize: 20)))),
                Expanded(child: Center(child: Text('😐', style: TextStyle(fontSize: 20)))),
                Expanded(child: Center(child: Text('🙁', style: TextStyle(fontSize: 20)))),
                Expanded(child: Center(child: Text('😢', style: TextStyle(fontSize: 20)))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart(BuildContext context) {
    final points = _processEntries();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.colorScheme.surface;
    final onSurfaceVariant = theme.colorScheme.onSurfaceVariant;
    final tooltipBg = isDark ? const Color(0xFF2A2A2A) : Colors.white;
    
    int days = 7;
    bool groupByDay = true;
    switch (_selectedRange) {
      case '3 Days': days = 3; groupByDay = false; break;
      case '7 Days': days = 7; break;
      case '30 Days': days = 30; break;
      case '90 Days': days = 90; break;
      case '365 Days': days = 365; break;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startDate = today.subtract(Duration(days: days - 1));
    
    final dayInMillis = const Duration(days: 1).inMilliseconds.toDouble();
    
    // Calculate minX and maxX with padding so points aren't cut off at edges
    double minX, maxX;
    if (groupByDay) {
      minX = startDate.millisecondsSinceEpoch.toDouble() - (dayInMillis * 0.5);
      maxX = today.millisecondsSinceEpoch.toDouble() + (dayInMillis * 0.5);
    } else {
      final minTime = now.subtract(const Duration(days: 3));
      minX = minTime.millisecondsSinceEpoch.toDouble() - (dayInMillis * 0.2);
      maxX = now.millisecondsSinceEpoch.toDouble() + (dayInMillis * 0.2);
    }

    return LineChart(
      LineChartData(
        minY: -0.5,
        maxY: 4.5,
        minX: minX,
        maxX: maxX,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: _getIntervalForRange(),
              getTitlesWidget: (value, meta) {
                if (value == minX || value == maxX) return const SizedBox.shrink();
                if (value == meta.min || value == meta.max) return const SizedBox.shrink();
                if (value < minX || value > maxX) return const SizedBox.shrink();
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    DateFormat(groupByDay ? 'MMM d' : 'E HH:mm').format(date),
                    style: TextStyle(color: onSurfaceVariant, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => tooltipBg.withValues(alpha: 0.95),
            getTooltipItems: (touchedSpots) {
              final avgSpot = touchedSpots.firstWhere((s) => s.barIndex == 0, orElse: () => touchedSpots.first);
              
              final pointIdx = points.indexWhere((p) => (p.xValue - avgSpot.x).abs() < 1.0);
              if (pointIdx == -1) return []; // Fallback
              
              final point = points[pointIdx];

              return touchedSpots.map((spot) {
                if (spot.barIndex != 0) return null;
                
                return LineTooltipItem(
                  '${DateFormat('MMM d, yyyy').format(point.date)}\n',
                  TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 14),
                  children: [
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Avg: ${_getMoodLabel(point.average.round())}\n',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    if (point.count > 1)
                      TextSpan(
                        text: 'Range: ${_getMoodEmoji(point.max.round())} to ${_getMoodEmoji(point.min.round())}\n',
                        style: TextStyle(color: onSurfaceVariant, fontSize: 13),
                      ),
                    TextSpan(
                      text: '${point.count} ${point.count == 1 ? 'entry' : 'entries'}',
                      style: TextStyle(color: onSurfaceVariant.withValues(alpha: 0.8), fontSize: 12),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: points.isEmpty ? [] : [
          // 0: Average Line
          LineChartBarData(
            spots: points.map((p) => FlSpot(p.xValue, p.average)).toList(),
            isCurved: true,
            preventCurveOverShooting: true,
            color: primaryColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: surfaceColor,
                  strokeWidth: 2,
                  strokeColor: primaryColor,
                );
              },
            ),
            shadow: Shadow(color: primaryColor.withValues(alpha: 0.5), blurRadius: 6),
          ),
          // 1: Max Line (invisible, for shaded area)
          LineChartBarData(
            spots: points.map((p) => FlSpot(p.xValue, p.max)).toList(),
            isCurved: true,
            preventCurveOverShooting: true,
            color: Colors.transparent,
            barWidth: 0,
            dotData: const FlDotData(show: false),
          ),
          // 2: Min Line (invisible, for shaded area)
          LineChartBarData(
            spots: points.map((p) => FlSpot(p.xValue, p.min)).toList(),
            isCurved: true,
            preventCurveOverShooting: true,
            color: Colors.transparent,
            barWidth: 0,
            dotData: const FlDotData(show: false),
          ),
        ],
        betweenBarsData: points.isEmpty ? [] : [
          BetweenBarsData(
            fromIndex: 1,
            toIndex: 2,
            color: primaryColor.withValues(alpha: 0.15),
          )
        ],
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final containerColor = isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100;
    final outlineColor = isDark ? Colors.white10 : Colors.black12;
    final onSurfaceVariant = theme.colorScheme.onSurfaceVariant;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: containerColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: outlineColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: theme.colorScheme.primary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: onSurfaceVariant, fontSize: 12, height: 1.5),
                children: const [
                  TextSpan(text: 'If there are multiple entries during the day:\n', style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: '• Shaded area = mood range during the day.\n'),
                  TextSpan(text: '• Line and markers = daily average mood.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---

  double _calculateChartWidth(double availableWidth) {
    int days = 7;
    double pixelsPerDay = 80;
    
    switch (_selectedRange) {
      case '3 Days': days = 3; pixelsPerDay = 150; break;
      case '7 Days': days = 7; pixelsPerDay = 80; break;
      case '30 Days': days = 30; pixelsPerDay = 50; break;
      case '90 Days': days = 90; pixelsPerDay = 25; break;
      case '365 Days': days = 365; pixelsPerDay = 10; break;
    }
    
    double calculatedWidth = days * pixelsPerDay;
    return calculatedWidth > availableWidth ? calculatedWidth : availableWidth;
  }

  double _getIntervalForRange() {
    const day = 24 * 3600 * 1000.0;
    switch (_selectedRange) {
      case '3 Days': return day / 2; // 12 hours
      case '7 Days': return day;
      case '30 Days': return day * 2;
      case '90 Days': return day * 7;
      case '365 Days': return day * 30;
      default: return day;
    }
  }

  String _getMoodLabel(int value) {
    switch (value) {
      case 4: return 'Very Happy';
      case 3: return 'Happy';
      case 2: return 'Neutral';
      case 1: return 'Sad';
      case 0: return 'Very Sad';
      default: return 'Unknown';
    }
  }

  String _getMoodEmoji(int value) {
    switch (value) {
      case 4: return '😊';
      case 3: return '🙂';
      case 2: return '😐';
      case 1: return '🙁';
      case 0: return '😢';
      default: return '😐';
    }
  }

  List<_ChartPoint> _processEntries() {
    final sorted = List<JournalEntry>.from(widget.entries)..sort((a, b) => a.date.compareTo(b.date));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    int days = 7;
    bool groupByDay = true;
    switch (_selectedRange) {
      case '3 Days': days = 3; groupByDay = false; break;
      case '7 Days': days = 7; break;
      case '30 Days': days = 30; break;
      case '90 Days': days = 90; break;
      case '365 Days': days = 365; break;
    }
    
    final startDate = today.subtract(Duration(days: days - 1));
    List<_ChartPoint> points = [];
    
    if (groupByDay) {
      Map<DateTime, List<JournalEntry>> grouped = {};
      for (var e in sorted) {
        if (e.date.isBefore(startDate)) continue;
        final d = DateTime(e.date.year, e.date.month, e.date.day);
        grouped.putIfAbsent(d, () => []).add(e);
      }
      
      grouped.forEach((date, dayEntries) {
        double sum = 0;
        double min = 5;
        double max = -1;
        for (var e in dayEntries) {
          final val = _moodValues[e.mood]?.toDouble() ?? 2.0;
          sum += val;
          if (val < min) min = val;
          if (val > max) max = val;
        }
        points.add(_ChartPoint(
          date: date,
          average: sum / dayEntries.length,
          min: min,
          max: max,
          count: dayEntries.length,
          entries: dayEntries,
          xValue: date.millisecondsSinceEpoch.toDouble(),
        ));
      });
    } else {
      // 3 Days - No grouping
      final minTime = now.subtract(const Duration(days: 3));
      for (var e in sorted) {
        if (e.date.isBefore(minTime)) continue;
        final val = _moodValues[e.mood]?.toDouble() ?? 2.0;
        points.add(_ChartPoint(
          date: e.date,
          average: val,
          min: val,
          max: val,
          count: 1,
          entries: [e],
          xValue: e.date.millisecondsSinceEpoch.toDouble(),
        ));
      }
    }
    
    points.sort((a, b) => a.xValue.compareTo(b.xValue));
    return points;
  }
}

class _ChartPoint {
  final DateTime date;
  final double average;
  final double min;
  final double max;
  final int count;
  final List<JournalEntry> entries;
  final double xValue;

  _ChartPoint({
    required this.date,
    required this.average,
    required this.min,
    required this.max,
    required this.count,
    required this.entries,
    required this.xValue,
  });
}
