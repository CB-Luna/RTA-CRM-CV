import 'package:flutter/material.dart';

import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.child,
    this.padding = const EdgeInsets.all(10.0),
  });

  final String title;
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets padding;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.of(context).primaryColor, width: 2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          gradient: whiteGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CardHeader(text: widget.title),
            SizedBox(
              height: widget.height != null ? widget.height! - 65 : null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RawScrollbar(
                  thumbColor: AppTheme.of(context).primaryColor,
                  radius: const Radius.circular(15),
                  thickness: 7,
                  thumbVisibility: true,
                  child: SingleChildScrollView(child: widget.child),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
