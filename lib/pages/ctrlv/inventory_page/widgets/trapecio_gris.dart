import 'dart:ui' as ui;
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size = Size(50, (50 *1.1887905604719764).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter = RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class TrapecioGris extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2519231);
    path_0.cubicTo(0, size.height * 0.1933387, size.width * 0.04871416, size.height * 0.1427385, size.width * 0.1168369, size.height * 0.1305620);
    path_0.lineTo(size.width * 0.8218525, size.height * 0.004547122);
    path_0.cubicTo(size.width * 0.9135988, size.height * -0.01185201, size.width, size.height * 0.04700645, size.width, size.height * 0.1259072);
    path_0.lineTo(size.width, size.height * 0.9461464);
    path_0.cubicTo(size.width, size.height * 0.9881414, size.width * 0.9514366, size.height * 1.018002, size.width * 0.9038673, size.height * 1.005256);
    path_0.lineTo(size.width * 0.1027209, size.height * 0.7905558);
    path_0.cubicTo(size.width * 0.04154071, size.height * 0.7741588, 0, size.height * 0.7263524, 0, size.height * 0.6723400);
    path_0.lineTo(0, size.height * 0.2519231);
    path_0.close();

    canvas.drawShadow(path_0, Colors.grey, 20, false);

    //Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    Paint paint0Fill = Paint()..shader = ui.Gradient.linear(const Offset(0, 0), const Offset(150, 0), <Color>[const ui.Color.fromARGB(255, 249, 248, 248), const Color(0xffE6E6E6)]);
    //paint_0_fill.color = Colors.black;

    // paint_0_fill.color = Color(0xffACB5BB).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
