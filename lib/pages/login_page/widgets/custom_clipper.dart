import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.02163011, size.height * 0.2989932);
    path0.cubicTo(size.width * 0.09442878, size.height * 0.1572627,
        size.width * 0.1914933, 0, size.width * 0.1914933, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.9998828);
    path0.lineTo(size.width * 0.7705733, size.height * 0.9998828);
    path0.cubicTo(
        size.width * 0.7705733,
        size.height * 0.9998828,
        size.width * 0.04810233,
        size.height * 1.009590,
        size.width * 0.006187967,
        size.height * 0.8542666);
    path0.cubicTo(
        size.width * -0.03572644,
        size.height * 0.6989453,
        size.width * 0.1495789,
        size.height * 0.6678809,
        size.width * 0.1341367,
        size.height * 0.5630391);
    path0.cubicTo(
        size.width * 0.1186944,
        size.height * 0.4581973,
        size.width * -0.05116856,
        size.height * 0.4407236,
        size.width * 0.02163011,
        size.height * 0.2989932);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
