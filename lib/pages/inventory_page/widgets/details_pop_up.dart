import 'package:flutter/material.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:rta_crm_cv/public/colors.dart';

import 'cuadro_details.dart';

class DetailsPopUp extends StatefulWidget {
  final Vehicle vehicle;
  const DetailsPopUp({super.key, required this.vehicle});

  @override
  State<DetailsPopUp> createState() => _DetailsPopUpState();
}

class _DetailsPopUpState extends State<DetailsPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 900,
        height: 450,
        decoration: BoxDecoration(
            gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(" DETAILS "),
          ),
          Row(
            children: [
              Container(
                height: (400 * 0.7586633663366337).toDouble(),
                width: 500,
                padding: const EdgeInsets.all(8.0),
                child: CustomPaint(
                  size: Size(
                      400,
                      (400 * 0.7586633663366337)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Vehicle_id:  ${widget.vehicle.idVehicle}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(" VIN: ${widget.vehicle.vin}"),
                        Text(
                            " License Plate: ${widget.vehicle.licesensePlates}"),
                        Text(" Status "),
                        Text(" Company"),
                        Text(" Oil Change Due"),
                        Text(" Registration Due"),
                        Text(" Insurance Renewal Due")
                      ]),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.white,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 400,
                    height: 100,
                    color: Colors.red,
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
