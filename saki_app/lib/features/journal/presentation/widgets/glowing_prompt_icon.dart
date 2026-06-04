import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A glowing icon that toggles an animated gradient border on tap.
class GlowingPromptIcon extends StatefulWidget {
  const GlowingPromptIcon({super.key});

  @override
  State<GlowingPromptIcon> createState() => _GlowingPromptIconState();
}

class _GlowingPromptIconState extends State<GlowingPromptIcon> with SingleTickerProviderStateMixin {
  bool _isTapped = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTap() {
    setState(() {
      _isTapped = !_isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner glow effect
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.6),
                    blurRadius: 12,
                    spreadRadius: 4,
                  ),
                  BoxShadow(
                    color: Colors.yellow.withValues(alpha: 0.8),
                    blurRadius: 20,
                    spreadRadius: 6,
                  ),
                ],
              ),
            ),
            
            // Animated gradient border
            if (_isTapped)
              Positioned.fill(
                child: CustomPaint(
                  painter: _GradientBorderPainter(animation: _controller),
                ),
              ),
              
            // Core icon
            const Icon(
              Icons.lightbulb_outline,
              color: Colors.yellowAccent,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final Animation<double> animation;

  _GradientBorderPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Colors.purple,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.orange,
          Colors.red,
          Colors.purple,
        ],
        transform: GradientRotation(animation.value * 2 * math.pi),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    canvas.drawCircle(rect.center, (size.width / 2) - 2.5, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
