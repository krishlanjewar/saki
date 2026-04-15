import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class AnalysisChart extends StatelessWidget {
  final double percentage; // 0.0 to 1.0

  const AnalysisChart({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFFBE48D), // yellowish center
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(100, 100),
            painter: _ChartPainter(percentage),
          ),
          Text(
            '${(percentage * 100).toInt()}%',
            style: GoogleFonts.kalam(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final double percentage;

  _ChartPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4; // leave room for stroke

    final paintBase = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = Colors.black87;

    // Outer black circle
    canvas.drawCircle(center, radius, paintBase);

    // Three colored segments
    final rect = Rect.fromCircle(center: center, radius: radius);
    
    // Green (0 to ~120 degrees)
    final greenPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = const Color(0xFF1ADE23);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 0.9, false, greenPaint);

    // Yellow (~120 to ~240 degrees)
    final yellowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = const Color(0xFFE3CA24);
    canvas.drawArc(rect, -math.pi / 2 + math.pi * 0.9, math.pi * 0.5, false, yellowPaint);

    // Red (~240 to 360 degrees)
    final redPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = const Color(0xFFE52920);
    canvas.drawArc(rect, -math.pi / 2 + math.pi * 1.4, math.pi * 0.6, false, redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
