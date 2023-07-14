import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../theme/theme.dart';
import '../../monitory_page/widgets/cuadro.dart';

class GeneralInfoPopUP extends StatefulWidget {
  const GeneralInfoPopUP({
    super.key,
  });

  @override
  State<GeneralInfoPopUP> createState() => _GeneralInfoPopUPState();
}

class _GeneralInfoPopUPState extends State<GeneralInfoPopUP> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return Container(
      // width: MediaQuery.of(context).size.width - 100,
      // height: MediaQuery.of(context).size.height,
      child: Padding(
        //padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Row(
          children: [
            Container(
              height: (650 * 0.7586633663366337).toDouble(),
              width: 700,
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: CustomPaint(
                size: Size(400, (450 * 0.7586633663366337).toDouble()),
                painter: RPSCustomPainterMon(),
                child: Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.numbers_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.dialpad_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.credit_card_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.car_repair_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.warehouse_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.directions_car_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.calendar_view_day_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: AppTheme.of(context).gris,
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
                                  color: AppTheme.of(context).gris),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 0, 0, 10),
                          child: Text(
                            "${provider.actualVehicle!.idVehicle}",
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
                            provider.actualVehicle!.vin,
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
                            provider.actualVehicle!.licesensePlates,
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
                            provider.actualVehicle!.status.status,
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
                            provider.actualVehicle!.company.company,
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 0, 0, 10),
                          child: Text(
                            provider.actualVehicle!.motor,
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
                            provider.actualVehicle!.oilChangeDue == null
                                ? ""
                                : " ${DateFormat("MMM/dd/yyyy").format(provider.actualVehicle!.oilChangeDue!)}",
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
                            provider.actualVehicle!.lastRadiatorFluidChange ==
                                    null
                                ? ""
                                : DateFormat("MMM/dd/yyyy").format(provider
                                    .actualVehicle!.lastRadiatorFluidChange!),
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
                            provider.actualVehicle!
                                        .lastTransmissionFluidChange ==
                                    null
                                ? ""
                                : DateFormat("MMM/dd/yyyy").format(provider
                                    .actualVehicle!
                                    .lastTransmissionFluidChange!),
                            style: TextStyle(
                              color: AppTheme.of(context).gris,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 250,
                  width: 500,
                  margin: const EdgeInsets.only(top: 50, left: 40, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(int.parse(provider.actualVehicle!.color)),
                        width: 5.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color(int.parse(provider.actualVehicle!.color)),
                          spreadRadius: 7,
                          blurRadius: 10,
                          offset: Offset(4, 4), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(provider.actualVehicle!.image!))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2.0)),
                  width: 400,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        provider.actualVehicle!.make,
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
                        provider.actualVehicle!.model,
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
                        provider.actualVehicle!.year,
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
                            color:
                                Color(int.parse(provider.actualVehicle!.color)),
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
