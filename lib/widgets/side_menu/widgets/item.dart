import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/public/colors.dart';

class SideMenuItem extends StatefulWidget {
  const SideMenuItem({
    super.key,
    required this.selected,
    required this.leading,
    this.title,
    required this.onEnter,
    required this.onExit,
    required this.isOpen,
    required this.index,
    required this.onTap,
  });

  final bool isOpen;
  final int index;
  final bool selected;
  final Widget leading;
  final String? title;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final VoidCallback onTap;

  @override
  State<SideMenuItem> createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  @override
  Widget build(BuildContext context) {
    double padding = 25;
    String? title = widget.title;

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          AnimatedContainer(
            height: getHeight(50, context),
            duration: const Duration(milliseconds: 100),
            /* decoration: BoxDecoration(
              color: widget.selected ? primaryColor : null,
              borderRadius: BorderRadius.circular(15),
              boxShadow: widget.selected
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  : null,
            ), */
            child: MouseRegion(
              onEnter: widget.onEnter,
              onExit: widget.onExit,
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: widget.onTap,
                child: Row(
                  mainAxisAlignment: widget.isOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40, width: 40, child: widget.leading),
                    if (title != null && widget.isOpen == true)
                      Text(
                        title,
                        style: TextStyle(
                          color: widget.selected ? selected : unSelected,
                          fontSize: 20,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 2,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: padding),
        ],
      ),
    );
  }
}
