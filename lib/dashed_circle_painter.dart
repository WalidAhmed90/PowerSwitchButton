import 'package:flutter/material.dart';
import 'dart:math';
import 'enum.dart';

/// A custom painter for drawing dashed shapes (circle or rounded rectangle) on a canvas.
class DashedShapePainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth1;
  final double dashSpace1;
  final Color strokeColor;
  final Shape shape;
  final double? borderRadius;

  /// Creates a [DashedShapePainter] with the given properties.
  ///
  /// - [strokeWidth]: The width of the dashed stroke as a percentage of the shape's size.
  /// - [dashWidth1]: The width of each dash as a percentage of the shape's size.
  /// - [dashSpace1]: The space between dashes as a percentage of the shape's size.
  /// - [strokeColor]: The color of the dashed stroke.
  /// - [shape]: The shape to be drawn (CIRCLE or SQUARE).
  /// - [borderRadius]: The border radius for rounded rectangles. Ignored for circles.
  DashedShapePainter({
    required this.strokeWidth,
    required this.dashWidth1,
    required this.dashSpace1,
    required this.strokeColor,
    required this.shape,
    this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * (strokeWidth / 100);

    switch (shape) {
      case Shape.CIRCLE:
        _drawDashedCircle(canvas, size, paint);
        break;
      case Shape.SQUARE:
        _drawDashedRoundedRect(canvas, size, paint);
        break;
    }
  }

  /// Draws a dashed circle on the canvas.
  ///
  /// - [canvas]: The canvas to draw on.
  /// - [size]: The size of the canvas.
  /// - [paint]: The paint used to draw the dashes.
  void _drawDashedCircle(Canvas canvas, Size size, Paint paint) {
    final radius = size.width / 2;
    final circumference = 2 * pi * radius;
    final dashWidth = size.width * (dashWidth1 / 100);
    final dashSpace = size.width * (dashSpace1 / 100);
    final dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final adjustedDashSpace =
        (circumference - (dashWidth * dashCount)) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * (dashWidth + adjustedDashSpace)) / radius;
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
    }
  }

  /// Draws a dashed rounded rectangle on the canvas.
  ///
  /// - [canvas]: The canvas to draw on.
  /// - [size]: The size of the canvas.
  /// - [paint]: The paint used to draw the dashes.
  void _drawDashedRoundedRect(Canvas canvas, Size size, Paint paint) {
    final radius = borderRadius ?? 0.0;
    final rect = Rect.fromLTWH(0, 0, size.width, size.width);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final dashLength = size.width * (dashWidth1 / 100);
    final dashSpace = size.width * (dashSpace1 / 100);
    Path path = Path();

    // Draw each side with dashed lines
    _addDashedPath(path, rrect, dashLength, dashSpace);

    canvas.drawPath(path, paint);
  }

  /// Adds a dashed path to the given [path].
  ///
  /// - [path]: The path to add dashed lines to.
  /// - [rrect]: The rounded rectangle to draw dashes around.
  /// - [dashLength]: The length of each dash.
  /// - [dashSpace]: The space between dashes.
  void _addDashedPath(
      Path path, RRect rrect, double dashLength, double dashSpace) {
    final rect = rrect;
    final radius = rrect.trRadiusX;

    // Helper function to add dashed lines
    void addDashedSegment(Path path, Offset start, Offset end,
        double dashLength, double dashSpace) {
      final length = (end - start).distance;
      final dashCount = (length / (dashLength + dashSpace)).floor();
      final dashGap = (length - (dashLength * dashCount)) / dashCount;

      for (int i = 0; i < dashCount; i++) {
        final startOffset =
            start + (end - start) * (i * (dashLength + dashGap)) / length;
        final endOffset = start +
            (end - start) *
                ((i * (dashLength + dashGap)) + dashLength) /
                length;
        path.moveTo(startOffset.dx, startOffset.dy);
        path.lineTo(endOffset.dx, endOffset.dy);
      }
    }

    // Top side
    addDashedSegment(path, Offset(rect.left + radius, rect.top),
        Offset(rect.right - radius, rect.top), dashLength, dashSpace);
    // Right side
    addDashedSegment(path, Offset(rect.right, rect.top + radius),
        Offset(rect.right, rect.bottom - radius), dashLength, dashSpace);
    // Bottom side
    addDashedSegment(path, Offset(rect.right - radius, rect.bottom),
        Offset(rect.left + radius, rect.bottom), dashLength, dashSpace);
    // Left side
    addDashedSegment(path, Offset(rect.left, rect.bottom - radius),
        Offset(rect.left, rect.top + radius), dashLength, dashSpace);

    // Add rounded corners
    void addDashedArc(
        Path path, Rect rect, double startAngle, double sweepAngle) {
      path.addArc(rect, startAngle, sweepAngle);
    }

    // Top-left corner
    addDashedArc(path,
        Rect.fromLTWH(rect.left, rect.top, radius * 2, radius * 2), pi, pi / 2);
    // Top-right corner
    addDashedArc(
        path,
        Rect.fromLTWH(
            rect.right - radius * 2, rect.top, radius * 2, radius * 2),
        -pi / 2,
        pi / 2);
    // Bottom-right corner
    addDashedArc(
        path,
        Rect.fromLTWH(rect.right - radius * 2, rect.bottom - radius * 2,
            radius * 2, radius * 2),
        0,
        pi / 2);
    // Bottom-left corner
    addDashedArc(
        path,
        Rect.fromLTWH(
            rect.left, rect.bottom - radius * 2, radius * 2, radius * 2),
        pi / 2,
        pi / 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
