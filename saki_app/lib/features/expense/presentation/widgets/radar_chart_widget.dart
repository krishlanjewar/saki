import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/models/transaction.dart';

/// Spider/radar chart that visualises spending by [ExpenseCategory].
class RadarChart extends StatelessWidget {
  const RadarChart({
    super.key,
    required this.values,
  });

  /// Normalised values per category (0.0 – 1.0). Keys are [ExpenseCategory].
  final Map<ExpenseCategory, double> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: CustomPaint(
        painter: _RadarPainter(values: values),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.values});

  final Map<ExpenseCategory, double> values;

  static const List<String> _labels = [
    'FOOD',
    'TRANSPORT',
    'GIFTS',
    'BOOKS',
    'CLOTHES',
    'OTHERS',
  ];

  static const List<ExpenseCategory> _order = [
    ExpenseCategory.food,
    ExpenseCategory.transport,
    ExpenseCategory.gifts,
    ExpenseCategory.books,
    ExpenseCategory.clothes,
    ExpenseCategory.others,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 28;
    final sides = _order.length;

    // Grid webs
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(60)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (int ring = 1; ring <= 4; ring++) {
      final path = Path();
      for (int i = 0; i < sides; i++) {
        final angle = (2 * math.pi * i / sides) - math.pi / 2;
        final r = radius * ring / 4;
        final point = Offset(
          center.dx + r * math.cos(angle),
          center.dy + r * math.sin(angle),
        );
        i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Spoke lines
    final spokePaint = Paint()
      ..color = Colors.grey.withAlpha(60)
      ..strokeWidth = 0.8;
    for (int i = 0; i < sides; i++) {
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final outerPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(center, outerPoint, spokePaint);
    }

    // Data polygon (pink fill)
    final dataPath = Path();
    for (int i = 0; i < sides; i++) {
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final value = values[_order[i]] ?? 0.0;
      final r = radius * value.clamp(0.05, 1.0);
      final point = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
      i == 0 ? dataPath.moveTo(point.dx, point.dy) : dataPath.lineTo(point.dx, point.dy);
    }
    dataPath.close();

    canvas.drawPath(
      dataPath,
      Paint()
        ..color = const Color(0xFFE57373).withAlpha(80)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      dataPath,
      Paint()
        ..color = const Color(0xFFE57373)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // Labels
    final textStyle = const TextStyle(
      color: Color(0xFF555555),
      fontSize: 10,
      fontWeight: FontWeight.w600,
    );
    for (int i = 0; i < sides; i++) {
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final labelRadius = radius + 18;
      final dx = center.dx + labelRadius * math.cos(angle);
      final dy = center.dy + labelRadius * math.sin(angle);
      final tp = TextPainter(
        text: TextSpan(text: _labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();
      tp.paint(canvas, Offset(dx - tp.width / 2, dy - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) =>
      oldDelegate.values != values;
}
