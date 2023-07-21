import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/Popup/parts.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/cuadro.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
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
              height: 700,
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
                              child:Icon(
                                Icons.arrow_back
                              ), 
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: 700,
                        // padding: const EdgeInsets.all(8.0),
                        child: CustomPaint(
                          size: Size(400, (450 * 0.7586633663366337).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSCustomPainterMon(),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, color: Colors.white),
                                        Text(
                                          " Employee: ",
                                          style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                Icons.numbers_outlined,
                                color: AppTheme.of(context).gris,
                              ),
                                        Text(" Vehicle Id: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.local_gas_station_outlined, color: AppTheme.of(context).gris),
                                        Text(" Gas: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.speed_outlined, color: AppTheme.of(context).gris),
                                        Text(" Mileage: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                Icons.credit_card_outlined,
                                color: AppTheme.of(context).gris,
                              ),
                                        Text(" Plate Number: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                Icons.dialpad_outlined,
                                color: AppTheme.of(context).gris,
                              ),
                                        Text(" VIN: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                         Icon(
                                Icons.calendar_view_day_outlined,
                                color: AppTheme.of(context).gris,
                              ),
                                        Text(
                                          " Last Transmission Fluid Change: ",
                                          style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                Icons.calendar_month_outlined,
                                color: AppTheme.of(context).gris,
                              ),
                                        Text(" Last Radiator Fluid Change: ",style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                Icons.calendar_today_outlined,
                                color: AppTheme.of(context).gris,
                              ),
                                        Text(" Oil Change Due: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today_outlined, color: AppTheme.of(context).gris),
                                        Text(" Date Added: ", style: TextStyle(
                                  fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontStyle: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontStyle,
                                  fontWeight: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontWeight,
                                  color: AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  )
                                ]),
                                
                                Padding(
                                  padding: EdgeInsets.only(left: 100),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.employee.name} ${vehicle.employee.lastName}",
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.idVehicle}",
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.gasR,
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.mileageR}",
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.licensePlates,
                                       style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.vin,
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.vehicle.lastTransmissionFluidChange == null ? "Not Registered" : DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.lastTransmissionFluidChange!),
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.vehicle.lastRadiatorFluidChange == null ? "Not Registered" : DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.lastRadiatorFluidChange!),
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        vehicle.vehicle.oilChangeDue == null ? "Not Registered" : " ${DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.oilChangeDue!)}",
                                        //"${vehicle.vehicle.oilChangeDue.month}-${vehicle.vehicle.oilChangeDue.day}-${vehicle.vehicle.oilChangeDue.year}",
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                      child: Text(
                                        DateFormat("MMM/dd/yyyy").format(vehicle.dateAddedR).toString(),
                                        style: TextStyle(color: Colors.white,
                                        fontFamily: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontFamily,
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                        ),
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
                  ? const ExtraPopUp(catalog: "Lights", popUp: 2)
                  : provider.viewPopup == 3
                      ? const ExtraPopUp(catalog: "Car Bodywork", popUp: 3)
                      : provider.viewPopup == 4
                          ? const ExtraPopUp(catalog: "Fluid Check", popUp: 4)
                          : provider.viewPopup == 5
                              ? BucketExtraPopUp(popUp: 5)
                              : provider.viewPopup == 6
                                  ? const ExtraPopUp(catalog: "Security", popUp: 6)
                                  : provider.viewPopup == 7
                                      ? const ExtraPopUp(catalog: "Extra",  popUp: 7)
                                      : provider.viewPopup == 8
                                          ? ExtraPopUp(catalog: "Equipment", popUp: 8)
                                          : provider.viewPopup == 9
                                              ? CommentsImagesIssues()
                                              : provider.viewPopup == 10
                                                  ? BucketCommentsImagesIssues()
                                                  : Container(),
    );
  }
}
