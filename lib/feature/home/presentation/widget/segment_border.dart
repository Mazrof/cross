import 'package:flutter/material.dart';

class SegmentedBorderPainter extends CustomPainter {
  final int segments;
  final int numOfSeen;
  final bool isSeen;

  SegmentedBorderPainter({
    required this.segments,
    required this.numOfSeen,
    required this.isSeen,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isSeen ? Colors.grey : Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double segmentAngle = 360 / segments;

    for (int i = 0; i < segments; i++) {
      final double startAngle = (i * segmentAngle) * (3.14 / 180);
      final double sweepAngle = (segmentAngle - 2) * (3.14 / 180);

      paint.color = i < numOfSeen ? Colors.grey : Colors.green;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
