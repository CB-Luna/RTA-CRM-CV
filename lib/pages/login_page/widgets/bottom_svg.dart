import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomSVG extends StatelessWidget {
  const BottomSVG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.zero,
      width: size.width,
      height: size.height * 0.202,
      child: SvgPicture.asset(
        'assets/images/bottom_svg.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}
