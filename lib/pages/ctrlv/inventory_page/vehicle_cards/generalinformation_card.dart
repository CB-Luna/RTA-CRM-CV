import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';

class GeneralInformationCard extends StatelessWidget {
  const GeneralInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.35,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    color: companyColor(
                        issueReportedProvider.actualVehicle!.company.company)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.06,
                    height: MediaQuery.of(context).size.height * 0.04,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: ShapeDecoration(
                      color: companyColor(
                          issueReportedProvider.actualVehicle!.company.company),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      '● ${issueReportedProvider.actualVehicle?.company.company}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              // Body
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.numbers_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Vehicle id: ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${issueReportedProvider.actualVehicle!.idVehicle}",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.dialpad_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "VIN: ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              issueReportedProvider.actualVehicle!.vin,
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.credit_card_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "License Plates: ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              issueReportedProvider
                                  .actualVehicle!.licesensePlates,
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.car_repair_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Status: ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              issueReportedProvider
                                  .actualVehicle!.status.status,
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Motor: ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              issueReportedProvider.actualVehicle!.motor,
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.oil_barrel_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Last Oil Change: ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              issueReportedProvider
                                          .actualVehicle!.oilChangeDue ==
                                      null
                                  ? "No register"
                                  : " ${DateFormat("MMM/dd/yyyy").format(issueReportedProvider.actualVehicle!.oilChangeDue!)}",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_car_wash_outlined,
                                  color: AppTheme.of(context).primaryText,
                                ),
                                Text(
                                  "Last transmission fluid change:",
                                  style: TextStyle(
                                      color: AppTheme.of(context).primaryText,
                                      fontFamily: 'Bicyclette-Thin',
                                      fontSize: AppTheme.of(context)
                                          .encabezadoTablas
                                          .fontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              issueReportedProvider.actualVehicle!
                                          .lastTransmissionFluidChange ==
                                      null
                                  ? "No register"
                                  : " ${DateFormat("MMM/dd/yyyy").format(issueReportedProvider.actualVehicle!.lastTransmissionFluidChange!)}",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.mode_fan_off,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Last radiator fluid change:  ",
                              style: TextStyle(
                                  color: AppTheme.of(context).primaryText,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .encabezadoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              issueReportedProvider.actualVehicle!
                                          .lastRadiatorFluidChange ==
                                      null
                                  ? "No register"
                                  : " ${DateFormat("MMM/dd/yyyy").format(issueReportedProvider.actualVehicle!.lastRadiatorFluidChange!)}",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Imagen
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                issueReportedProvider.actualVehicle?.image == null
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        height: MediaQuery.of(context).size.height * 0.13,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2.50, color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Image.asset('assets/images/fadeInAnimation.gif'))
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        height: MediaQuery.of(context).size.height * 0.13,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  issueReportedProvider.actualVehicle!.image!)),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2.50, color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                Container(
                    margin: const EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: 2.0)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          issueReportedProvider.actualVehicle!.make,
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
                              color: AppTheme.of(context).gris),
                        ),
                        Text(
                          issueReportedProvider.actualVehicle!.model,
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
                              color: AppTheme.of(context).gris),
                        ),
                        Text(
                          issueReportedProvider.actualVehicle!.year,
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
                              color: AppTheme.of(context).gris),
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          margin: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Color(int.parse(
                                  issueReportedProvider.actualVehicle!.color)),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 2.0)),
                        ),
                      ],
                    ))
              ]),
            ],
          ),
        ]));
  }
}

Color companyColor(String status) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}
