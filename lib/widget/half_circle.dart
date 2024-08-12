import 'dart:math';

import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class HalfCircle extends StatelessWidget {
  final double rotatinDirection;
  const HalfCircle({
    super.key,
    required this.rotatinDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: rotatinDirection / 2,
        child: Container(
          width: 30,
          height: 40,
          child: CustomPaint(
            painter: HalfCirclePainter(),
          ),
        ),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bWhite
      ..style = PaintingStyle.fill;

    // Define the rectangle that bounds the half circle
    final rect = Rect.fromLTRB(0, 0, size.width, size.height * 1);

    // Draw the half circle
    canvas.drawArc(
      rect,
      -pi, // Start angle (in radians, -pi for half-circle)
      pi, // Sweep angle (in radians, pi for half-circle)
      true, // Use center
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
