import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final double targetValue;
  final String text;
  final String leftText;
  LineChartPainter({
    required this.targetValue,
    required this.text,
    required this.leftText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;

    double startX = 20;
    double endX = size.width - 20;
    double startY = size.height - 20;
    double endY = 20;

    // Draw lines along x and y axis
    canvas.drawLine(Offset(startX, startY), Offset(endX, startY), linePaint);
    canvas.drawLine(Offset(startX, startY), Offset(startX, endY), linePaint);

    double targetX = (endX - startX) * targetValue + startX;
    double targetY = startY;

    Paint targetPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0;

    // Draw target point and line from (0,0) to target point
    canvas.drawCircle(Offset(targetX, targetY), 5, targetPaint);
    canvas.drawLine(
        Offset(targetX, startY), Offset(targetX, targetY), targetPaint);
    canvas.drawLine(
        Offset(startX, startY), Offset(targetX, startY), targetPaint);

    // Draw vertical lines at each x-axis point
    final double stepSize = 0.1;
    for (double i = 0.1; i <= 1; i += stepSize) {
      double xPos = (endX - startX) * i + startX;
      canvas.drawLine(
          Offset(xPos, startY), Offset(xPos, startY - 20), linePaint);

      // Draw line at the bottom of the x-axis point
      canvas.drawLine(
          Offset(xPos, startY), Offset(xPos, startY + 5), linePaint);
    }

    TextSpan span = TextSpan(
      style: const TextStyle(color: Colors.black),
      text: text,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    TextSpan leftspan = TextSpan(
      style: const TextStyle(color: Colors.black),
      text: leftText,
    );

    TextPainter tpleft = TextPainter(
      text: leftspan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, Offset(1, 0));

    for (double i = 0.1; i <= 1; i += stepSize) {
      TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.black),
        text: i.toStringAsFixed(1),
      );

      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tpleft.layout();
      tpleft.paint(canvas, const Offset(0, 20));
      tp.layout();
      double xPos = (endX - startX) * i + startX - tp.width / 2;
      tp.paint(canvas, Offset(xPos, startY + 5)); // Offset for y position
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
