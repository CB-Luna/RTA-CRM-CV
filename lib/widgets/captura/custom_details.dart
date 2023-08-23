import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomDetails extends StatefulWidget {
  const CustomDetails({
    Key? key,
    this.width = 350,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);
  final double? width;
  final String title;
  final String description;
  final IconData icon;

  @override
  State<CustomDetails> createState() => _CustomDetailsState();
}

class _CustomDetailsState extends State<CustomDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: widget.width,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(widget.icon, color: AppTheme.of(context).primaryBackground),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(color: AppTheme.of(context).primaryBackground),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
              color: AppTheme.of(context).primaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 3,
                  // changes position of shadow
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                widget.description,
                style: TextStyle(color: AppTheme.of(context).hintText.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
