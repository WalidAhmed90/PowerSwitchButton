import 'package:flutter/cupertino.dart';

/// A custom painter that draws a dashed circle.
class DashedCirclePainter extends CustomPainter {
  /// The stroke width of the dashed circle, expressed as a percentage of the size.
  final double strokeWidth;

  /// The width of each dash in the dashed circle, expressed as a percentage of the size.
  final double dashWidth1;

  /// The space between each dash in the dashed circle, expressed as a percentage of the size.
  final double dashSpace1;

  /// The color of the dashed circle.
  final Color strokeColor;

  /// Creates an instance of [DashedCirclePainter].
  ///
  /// The [strokeWidth], [dashWidth1], [dashSpace1], and [strokeColor] must be provided.
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