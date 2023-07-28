import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/Popup/parts.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/cuadro.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
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
              height: 760,
              decoration: BoxDecoration(
                  gradient: whiteGradient,
                  borderRadius: BorderRadius.circular(20)),
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
                            child: CustomTextIconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              text: "",
                              isLoading: false,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        // width: 700,
                        // padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: vehicle.company.company == "CRY"
                              ? AppTheme.of(context).primaryColor
                              : vehicle.company.company == "SMI"
                                  ? Color.fromRGBO(255, 138, 0, 1)
                                  : Color(0xFFD20030),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 10, left: 20, right: 20),
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: AppTheme.of(context).gris),
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
                                                color:
                                                    AppTheme.of(context).gris),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.numbers_outlined,
                                            color: AppTheme.of(context).gris,
                                          ),
                                          Text(
                                            " Vehicle Id: ",
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
                                                color:
                                                    AppTheme.of(context).gris),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.local_gas_station_outlined,
                                              color: AppTheme.of(context).gris),
                                          Text(" Gas: ",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontFamily,
                                                  fontSize: AppTheme.of(context)
                                                      .contenidoTablas
                                                      .fontSize,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontStyle,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontWeight,
                                                  color: AppTheme.of(context)
                                                      .gris)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.speed_outlined,
                                              color: AppTheme.of(context).gris),
                                          Text(" Mileage: ",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontFamily,
                                                  fontSize: AppTheme.of(context)
                                                      .contenidoTablas
                                                      .fontSize,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontStyle,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontWeight,
                                                  color: AppTheme.of(context)
                                                      .gris)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.credit_card_outlined,
                                            color: AppTheme.of(context).gris,
                                          ),
                                          Text(" Plate Number: ",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontFamily,
                                                  fontSize: AppTheme.of(context)
                                                      .contenidoTablas
                                                      .fontSize,
                                                  fontStyle:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontStyle,
                                                  fontWeight:
                                                      AppTheme.of(context)
                                                          .encabezadoTablas
                                                          .fontWeight,
                                                  color: AppTheme.of(context)
                                                      .gris)),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.employee.name} ${vehicle.employee.lastName}",
                                        style: TextStyle(
                                          color: Colors.white,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.idVehicle}",
                                        style: TextStyle(
                                          color: Colors.white,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 10),
                                      child: Text(
                                        vehicle.gasR,
                                        style: TextStyle(
                                          color: Colors.white,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 10),
                                      child: Text(
                                        "${vehicle.mileageR}",
                                        style: TextStyle(
                                          color: Colors.white,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 10),
                                      child: Text(
                                        vehicle.licensePlates,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: AppTheme.of(context)
                                              .encabezadoTablas
                                              .fontFamily,
                                          fontSize: AppTheme.of(context)
                                              .contenidoTablas
                                              .fontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.dialpad_outlined,
                                          color: AppTheme.of(context).gris,
                                        ),
                                        Text(
                                          " VIN: ",
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: AppTheme.of(context).gris,
                                        ),
                                        Text(" Last Radiator Fluid Change: ",
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
                                                color:
                                                    AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: AppTheme.of(context).gris,
                                        ),
                                        Text(" Oil Change Due: ",
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
                                                color:
                                                    AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today_outlined,
                                            color: AppTheme.of(context).gris),
                                        Text(" Date Added: ",
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
                                                color:
                                                    AppTheme.of(context).gris)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          vehicle.vin,
                                          style: TextStyle(
                                            color: Colors.white,
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          vehicle.vehicle
                                                      .lastTransmissionFluidChange ==
                                                  null
                                              ? "Not Registered"
                                              : DateFormat("MMM/dd/yyyy")
                                                  .format(vehicle.vehicle
                                                      .lastTransmissionFluidChange!),
                                          style: TextStyle(
                                            color: Colors.white,
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          vehicle.vehicle
                                                      .lastRadiatorFluidChange ==
                                                  null
                                              ? "Not Registered"
                                              : DateFormat("MMM/dd/yyyy")
                                                  .format(vehicle.vehicle
                                                      .lastRadiatorFluidChange!),
                                          style: TextStyle(
                                            color: Colors.white,
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          vehicle.vehicle.oilChangeDue == null
                                              ? "Not Registered"
                                              : " ${DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.oilChangeDue!)}",
                                          //"${vehicle.vehicle.oilChangeDue.month}-${vehicle.vehicle.oilChangeDue.day}-${vehicle.vehicle.oilChangeDue.year}",
                                          style: TextStyle(
                                            color: Colors.white,
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 10),
                                        child: Text(
                                          DateFormat("MMM/dd/yyyy")
                                              .format(vehicle.dateAddedR)
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
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
                     
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.03,
                                    width:
                                        MediaQuery.of(context).size.width * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromRGBO(171, 235, 198, 1),
                                      border: Border.all(
                                          color:
                                              AppTheme.lightTheme.tertiaryColor,
                                          width: 3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Check Out",
                                        style: TextStyle(
                                            color:
                                                AppTheme.lightTheme.tertiaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ]),
                        ),
                        const AnswerFormReceived(),
                        SizedBox(
                          height: 10,
                        ),
                        
                        vehicle.dateAddedD != null
                            ?Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height * 0.03,
                                      width: MediaQuery.of(context).size.width * 0.07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color.fromRGBO(195, 155, 211, 1),
                                        border: Border.all(
                                            color: Color.fromRGBO(245, 6, 213, 1),
                                            width: 2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Check In",
                                          style: TextStyle(
                                              color: Color.fromRGBO(245, 6, 213, 1),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                const AnswerFormDelivered(),
                              ],
                            ) 
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: blueRadial,
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(10)),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            )
          :
          //cambio de PopUp
          //Id enviarle el de control form para tomar todos los datos de las diferntes tablas.
          provider.viewPopup == 1
              ? MeasuresPopUp(
                  row: vehicle,
                )
              : provider.viewPopup == 2
                  ? const ExtraPopUp(catalog: "Lights", popUp: 2)
                  : provider.viewPopup == 3
                      ? const ExtraPopUp(catalog: "Car Bodywork", popUp: 3)
                      : provider.viewPopup == 4
                          ? const ExtraPopUp(catalog: "Fluid Check", popUp: 4)
                          : provider.viewPopup == 5
                              ? BucketExtraPopUp(popUp: 5)
                              : provider.viewPopup == 6
                                  ? const ExtraPopUp(
                                      catalog: "Security", popUp: 6)
                                  : provider.viewPopup == 7
                                      ? const ExtraPopUp(
                                          catalog: "Extra", popUp: 7)
                                      : provider.viewPopup == 8
                                          ? ExtraPopUp(
                                              catalog: "Equipment", popUp: 8)
                                          : provider.viewPopup == 9
                                              ? CommentsImagesIssues()
                                              : provider.viewPopup == 10
                                                  ? BucketCommentsImagesIssues()
                                                  : Container(),
    );
  }
}
