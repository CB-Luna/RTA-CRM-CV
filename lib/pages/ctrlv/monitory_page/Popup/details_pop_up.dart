import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/Popup/parts.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/cuadro.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../widgets/forms_answer_delivered.dart';
import '../widgets/forms_answer_received.dart';
import 'bucket_expanded.dart';
import 'comments_images_issues.dart';
import 'extra_parts.dart';
import 'measures.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';

class DetailsPop extends StatelessWidget {
  final Monitory vehicle;
  const DetailsPop({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: provider.viewPopup == 0
          ? Container(
              width: 1300,
              height: 670,
              decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CardHeader(
                      text: 'DETAILS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Exit",
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: (460 * 0.7586633663366337).toDouble(),
                        width: 700,
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
                                      " Last Transmission Fluid Change: ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Text(" Last Radiator Fluid Change: ", style: TextStyle(color: Colors.white)),
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
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                          vehicle.gasR,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          "${vehicle.mileageR}",
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          vehicle.licensePlates,
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
                                          DateFormat("MMM-dd-yyyy").format(vehicle.vehicle.lastTransmissionFluidChange!).toString(),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          DateFormat("MMM-dd-yyyy").format(vehicle.vehicle.oilChangeDue!).toString(),
                                          //"${vehicle.vehicle.oilChangeDue.month}-${vehicle.vehicle.oilChangeDue.day}-${vehicle.vehicle.oilChangeDue.year}",
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 80),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                        vehicle.gasR,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.mileageR}",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.licensePlates,
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
                                        vehicle.vehicle.lastTransmissionFluidChange == null ? "" : DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.lastTransmissionFluidChange!),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.vehicle.lastRadiatorFluidChange == null ? "" : DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.lastRadiatorFluidChange!),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.vehicle.oilChangeDue == null ? "" : " ${DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.oilChangeDue!)}",
                                        //"${vehicle.vehicle.oilChangeDue.month}-${vehicle.vehicle.oilChangeDue.day}-${vehicle.vehicle.oilChangeDue.year}",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        DateFormat("MMM-dd-yyyy").format(vehicle.dateAddedR).toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: 300,
                              height: 250,
                              child: Image.network(
                                vehicle.vehicle.image!,
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
                                  decoration:
                                      BoxDecoration(color: Color(int.parse(vehicle.vehicle.color!)), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black, width: 2.0)),
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
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: TabBar(
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                gradient: blueRadial,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                              ),
                              tabs: const [
                                Tab(
                                  height: 30,
                                  text: "Check Out",
                                ),
                                Tab(
                                  height: 30,
                                  text: "Check In",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                const AnswerFormReceived(),
                                vehicle.dateAddedD != null
                                    ? const AnswerFormDelivered()
                                    : Container(
                                        decoration: BoxDecoration(
                                          gradient: blueRadial,
                                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          :
          //cambio de PopUp
          //Id enviarle el de control form para tomar todos los datos de las diferntes tablas.
          provider.viewPopup == 1
              ? MeasuresPopUp(row: vehicle)
              : provider.viewPopup == 2
                  ? const ExtraPopUp(catalog: "Lights")
                  : provider.viewPopup == 3
                      ? const ExtraPopUp(catalog: "Car Bodywork")
                      : provider.viewPopup == 4
                          ? const ExtraPopUp(catalog: "Fluid Check")
                          : provider.viewPopup == 5
                              ? BucketExtraPopUp()
                              : provider.viewPopup == 6
                                  ? const ExtraPopUp(catalog: "Security")
                                  : provider.viewPopup == 7
                                      ? const ExtraPopUp(catalog: "Extra")
                                      : provider.viewPopup == 8
                                          ? ExtraPopUp(catalog: "Equipment")
                                          : provider.viewPopup == 9
                                              ? CommentsImagesIssues()
                                              : provider.viewPopup == 10
                                                  ? BucketCommentsImagesIssues()
                                                  : Container(),
    );
  }
}
