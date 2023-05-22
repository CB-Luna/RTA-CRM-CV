import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(15), bottomRight: Radius.circular(40), bottomLeft: Radius.circular(15)),gradient: blueGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(4), bottomRight: Radius.circular(30), bottomLeft: Radius.circular(4)),gradient: blueRadial,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
