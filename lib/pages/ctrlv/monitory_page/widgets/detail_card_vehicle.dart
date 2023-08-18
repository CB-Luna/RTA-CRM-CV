import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/monitory.dart';
import '../../../../theme/theme.dart';

class DetailVehicleCard extends StatelessWidget {
  final Monitory vehicle;
  const DetailVehicleCard({
    super.key, required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.3,
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
                        vehicle.company.company)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.06,
                    height: MediaQuery.of(context).size.height * 0.04,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: ShapeDecoration(
                      color: companyColor(
                          vehicle.company.company),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      '● ${vehicle.company.company}',
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              ),
                            ),
                            Text(
                              "${vehicle.idVehicle}",
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
                              ),
                            ),
                            Text(
                              vehicle.vin,
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
                                  ),
                                ),
                                Text(
                                  vehicle.vehicle.licesensePlates,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_gas_station_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Gas: ",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .encabezadoTablas
                                    .fontSize,
                              ),
                            ),
                            Text(
                              vehicle.gasD == "" ? vehicle.gasR : "${vehicle.gasD}",
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
                              Icons.speed_outlined,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              "Mileage: ",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .encabezadoTablas
                                    .fontSize,
                              ),
                            ),
                            Text(
                              // ignore: unrelated_type_equality_checks
                              vehicle.mileageD == "" ? NumberFormat('#,###').format(vehicle.mileageR) : NumberFormat('#,###').format(vehicle.mileageD),
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
                              ),
                            ),
                            Text(
                              vehicle.vehicle.oilChangeDue == null
                                              ? "Not Registered"
                                              : " ${DateFormat("MMM/dd/yyyy").format(vehicle.vehicle.oilChangeDue!)}",
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
                              ),
                            ),
                            Text(
                               vehicle.vehicle
                                                      .lastTransmissionFluidChange ==
                                                  null
                                              ? "Not Registered"
                                              : DateFormat("MMM/dd/yyyy")
                                                  .format(vehicle.vehicle
                                                      .lastTransmissionFluidChange!),
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
                              ),
                            ),
                            Text(
                              vehicle.vehicle
                                                      .lastRadiatorFluidChange ==
                                                  null
                                              ? "Not Registered"
                                              : DateFormat("MMM/dd/yyyy")
                                                  .format(vehicle.vehicle
                                                      .lastRadiatorFluidChange!),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: MediaQuery.of(context).size.height * 0.13,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            vehicle.vehicle.image ?? "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png")),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2.50, color: Colors.white),
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
                          vehicle.vehicle.make,
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
                          vehicle.vehicle.model,
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
                          vehicle.vehicle.year,
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
                                  vehicle.vehicle.color)),
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
