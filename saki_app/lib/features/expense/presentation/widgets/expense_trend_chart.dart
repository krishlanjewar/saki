import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Draws a smooth multi-series line chart using [CustomPainter].
/// No third-party chart library required.
class ExpenseTrendChart extends StatelessWidget {
  const ExpenseTrendChart({
    super.key,
    required this.debitSeries,
    required this.creditSeries,
    this.labels = const [],
  });

  final List<double> debitSeries;
  final List<double> creditSeries;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    if (debitSeries.isEmpty && creditSeries.isEmpty) {
      return const SizedBox(
        height: 140,
        child: Center(
          child: Text(
            'No data',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 140,
      child: CustomPaint(
        painter: _TrendPainter(
          debitSeries: debitSeries,
          creditSeries: creditSeries,
          labels: labels,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  _TrendPainter({
    required this.debitSeries,
    required this.creditSeries,
    required this.labels,
  });

  final List<double> debitSeries;
  final List<double> creditSeries;
  final List<String> labels;

  static const double _bottomPadding = 24;
  static const double _topPadding = 10;
  static const double _sidePadding = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final allValues = [...debitSeries, ...creditSeries];
    if (allValues.isEmpty) return;

    final maxVal = allValues.reduce(math.max);
    final chartHeight = size.height - _bottomPadding - _topPadding;
    final chartWidth = size.width - _sidePadding * 2;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(40)
      ..strokeWidth = 0.5;
    for (int i = 0; i <= 4; i++) {
      final y = _topPadding + chartHeight * (1 - i / 4);
      canvas.drawLine(
        Offset(_sidePadding, y),
        Offset(size.width - _sidePadding, y),
        gridPaint,
      );
    }

    // Helper: compute Offset for an index/value pair
    Offset pointAt(int index, double value, int total) {
      final x = _sidePadding +
          (total <= 1 ? 0 : (index / (total - 1)) * chartWidth);
      final y = _topPadding + chartHeight * (1 - (value / (maxVal == 0 ? 1 : maxVal)));
      return Offset(x, y);
    }

    // Draw a smooth catmull-rom-like path
    Path buildPath(List<double> series) {
      final path = Path();
      if (series.isEmpty) return path;
      final points = List.generate(
        series.length,
        (i) => pointAt(i, series[i], series.length),
      );
      path.moveTo(points.first.dx, points.first.dy);
      for (int i = 0; i < points.length - 1; i++) {
        final cp1 = Offset(
          (points[i].dx + points[i + 1].dx) / 2,
          points[i].dy,
        );
        final cp2 = Offset(
          (points[i].dx + points[i + 1].dx) / 2,
          points[i + 1].dy,
        );
        path.cubicTo(
          cp1.dx, cp1.dy,
          cp2.dx, cp2.dy,
          points[i + 1].dx, points[i + 1].dy,
        );
      }
      return path;
    }

    // Draw debit line (red)
    if (debitSeries.isNotEmpty) {
      final debitPaint = Paint()
        ..color = const Color(0xFFE57373)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(buildPath(debitSeries), debitPaint);
    }

    // Draw credit line (green)
    if (creditSeries.isNotEmpty) {
      final creditPaint = Paint()
        ..color = const Color(0xFF66BB6A)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(buildPath(creditSeries), creditPaint);
    }

    // Draw x-axis labels
    if (labels.isNotEmpty) {
      final textStyle = TextStyle(
        color: Colors.grey.shade600,
        fontSize: 9,
      );
      final total = labels.length;
      for (int i = 0; i < total; i++) {
        final x = _sidePadding + (total <= 1 ? 0 : (i / (total - 1)) * chartWidth);
        final tp = TextPainter(
          text: TextSpan(text: labels[i], style: textStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(
          canvas,
          Offset(x - tp.width / 2, size.height - tp.height),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_TrendPainter oldDelegate) =>
      oldDelegate.debitSeries != debitSeries ||
      oldDelegate.creditSeries != creditSeries;
}
