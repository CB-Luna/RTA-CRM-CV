import 'package:flutter/material.dart';

import 'package:rta_crm_cv/theme/theme.dart';

class CustomCardV2 extends StatefulWidget {
  const CustomCardV2({
    super.key,
    required this.title,
    required this.type,
    required this.address,
    required this.circuitType,
     this.handoff,
     this.create,
     this.orderType,
     this.cir,
     this.portSize,
    this.demarcationPoint,
    this.image,
    this.height,
    this.width,
    required this.child,
    this.padding = const EdgeInsets.all(0),
  });

  final String title, type, address, circuitType;
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets padding;
  final String?  handoff, create, orderType, cir, portSize, demarcationPoint,image;

  @override
  State<CustomCardV2> createState() => _CustomCardV2State();
}

class _CustomCardV2State extends State<CustomCardV2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: widget.padding,
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppTheme.of(context).primaryColor,
              width: 5,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.address} - ${widget.circuitType}',
                style: TextStyle(
                  color: AppTheme.of(context).primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Check Out: ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                 /*  Text(
                    DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                    style: TextStyle(
                      color: color,
                    ),
                  ), */
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Check In: ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  /* Text(
                    DateFormat('hh:mm:ss a').format(checkIn),
                    style: TextStyle(
                      color: color,
                    ),
                  ), */
                ],
              ),
              Image.network(
                height: 150,
                '${widget.image}',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ));
  }
}
