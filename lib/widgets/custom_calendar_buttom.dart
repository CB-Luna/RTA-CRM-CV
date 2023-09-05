import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomCalendarButtom extends StatefulWidget {
  const CustomCalendarButtom({
    super.key,
    this.width,
    this.height = 35,
    required this.isLoading,
    required this.icon,
    required this.text,
    this.style,
    this.onTap,
    this.color,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.enabled,
    this.onTapWidget,
    this.dateRangeField,
  });

  final double? width;
  final double? height;
  final Widget icon;
  final Color? color;
  final String text;
  final TextStyle? style;
  final bool? enabled;
  final bool isLoading;
  final Function()? onTap;
  final Widget? onTapWidget;
  final MainAxisAlignment mainAxisAlignment;
  final DateRangeField? dateRangeField;

  @override
  State<CustomCalendarButtom> createState() => CustomCalendarButtomState();
}

class CustomCalendarButtomState extends State<CustomCalendarButtom> {
  bool hover = false;
  bool pressing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : () {
                        showDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            alignment: Alignment.centerRight,
                            content: Container(
                                color: AppTheme.of(context).primaryBackground,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height * 0.32,
                                child:widget.onTapWidget
                                ),
                          ),
                        );
                      },
      onTapDown: (details) {
        setState(() {
          pressing = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          pressing = false;
        });
      },
      onTapCancel: () {
        setState(() {
          pressing = false;
        });
      },
      child: MouseRegion(
        child: AnimatedContainer(
            height: widget.height,
            width: widget.width,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.color ?? AppTheme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 3,
                    offset: Offset(
                      0,
                      pressing
                          ? -2
                          : hover
                              ? 5
                              : 0,
                    ), // changes position of shadow
                  ),
                ]),
            child: widget.dateRangeField),
            
        onEnter: (event) {
          setState(() {
            hover = true;
          });
        },
        onExit: (event) {
          setState(() {
            hover = false;
          });
        },
      ),
    );
  }
}
