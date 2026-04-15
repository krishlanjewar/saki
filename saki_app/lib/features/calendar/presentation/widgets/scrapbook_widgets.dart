import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrapbookCard extends StatelessWidget {
  final Color color;
  final String title;
  final Widget child;
  final List<TapeDecor>? tapes;
  final bool hasFold;
  final Widget? titleTrailing;

  const ScrapbookCard({
    super.key,
    required this.color,
    required this.title,
    required this.child,
    this.tapes,
    this.hasFold = false,
    this.titleTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: ScrapbookCardPainter(color: color, hasFold: hasFold),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.caveat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      if (titleTrailing != null) titleTrailing!,
                    ],
                  ),
                  const SizedBox(height: 12),
                  child,
                ],
              ),
            ),
          ),
          if (tapes != null) ...tapes!,
        ],
      ),
    );
  }
}

class ScrapbookCardPainter extends CustomPainter {
  final Color color;
  final bool hasFold;

  ScrapbookCardPainter({required this.color, this.hasFold = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final path = Path();
    
    // Top-left
    path.moveTo(0, 0);
    // Top edge
    if (hasFold) {
      path.lineTo(size.width - 30, 0);
      path.lineTo(size.width, 30);
    } else {
      path.lineTo(size.width, 0);
    }
    // Right edge
    path.lineTo(size.width, size.height);
    
    // Bottom edge (torn effect)
    double step = 10.0;
    bool up = true;
    for (double x = size.width; x >= 0; x -= step) {
      path.lineTo(x, size.height - (up ? 4 : 0));
      up = !up;
    }
    path.lineTo(0, size.height);
    
    // Left edge
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path.shift(const Offset(2, 6)), shadowPaint);
    canvas.drawPath(path, paint);
    
    if (hasFold) {
      final foldPath = Path()
        ..moveTo(size.width - 30, 0)
        ..lineTo(size.width - 30, 30)
        ..lineTo(size.width, 30)
        ..close();
      final foldPaint = Paint()
        ..color = Colors.black.withOpacity(0.1)
        ..style = PaintingStyle.fill;
      canvas.drawPath(foldPath, foldPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TapeDecor extends StatelessWidget {
  final Alignment alignment;
  final double angle;
  final Color color;
  final double offsetDx;
  final double offsetDy;
  final bool striped;

  const TapeDecor({
    super.key,
    required this.alignment,
    required this.angle,
    required this.color,
    this.offsetDx = 0,
    this.offsetDy = 0,
    this.striped = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Transform.translate(
          offset: Offset(offsetDx, offsetDy),
          child: Transform.rotate(
            angle: angle,
            child: Container(
              width: 80,
              height: 25,
              decoration: BoxDecoration(
                color: color.withOpacity(0.85),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: striped
                  ? CustomPaint(painter: StripedTapePainter())
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class StripedTapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    for (double i = 0; i < size.width + 20; i += 8) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i - 10, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StickyNote extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String? footer;

  const StickyNote({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(2, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.kalam(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.kalam(
                    fontSize: 13,
                    height: 1.1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (footer != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black.withOpacity(0.05),
              child: Text(
                footer!,
                style: GoogleFonts.kalam(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
