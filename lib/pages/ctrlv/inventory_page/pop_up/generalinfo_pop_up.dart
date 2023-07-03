import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../models/vehicle.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/card_header.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../widgets/trapecio.dart';
import 'issues_pop_up.dart';

class GeneralInfoPopUP extends StatefulWidget {
  final Vehicle vehicle;
  const GeneralInfoPopUP({super.key, required this.vehicle});

  @override
  State<GeneralInfoPopUP> createState() => _GeneralInfoPopUPState();
}

class _GeneralInfoPopUPState extends State<GeneralInfoPopUP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1250,
      height: 600,
      decoration: BoxDecoration(
          gradient: whiteGradient, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        //padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Row(
          children: [
            Container(
              height: (620 * 0.7586633663366337).toDouble(),
              width: 600,
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CustomPaint(
                size: Size(600, (450 * 0.7586633663366337).toDouble()),
                painter: RPSCustomPainter(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 20, left: 20, right: 20),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.numbers_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Vehicle_id: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.dialpad_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "VIN: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.credit_card_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "License Plates: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.car_repair_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Status: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.warehouse_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Company: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.directions_car_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Motor: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Oil Change Due: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.calendar_view_day_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Last transmission fluid change: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppTheme.of(context).alternate,
                                ),
                              ),
                              Text(
                                "Last radiator fluid change: ",
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
                                    color: AppTheme.of(context).alternate),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Container(color: Colors.red, width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Text(
                            "${widget.vehicle.idVehicle}",
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            widget.vehicle.vin,
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            widget.vehicle.licesensePlates,
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            widget.vehicle.status.status,
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            widget.vehicle.company.company,
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Text(
                            widget.vehicle.motor,
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            " ${DateFormat("MMM/dd/yyyy").format(widget.vehicle.oilChangeDue)}",
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            " ${DateFormat("MMM/dd/yyyy").format(widget.vehicle.lastRadiatorFluidChange)}",
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            " ${DateFormat("MMM/dd/yyyy").format(widget.vehicle.lastTransmissionFluidChange)}",
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: CustomTextIconButton(
                              width: 140,
                              isLoading: false,
                              icon: Icon(Icons.warning_outlined,
                                  color:
                                      AppTheme.of(context).primaryBackground),
                              text: 'List of Issues',
                              color: AppTheme.of(context).tertiaryColor,
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const IssuesPopUp();
                                    });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 40, bottom: 10),
                  //padding: const EdgeInsets.only(top: 30, left: 40, bottom: 10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.1,
                      blurRadius: 2,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ]),
                  //width: 550,
                  //height: 250,
                  //color: Colors.green,
                  child: Image.network(
                    widget.vehicle.image,
                    height: 250,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2.0)),
                  width: 400,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.vehicle.make,
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).encabezadoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            fontWeight: AppTheme.of(context)
                                .encabezadoTablas
                                .fontWeight,
                            color: AppTheme.of(context).primaryText),
                      ),
                      Text(
                        widget.vehicle.model,
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).encabezadoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            fontWeight: AppTheme.of(context)
                                .encabezadoTablas
                                .fontWeight,
                            color: AppTheme.of(context).primaryText),
                      ),
                      Text(
                        widget.vehicle.year,
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).encabezadoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            fontWeight: AppTheme.of(context)
                                .encabezadoTablas
                                .fontWeight,
                            color: AppTheme.of(context).primaryText),
                      ),
                      Container(
                        width: 50,
                        height: 100,
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Color(int.parse(widget.vehicle.color!)),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.black, width: 2.0)),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
