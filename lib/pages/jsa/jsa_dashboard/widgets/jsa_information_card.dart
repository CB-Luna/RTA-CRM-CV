import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class JSAInformationCard extends StatefulWidget {
  final Color colorCard;
  final String text;
  final int value;
  const JSAInformationCard(
      {required this.colorCard,
      required this.text,
      required this.value,
      super.key});

  @override
  State<JSAInformationCard> createState() => _JSAInformationCardState();
}

class _JSAInformationCardState extends State<JSAInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      width: MediaQuery.of(context).size.width * 0.14,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: widget.colorCard, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: widget.colorCard.withOpacity(0.5)),
            child: Icon(
              Icons.sell_outlined,
              color: widget.colorCard,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Total JSA ${widget.text}",
              style: AppTheme.of(context).subtitle1,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "${widget.value} Documents",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: widget.colorCard),
              ))
        ],
      ),
    );
  }
}
