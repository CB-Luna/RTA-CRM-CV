import 'package:flutter/material.dart';
import 'package:rta_crm_cv/functions/sizes.dart';

import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomeMarcador extends StatefulWidget {
  const CustomeMarcador({
    super.key,
    this.height,
    this.width,
    this.icon,
    /* required this.child, */
    required this.titulo,
    required this.text,
    this.padding = const EdgeInsets.all(0),
  });

  final double? height;
  final double? width;
  //final Widget child;
  final EdgeInsets padding;
  final IconData? icon;
  final String titulo, text;

  @override
  State<CustomeMarcador> createState() => _CustomeMarcadorState();
}

class _CustomeMarcadorState extends State<CustomeMarcador> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border:
              Border.all(color: AppTheme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          gradient: whiteGradient,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: getWidth(60, context),
                    height: getHeight(60, context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.of(context).primaryColor.withOpacity(.2),
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppTheme.of(context).primaryColor,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'UniNeue',
                  fontSize: 20,
                  color: AppTheme.of(context).primaryText),
            ),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'UniNeue',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: AppTheme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
