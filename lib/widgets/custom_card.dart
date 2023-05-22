import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/header.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key, required this.title, this.height, this.width, required this.child});

  final String title;
  final double? height;
  final double? width;
  final Widget child;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(15), bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
          gradient: whiteGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Header(text: widget.title),
          SizedBox(
            height: widget.height! - 65,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
