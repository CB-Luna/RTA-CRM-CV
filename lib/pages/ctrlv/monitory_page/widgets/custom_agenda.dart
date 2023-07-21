import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';

class CustomAgenda extends StatelessWidget {
  final double width;
  const CustomAgenda({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    provider.getWeekDay();
    provider.getMonth();
    Color color = Colors.white;
    DateTime checkIn = DateTime.now();
    //Controlador para compartir entre scrollbar y singlechild
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.calendarController.selectedDate == null
                ? Text('No date selected yet',
                    style: TextStyle(
                      fontSize: 30,
                    ))
                : Text(
                    '${provider.selectedDay}, ${provider.selectedMonth}/${provider.calendarController.selectedDate?.day}/${provider.calendarController.selectedDate?.year}',
                    style: TextStyle(
                      fontSize: 30,
                    )),
          ],
        ),
        provider.calendarController.selectedDate == null ||
                provider.idEventos.isEmpty
            ? Container(
                height: 200,
              )
            : Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            List.generate(provider.idEventos.length, (index) {
                          if (provider.idEventos[index].dateAddedD != null) {
                            checkIn = provider.idEventos[index].dateAddedD!;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: provider.idEventos[index].dateAddedD == null
                                ?
                                //Cuando tiene Fecha de Check In
                                provider.idEventos[index].company.company ==
                                        "ODE"
                                    ? Container(
                                        width: 400,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${provider.idEventos[index].vehicle.licesensePlates}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFD20030),
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 97,
                                                height: 28,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: ShapeDecoration(
                                                  color: AppTheme
                                                      .lightTheme.tertiaryColor
                                                      .withOpacity(0.5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.65,
                                                      child: Text(
                                                        '● Check Out',
                                                        style: TextStyle(
                                                          color: AppTheme
                                                              .lightTheme
                                                              .tertiaryColor,
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                  style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .secondaryColor,
                                                    fontFamily:
                                                        'Bicyclette-Thin',
                                                    fontSize:
                                                        AppTheme.of(context)
                                                            .encabezadoTablas
                                                            .fontSize,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Check Out: ',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('hh:mm:ss a')
                                                          .format(provider
                                                              .idEventos[index]
                                                              .dateAddedR),
                                                      style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Spacer(),
                                          Container(
                                            width: 400,
                                            height: 79,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD20030)),
                                          ),
                                          Positioned(
                                            top: -50,
                                            right: 100,
                                            child: Container(
                                              width: 173,
                                              height: 86,
                                              alignment: Alignment.center,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 2.50,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                ),
                                              ),
                                              child: Image.network(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                provider.idEventos[index]
                                                    .vehicle.image!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )
                                    : provider.idEventos[index].company
                                                .company ==
                                            "CRY"
                                        ? Container(
                                            width: 400,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${provider.idEventos[index].vehicle.licesensePlates}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: AppTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 97,
                                                    height: 28,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: ShapeDecoration(
                                                      color: AppTheme.lightTheme
                                                          .tertiaryColor
                                                          .withOpacity(0.5),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Opacity(
                                                          opacity: 0.65,
                                                          child: Text(
                                                            '● Check Out',
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .lightTheme
                                                                  .tertiaryColor,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                      style: TextStyle(
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor,
                                                        fontFamily:
                                                            'Bicyclette-Thin',
                                                        fontSize: AppTheme.of(
                                                                context)
                                                            .encabezadoTablas
                                                            .fontSize,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Check Out: ',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'hh:mm:ss a')
                                                              .format(provider
                                                                  .idEventos[
                                                                      index]
                                                                  .dateAddedR),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Stack(children: [
                                                Container(
                                                  width: 400,
                                                  height: 79,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryColor),
                                                ),
                                                Positioned(
                                                  top: -50,
                                                  right: 100,
                                                  child: Container(
                                                    width: 173,
                                                    height: 86,
                                                    alignment: Alignment.center,
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 2.50,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      height: 150,
                                                      provider.idEventos[index]
                                                          .vehicle.image!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ]),
                                          )
                                        : provider.idEventos[index].company
                                                    .company ==
                                                "SMI"
                                            ? Container(
                                                width: 400,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${provider.idEventos[index].vehicle.licesensePlates}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        138,
                                                                        0,
                                                                        1),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 97,
                                                        height: 28,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: AppTheme
                                                              .lightTheme
                                                              .tertiaryColor
                                                              .withOpacity(0.5),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Opacity(
                                                              opacity: 0.65,
                                                              child: Text(
                                                                '● Check Out',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppTheme
                                                                      .lightTheme
                                                                      .tertiaryColor,
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    138,
                                                                    0,
                                                                    1),
                                                            fontFamily:
                                                                'Bicyclette-Thin',
                                                            fontSize: AppTheme
                                                                    .of(context)
                                                                .encabezadoTablas
                                                                .fontSize,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Check Out: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                            ),
                                                            Text(
                                                              DateFormat(
                                                                      'hh:mm:ss a')
                                                                  .format(provider
                                                                      .idEventos[
                                                                          index]
                                                                      .dateAddedR),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Stack(children: [
                                                    Container(
                                                      width: 400,
                                                      height: 79,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255, 138, 0, 1)),
                                                    ),
                                                    Positioned(
                                                      top: -50,
                                                      right: 100,
                                                      child: Container(
                                                        width: 173,
                                                        height: 86,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            ShapeDecoration(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    width: 2.50,
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                        child: Image.network(
                                                          height: 150,
                                                          provider
                                                              .idEventos[index]
                                                              .vehicle
                                                              .image!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ]),
                                              )
                                            : Container()
                                :
                                //Cuando tiene Fecha de Check In
                                provider.idEventos[index].company.company ==
                                        "ODE"
                                    ? Container(
                                        width: 400,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${provider.idEventos[index].vehicle.licesensePlates}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFD20030),
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 97,
                                                height: 28,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: ShapeDecoration(
                                                  color: Color.fromRGBO(
                                                      195, 155, 211, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.65,
                                                      child: Text(
                                                        '● Check In',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              245, 6, 213, 1),
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                  style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .secondaryColor,
                                                    fontFamily:
                                                        'Bicyclette-Thin',
                                                    fontSize:
                                                        AppTheme.of(context)
                                                            .encabezadoTablas
                                                            .fontSize,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Check Out: ',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('hh:mm:ss a')
                                                          .format(provider
                                                              .idEventos[index]
                                                              .dateAddedR),
                                                      style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Check In: ',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('hh:mm:ss a')
                                                          .format(provider
                                                              .idEventos[index]
                                                              .dateAddedD!),
                                                      style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Spacer(),
                                          Stack(children: [
                                            Container(
                                              width: 400,
                                              height: 79,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFD20030)),
                                            ),
                                            Positioned(
                                              top: -50,
                                              right: 100,
                                              child: Container(
                                                width: 173,
                                                height: 86,
                                                alignment: Alignment.center,
                                                decoration: ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 2.50,
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: Image.network(
                                                  height: 150,
                                                  provider.idEventos[index]
                                                      .vehicle.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),
                                      )
                                    : provider.idEventos[index].company
                                                .company ==
                                            "CRY"
                                        ? Container(
                                            width: 400,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${provider.idEventos[index].vehicle.licesensePlates}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: AppTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 97,
                                                    height: 28,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: ShapeDecoration(
                                                      color: Color.fromRGBO(
                                                          195, 155, 211, 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Opacity(
                                                          opacity: 0.65,
                                                          child: Text(
                                                            '● Check In',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      245,
                                                                      6,
                                                                      213,
                                                                      1),
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                      style: TextStyle(
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor,
                                                        fontFamily:
                                                            'Bicyclette-Thin',
                                                        fontSize: AppTheme.of(
                                                                context)
                                                            .encabezadoTablas
                                                            .fontSize,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Check Out: ',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'hh:mm:ss a')
                                                              .format(provider
                                                                  .idEventos[
                                                                      index]
                                                                  .dateAddedR),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Check In: ',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'hh:mm:ss a')
                                                              .format(provider
                                                                  .idEventos[
                                                                      index]
                                                                  .dateAddedD!),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Stack(children: [
                                                Container(
                                                  width: 400,
                                                  height: 79,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryColor),
                                                ),
                                                Positioned(
                                                  top: -50,
                                                  right: 100,
                                                  child: Container(
                                                    width: 173,
                                                    height: 86,
                                                    alignment: Alignment.center,
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 2.50,
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      height: 150,
                                                      provider.idEventos[index]
                                                          .vehicle.image!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ]),
                                          )
                                        : provider.idEventos[index].company
                                                    .company ==
                                                "SMI"
                                            ? Container(
                                                width: 400,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${provider.idEventos[index].vehicle.licesensePlates}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        255,
                                                                        138,
                                                                        0,
                                                                        1),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 97,
                                                        height: 28,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: Color.fromRGBO(
                                                              195, 155, 211, 1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Opacity(
                                                              opacity: 0.65,
                                                              child: Text(
                                                                '● Check In',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          245,
                                                                          6,
                                                                          213,
                                                                          1),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    138,
                                                                    0,
                                                                    1),
                                                            fontFamily:
                                                                'Bicyclette-Thin',
                                                            fontSize: AppTheme
                                                                    .of(context)
                                                                .encabezadoTablas
                                                                .fontSize,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Check Out: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                            ),
                                                            Text(
                                                              DateFormat(
                                                                      'hh:mm:ss a')
                                                                  .format(provider
                                                                      .idEventos[
                                                                          index]
                                                                      .dateAddedR),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Check In: ',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                            ),
                                                            Text(
                                                              DateFormat(
                                                                      'hh:mm:ss a')
                                                                  .format(provider
                                                                      .idEventos[
                                                                          index]
                                                                      .dateAddedD!),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Stack(children: [
                                                    Container(
                                                      width: 400,
                                                      height: 79,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              255, 138, 0, 1)),
                                                    ),
                                                    Positioned(
                                                      top: -50,
                                                      right: 100,
                                                      child: Container(
                                                        width: 173,
                                                        height: 86,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            ShapeDecoration(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    width: 2.50,
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                        child: Image.network(
                                                          height: 150,
                                                          provider
                                                              .idEventos[index]
                                                              .vehicle
                                                              .image!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ]),
                                              )
                                            // Container(
                                            //     width: 400,
                                            //     decoration: BoxDecoration(
                                            //       color: Color.fromRGBO(
                                            //           255, 138, 0, 1),
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               8.0),
                                            //       border: Border.all(
                                            //         color: Color.fromRGBO(
                                            //             245, 6, 213, 1),
                                            //         width: 5,
                                            //       ),
                                            //     ),
                                            //     padding: EdgeInsets.all(10),
                                            //     child: Column(
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment.center,
                                            //       children: [
                                            //         Text(
                                            //           '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                            //           style: TextStyle(
                                            //             color: color,
                                            //           ),
                                            //         ),
                                            //         Text(
                                            //           '${provider.idEventos[index].vehicle.licesensePlates}',
                                            //           style: TextStyle(
                                            //             color: color,
                                            //           ),
                                            //         ),
                                            //         Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .center,
                                            //           children: [
                                            //             Text(
                                            //               'Check Out: ',
                                            //               style: TextStyle(
                                            //                 color: Colors.black,
                                            //               ),
                                            //             ),
                                            //             Text(
                                            //               DateFormat(
                                            //                       'hh:mm:ss a')
                                            //                   .format(provider
                                            //                       .idEventos[
                                            //                           index]
                                            //                       .dateAddedR),
                                            //               style: TextStyle(
                                            //                 color: color,
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //         Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .center,
                                            //           children: [
                                            //             Text(
                                            //               'Check In: ',
                                            //               style: TextStyle(
                                            //                 color: Colors.black,
                                            //               ),
                                            //             ),
                                            //             Text(
                                            //               DateFormat(
                                            //                       'hh:mm:ss a')
                                            //                   .format(checkIn),
                                            //               style: TextStyle(
                                            //                 color: color,
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //         Image.network(
                                            //           height:
                                            //               MediaQuery.of(context)
                                            //                       .size
                                            //                       .height *
                                            //                   0.03,
                                            //           provider.idEventos[index]
                                            //               .vehicle.image!,
                                            //           fit: BoxFit.cover,
                                            //         ),
                                            //       ],
                                            //     ))
                                            : Container(),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
