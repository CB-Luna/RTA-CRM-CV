import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/card_header.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import 'cuadro_details.dart';
import 'issues_pop_up.dart';
import 'reported_issues_pop_up.dart';

class DetailsPopUp extends StatefulWidget {
  final Vehicle vehicle;
  const DetailsPopUp({super.key, required this.vehicle});

  @override
  State<DetailsPopUp> createState() => _DetailsPopUpState();
}

class _DetailsPopUpState extends State<DetailsPopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 1250,
        height: 550,
        decoration: BoxDecoration(
            gradient: whiteGradient, borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: CardHeader(
              text: " DETAILS ",
            ),
          ),
          Padding(
            //padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        "Exit",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Row(
                  children: [
                    Container(
                      height: (555 * 0.7586633663366337).toDouble(),
                      width: 700,
                      alignment: AlignmentDirectional.centerStart,
                      padding: const EdgeInsets.all(20.0),
                      child: CustomPaint(
                        size: Size(
                            800,
                            (405 * 0.7586633663366337)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomPainter(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, top: 20, left: 20, right: 20),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
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
                                        color: AppTheme.of(context).gris),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    "List of any issues \nreported from daily checks: ",
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
                                ),
                              ],
                            ),
                            //Container(color: Colors.red, width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    "${widget.vehicle.idVehicle}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    widget.vehicle.vin,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    widget.vehicle.licesensePlates,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    widget.vehicle.status.status,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    widget.vehicle.company.company,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    widget.vehicle.motor,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    " ${DateFormat("MMM/dd/yyyy").format(widget.vehicle.oilChangeDue)}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    " ${DateFormat("MMM/dd/yyyy").format(widget.vehicle.lastRadiatorFluidChange)}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Text(
                                    " ${DateFormat("MMM/dd/yyyy").format(widget.vehicle.lastTransmissionFluidChange)}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Row(
                                    children: [
                                      // Text(
                                      //   " \n ${provider.actualIssueXUser.issuesR + provider.actualIssueXUser.issuesD}",
                                      //   style: const TextStyle(
                                      //       color: Colors.white, fontSize: 18),
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: CustomTextIconButton(
                                          width: 140,
                                          isLoading: false,
                                          icon: Icon(Icons.warning_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground),
                                          text: 'List of Issues',
                                          color: AppTheme.of(context)
                                              .tertiaryColor,
                                          onTap: () async {
                                            // provider.getIssues(
                                            //     provider.actualIssueXUser!);
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const ReportedIssues();
                                                });
                                          },
                                        ),
                                      ),
                                    ],
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
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.1,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
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
                              border:
                                  Border.all(color: Colors.black, width: 2.0)),
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
                                    fontSize: AppTheme.of(context)
                                        .encabezadoTablas
                                        .fontSize,
                                    fontStyle: AppTheme.of(context)
                                        .encabezadoTablas
                                        .fontStyle,
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
                                    fontSize: AppTheme.of(context)
                                        .encabezadoTablas
                                        .fontSize,
                                    fontStyle: AppTheme.of(context)
                                        .encabezadoTablas
                                        .fontStyle,
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
                                    fontSize: AppTheme.of(context)
                                        .encabezadoTablas
                                        .fontSize,
                                    fontStyle: AppTheme.of(context)
                                        .encabezadoTablas
                                        .fontStyle,
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
                                    color:
                                        Color(int.parse(widget.vehicle.color!)),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black, width: 2.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
