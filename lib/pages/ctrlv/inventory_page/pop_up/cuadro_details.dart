import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// //Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(400, (400*0.7586633663366337).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.04893964);
    path_0.cubicTo(0, size.height * 0.02191093, size.width * 0.01662314, 0, size.width * 0.03712871, 0);
    path_0.lineTo(size.width * 0.7553045, 0);
    path_0.cubicTo(size.width * 0.7687983, 0, size.width * 0.7812290, size.height * 0.009649608, size.width * 0.7877735, size.height * 0.02520375);
    path_0.lineTo(size.width * 0.9773948, size.height * 0.4758760);
    path_0.cubicTo(size.width * 0.9837389, size.height * 0.4909511, size.width * 0.9835965, size.height * 0.5093148, size.width * 0.9770210, size.height * 0.5242153);
    path_0.lineTo(size.width * 0.7879072, size.height * 0.9528254);
    path_0.cubicTo(size.width * 0.7812587, size.height * 0.9678923, size.width * 0.7690347, size.height * 0.9771615, size.width * 0.7558106, size.height * 0.9771615);
    path_0.lineTo(size.width * 0.03712871, size.height * 0.9771615);
    path_0.cubicTo(size.width * 0.01662302, size.height * 0.9771615, 0, size.height * 0.9552512, 0, size.height * 0.9282219);
    path_0.lineTo(0, size.height * 0.04893964);
    path_0.close();
    canvas.drawShadow(path_0, Colors.grey, 20, false);

    //Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    Paint paint0Fill = Paint()..shader = ui.Gradient.linear(const Offset(0, 0), const Offset(150, 0), <Color>[Colors.blue, const Color(0Xff234FA1)]);
    //paint_0_fill.color = Colors.black;

    // paint_0_fill.color = Color(0xffACB5BB).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
