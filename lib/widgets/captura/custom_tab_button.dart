import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTabButton extends StatefulWidget {
  const CustomTabButton({
    super.key,
    this.enabled = true,
    required this.on,
    required this.label,
    required this.option1,
    required this.option2,
    this.color,
    this.onTap,
    this.width,
  });

  final bool enabled;
  final double? width;
  final bool on;
  final String label;
  final String option1;
  final String option2;
  final Color? color;
  final Function()? onTap;

  @override
  State<CustomTabButton> createState() => CustomTabButtonState();
}

class CustomTabButtonState extends State<CustomTabButton> {
  bool hover1 = false;
  bool pressing1 = false;
  bool hover2 = false;
  bool pressing2 = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(widget.label, style: TextStyle(fontSize: 16, color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color)),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: widget.enabled ? widget.onTap : null,
                onTapDown: (details) {
                  setState(() {
                    if (widget.enabled) {
                      pressing1 = true;
                    }
                  });
                },
                onTapUp: (details) {
                  setState(() {
                    pressing1 = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    pressing1 = false;
                  });
                },
                child: MouseRegion(
                  child: AnimatedContainer(
                    height: 35,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                        color: widget.on
                            ? widget.enabled
                                ? AppTheme.of(context).primaryColor
                                : AppTheme.of(context).hintText.color
                            : AppTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 3,
                            offset: Offset(
                              0,
                              pressing1
                                  ? -2
                                  : hover1
                                      ? 5
                                      : 0,
                            ), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Center(
                        child: Text(
                          widget.option1,
                          style: TextStyle(
                              fontSize: 14,
                              color: widget.on
                                  ? AppTheme.of(context).primaryBackground
                                  : widget.enabled
                                      ? AppTheme.of(context).primaryColor
                                      : AppTheme.of(context).hintText.color),
                        ),
                      ),
                    ),
                  ),
                  onEnter: (event) {
                    setState(() {
                      if (widget.enabled) {
                        hover1 = true;
                      }
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      hover1 = false;
                    });
                  },
                ),
              ),
              GestureDetector(
                onTap: widget.enabled ? widget.onTap : null,
                onTapDown: (details) {
                  setState(() {
                    if (widget.enabled) {
                      pressing2 = true;
                    }
                  });
                },
                onTapUp: (details) {
                  setState(() {
                    pressing2 = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    pressing2 = false;
                  });
                },
                child: MouseRegion(
                  child: AnimatedContainer(
                    height: 35,
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                        color: !widget.on
                            ? widget.enabled
                                ? AppTheme.of(context).primaryColor
                                : AppTheme.of(context).hintText.color
                            : AppTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.1,
                            blurRadius: 3,
                            offset: Offset(
                              0,
                              pressing2
                                  ? -2
                                  : hover2
                                      ? 5
                                      : 0,
                            ), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Center(
                        child: Text(
                          widget.option2,
                          style: TextStyle(
                              fontSize: 14,
                              color: !widget.on
                                  ? AppTheme.of(context).primaryBackground
                                  : widget.enabled
                                      ? AppTheme.of(context).primaryColor
                                      : AppTheme.of(context).hintText.color),
                        ),
                      ),
                    ),
                  ),
                  onEnter: (event) {
                    setState(() {
                      if (widget.enabled) {
                        hover2 = true;
                      }
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      hover2 = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
