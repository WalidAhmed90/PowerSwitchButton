
import 'package:flutter/cupertino.dart';

class DashedCirclePainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth1;
  final double dashSpace1;
  final Color strokeColor;

  DashedCirclePainter({
    required this.strokeWidth,
    required this.dashWidth1,
    required this.dashSpace1,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * (strokeWidth / 100);

    final radius = size.width / 2;
    final circumference = 2 * 3.141592653589793 * radius;
    final dashWidth = size.width * (dashWidth1 / 100);
    final dashSpace = size.width * (dashSpace1 / 100);
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final adjustedDashSpace = (circumference - (dashWidth * dashCount)) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashWidth + adjustedDashSpace)) / radius;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}