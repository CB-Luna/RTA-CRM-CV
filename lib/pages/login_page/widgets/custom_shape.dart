import 'package:flutter/material.dart';

class CustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(143, 0);
    path0.quadraticBezierTo(37.24, 214.24, 32.06, 276.92);
    path0.cubicTo(17.65, 322.86, 145.54, 439.78, 143, 485.98);
    path0.quadraticBezierTo(147.15, 530.02, 42.05, 642);
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
