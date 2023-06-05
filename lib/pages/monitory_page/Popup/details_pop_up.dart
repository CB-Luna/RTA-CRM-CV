import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/monitory_page/widgets/cuadro.dart';
import 'package:rta_crm_cv/pages/monitory_page/widgets/forms_answer.dart';

import '../../../models/monitory.dart';
import '../../../public/colors.dart';

class DetailsPop extends StatelessWidget  {
  final Monitory vehicle;
  const DetailsPop({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 900,
        height: 550,
        decoration: BoxDecoration(
            gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("DETAILS"),
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
                    painter: RPSCustomPainterMon(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Employee: ${vehicle.employee.name} ${vehicle.employee.lastName}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(" Vehicle Id:${vehicle.idVehicle} ",
                              style: const TextStyle(color: Colors.white)),
                          Text(" Gas: ${vehicle.gas}",
                              style: const TextStyle(color: Colors.white)),
                          Text(" Mileage: ${vehicle.mileage} ",
                              style: const TextStyle(color: Colors.white)),
                          Text(" Plate Number: ${vehicle.licesensePlates}",
                              style: const TextStyle(color: Colors.white)),
                          Text(" VIN: ${vehicle.vin} ",
                              style: const TextStyle(color: Colors.white)),
                          Text(
                            " Insurance Renewal Due: ${vehicle.vehicle.renewalInsDue.year}-${vehicle.vehicle.renewalInsDue.month}-${vehicle.vehicle.renewalInsDue.day} ",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(" Registration Due: ${vehicle.vehicle.registrationDue.year}-${vehicle.vehicle.registrationDue.month}-${vehicle.vehicle.registrationDue.day} ",
                              style: const TextStyle(color: Colors.white)),
                          Text(" Oil Change Due: ${vehicle.vehicle.oilChangeDue.year}-${vehicle.vehicle.oilChangeDue.month}-${vehicle.vehicle.oilChangeDue.day} ",
                              style: const TextStyle(color: Colors.white)),
                          Text(" Date Added: ${vehicle.dateAdded.year}-${vehicle.dateAdded.month}-${vehicle.dateAdded.day} ",
                              style: const TextStyle(color: Colors.white))
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
                      width: 350,
                      height: 100,
                      color: Colors.red,
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Container(
              width: 800,
              height: 130,
              color: Colors.yellow,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: const DefaultTabController(
                      length: 2,
                      child: TabBar(
                            tabs: [
                              Tab(
                                text: "Delivered",
                                height: 30,
                                ),
                              Tab(
                                text: "Received",
                                height: 30,
                                ),
                            ],
                          ),
                    ),
                  ),
                  //  TabBarView(
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
