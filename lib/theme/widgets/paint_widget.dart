import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final double animationValue;

  LinePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withValues(alpha: .5)
          ..strokeWidth = 2;

    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset((i + animationValue) % size.width, i), Offset((i + animationValue) % size.width, i + 10), paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) => true;
}
