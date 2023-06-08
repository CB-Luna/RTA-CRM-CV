import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/cuadro.dart';

import '../../../../models/monitory.dart';
import '../../../../public/colors.dart';

class DetailsPop extends StatelessWidget {
  final Monitory vehicle;
  const DetailsPop({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 1000,
        height: 650,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("DETAILS"),
            ),
            Row(
              children: [
                Container(
                  height: (460 * 0.7586633663366337).toDouble(),
                  width: 500,
                  padding: const EdgeInsets.all(8.0),
                  child: CustomPaint(
                    size: Size(400, (450 * 0.7586633663366337).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainterMon(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                " Employee: ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Vehicle Id: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Gas: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Mileage: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Plate Number: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" VIN: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                " Insurance Renewal Due: ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Registration Due: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Oil Change Due: ", style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(" Date Added: ", style: TextStyle(color: Colors.white)),
                            )
                          ]),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                "${vehicle.employee.name} ${vehicle.employee.lastName}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                "${vehicle.idVehicle}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                vehicle.gas,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                "${vehicle.mileage}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                vehicle.licesensePlates,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                vehicle.vin,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                DateFormat("MMM-dd-yyyy").format(vehicle.vehicle.renewalInsDue).toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                DateFormat("MMM-dd-yyyy").format(vehicle.vehicle.registrationDue).toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                DateFormat("MMM-dd-yyyy").format(vehicle.vehicle.oilChangeDue).toString(),
                                //"${vehicle.vehicle.oilChangeDue.month}-${vehicle.vehicle.oilChangeDue.day}-${vehicle.vehicle.oilChangeDue.year}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                DateFormat("MMM-dd-yyyy").format(vehicle.dateAdded).toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: 300,
                        height: 250,
                        child: Image.network(
                          vehicle.vehicle.image,
                          fit: BoxFit.cover,
                          height: 250,
                          width: 540,
                        )),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black, width: 2.0)),
                      width: 400,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            vehicle.vehicle.make,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            vehicle.vehicle.model,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            vehicle.vehicle.year,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 50,
                            height: 100,
                            margin: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(color: Color(int.parse(vehicle.vehicle.color!)), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black, width: 2.0)),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              width: 800,
              height: 130,
              color: Colors.green,
              child: const Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: DefaultTabController(
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
