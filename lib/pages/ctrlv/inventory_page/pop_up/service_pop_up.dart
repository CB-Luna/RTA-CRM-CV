import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

import '../../../../theme/theme.dart';

class ServicePopUp extends StatefulWidget {
  const ServicePopUp({super.key});

  @override
  State<ServicePopUp> createState() => _ServicePopUpState();
}

class _ServicePopUpState extends State<ServicePopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            margin: const EdgeInsets.only(top: 50, left: 40, bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(int.parse(provider.actualVehicle!.color)),
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(int.parse(provider.actualVehicle!.color)),
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
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 50.0),
            margin: const EdgeInsets.only(left: 10.0),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: provider.services.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.grey,
                                  offset: Offset(10, 10))
                            ],
                          ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text("Service: ",
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
                                              color: AppTheme.of(context)
                                                  .primaryText)),
                                      Text(
                                        provider
                                            .services[index].servicex.service,
                                        style: TextStyle(
                                          color: AppTheme.of(context)
                                              .contenidoTablas
                                              .color,
                                          fontFamily: 'Bicyclette-Thin',
                                          fontWeight: AppTheme.of(context)
                                              .encabezadoTablas
                                              .fontWeight,
                                          fontSize: AppTheme.of(context)
                                              .contenidoTablas
                                              .fontSize,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("License Plates: ",
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
                                            color: AppTheme.of(context)
                                                .primaryText)),
                                    Text(
                                      provider.actualVehicle!.licesensePlates,
                                      style: TextStyle(
                                        color: AppTheme.of(context)
                                            .contenidoTablas
                                            .color,
                                        fontFamily: 'Bicyclette-Thin',
                                        fontWeight: AppTheme.of(context)
                                            .encabezadoTablas
                                            .fontWeight,
                                        fontSize: AppTheme.of(context)
                                            .contenidoTablas
                                            .fontSize,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Service Date: ",
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
                                              color: AppTheme.of(context)
                                                  .primaryText)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        DateFormat("MMM/dd/yyyy hh:mm:ss")
                                            .format(provider
                                                .services[index].serviceDate),
                                        style: TextStyle(
                                          color: AppTheme.of(context)
                                              .contenidoTablas
                                              .color,
                                          fontFamily: 'Bicyclette-Thin',
                                          fontWeight: AppTheme.of(context)
                                              .encabezadoTablas
                                              .fontWeight,
                                          fontSize: AppTheme.of(context)
                                              .contenidoTablas
                                              .fontSize,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ]),
                        ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}
