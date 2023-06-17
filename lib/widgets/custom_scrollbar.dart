import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomScrollBar extends StatefulWidget {
  const CustomScrollBar({
    super.key,
    required this.child,
    required this.scrollDirection,
  });

  final Widget child;
  final Axis scrollDirection;

  @override
  State<CustomScrollBar> createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  final yourScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller: yourScrollController,
      thumbColor: AppTheme.of(context).primaryColor,
      radius: const Radius.circular(15),
      thickness: 5,
      thumbVisibility: false,
      child: SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        controller: yourScrollController,
        child: widget.child,
      ),
    );
  }
}
