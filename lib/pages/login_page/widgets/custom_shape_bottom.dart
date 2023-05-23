import 'package:flutter/material.dart';

class CustomShapeBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(143, 0);
    path0.quadraticBezierTo(31.98, 199.6, 32.06, 276.92);
    path0.cubicTo(24.2, 340.73, 144.14, 422.4, 143, 486.11);
    path0.quadraticBezierTo(136.26, 557.1, 42.05, 642);
    path0.lineTo(0, 642);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
