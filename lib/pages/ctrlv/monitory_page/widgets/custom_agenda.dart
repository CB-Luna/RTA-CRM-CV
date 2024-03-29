import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import '../../../../helpers/constants.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';

class CustomAgenda extends StatelessWidget {
  final double width;
  const CustomAgenda({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    provider.getWeekDay();
    provider.getMonth();
    //Color color = Colors.white;
    // DateTime checkIn = DateTime.now();
    //Controlador para compartir entre scrollbar y singlechild
    ScrollController _scrollController = ScrollController();
    const urlImage =
        "$supabaseUrl/storage/v1/object/public/assets/no_image.jpg";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.calendarController.selectedDate == null
                ? const Text('No date selected yet',
                    style: TextStyle(
                      fontSize: 30,
                    ))
                : Text(
                    '${provider.selectedDay}, ${provider.selectedMonth}/${provider.calendarController.selectedDate?.day}/${provider.calendarController.selectedDate?.year}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
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
                            //Revisar bien esto
                            // checkIn = provider.idEventos[index].dateAddedD!;
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
                                        child: Stack(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 400,
                                                  height: 79,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(context)
                                                              .odePrimary),
                                                ),
                                              ],
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        provider
                                                            .idEventos[index]
                                                            .vehicle
                                                            .licesensePlates,
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
                                                      Container(
                                                        width: 97,
                                                        height: 45,
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
                                                            Column(
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
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Opacity(
                                                                  opacity: 0.65,
                                                                  child: Text(
                                                                    DateFormat('hh:mm:ss a').format(provider
                                                                        .idEventos[
                                                                            index]
                                                                        .dateAddedR),
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppTheme
                                                                          .lightTheme
                                                                          .tertiaryColor,
                                                                      fontSize:
                                                                          12,
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
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${provider.idEventos[index].worker.name} ${provider.idEventos[index].worker.lastName}',
                                                        style: TextStyle(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .secondaryColor,
                                                          fontFamily:
                                                              'Bicyclette-Thin',
                                                          fontSize: AppTheme.of(
                                                                  context)
                                                              .encabezadoTablas
                                                              .fontSize,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Spacer(),

                                                  provider.idEventos[index]
                                                              .vehicle.image !=
                                                          null
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.13,
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    provider
                                                                        .idEventos[
                                                                            index]
                                                                        .vehicle
                                                                        .image!,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.50,
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.13,
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.50,
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                              child: Image.network(
                                                                  urlImage,
                                                                  fit: BoxFit
                                                                      .contain),
                                                            ),
                                                            //
                                                          ],
                                                        )
                                                ]),
                                          ],
                                        ),
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
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 400,
                                                      height: 79,
                                                      decoration: BoxDecoration(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .cryPrimary),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            provider
                                                                .idEventos[
                                                                    index]
                                                                .vehicle
                                                                .licesensePlates,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 97,
                                                            height: 45,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppTheme
                                                                  .lightTheme
                                                                  .tertiaryColor
                                                                  .withOpacity(
                                                                      0.5),
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
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Opacity(
                                                                      opacity:
                                                                          0.65,
                                                                      child:
                                                                          Text(
                                                                        '● Check Out',
                                                                        style:
                                                                            TextStyle(
                                                                          color: AppTheme
                                                                              .lightTheme
                                                                              .tertiaryColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Opacity(
                                                                      opacity:
                                                                          0.65,
                                                                      child:
                                                                          Text(
                                                                        DateFormat('hh:mm:ss a').format(provider
                                                                            .idEventos[index]
                                                                            .dateAddedR),
                                                                        style:
                                                                            TextStyle(
                                                                          color: AppTheme
                                                                              .lightTheme
                                                                              .tertiaryColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${provider.idEventos[index].worker.name} ${provider.idEventos[index].worker.lastName}',
                                                            style: TextStyle(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontFamily:
                                                                  'Bicyclette-Thin',
                                                              fontSize: AppTheme
                                                                      .of(context)
                                                                  .encabezadoTablas
                                                                  .fontSize,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Spacer(),

                                                      provider
                                                                  .idEventos[
                                                                      index]
                                                                  .vehicle
                                                                  .image !=
                                                              null
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.13,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        provider
                                                                            .idEventos[index]
                                                                            .vehicle
                                                                            .image!,
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: const BorderSide(
                                                                          width:
                                                                              2.50,
                                                                          color:
                                                                              Colors.white),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.13,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: const BorderSide(
                                                                          width:
                                                                              2.50,
                                                                          color:
                                                                              Colors.white),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  child: Image.network(
                                                                      urlImage,
                                                                      fit: BoxFit
                                                                          .contain),
                                                                ),
                                                                //
                                                              ],
                                                            )
                                                    ]),
                                              ],
                                            ),
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
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          width: 400,
                                                          height: 79,
                                                          decoration: BoxDecoration(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .smiPrimary),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                provider
                                                                    .idEventos[
                                                                        index]
                                                                    .vehicle
                                                                    .licesensePlates,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
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
                                                              Container(
                                                                width: 97,
                                                                height: 45,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  color: AppTheme
                                                                      .lightTheme
                                                                      .tertiaryColor
                                                                      .withOpacity(
                                                                          0.5),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Opacity(
                                                                          opacity:
                                                                              0.65,
                                                                          child:
                                                                              Text(
                                                                            '● Check Out',
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppTheme.lightTheme.tertiaryColor,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Opacity(
                                                                          opacity:
                                                                              0.65,
                                                                          child:
                                                                              Text(
                                                                            DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppTheme.lightTheme.tertiaryColor,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                '${provider.idEventos[index].worker.name} ${provider.idEventos[index].worker.lastName}',
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      255,
                                                                      138,
                                                                      0,
                                                                      1),
                                                                  fontFamily:
                                                                      'Bicyclette-Thin',
                                                                  fontSize: AppTheme.of(
                                                                          context)
                                                                      .encabezadoTablas
                                                                      .fontSize,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Spacer(),

                                                          provider
                                                                      .idEventos[
                                                                          index]
                                                                      .vehicle
                                                                      .image !=
                                                                  null
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.12,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.13,
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            provider.idEventos[index].vehicle.image!,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          side: const BorderSide(
                                                                              width: 2.50,
                                                                              color: Colors.white),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.12,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.13,
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          side: const BorderSide(
                                                                              width: 2.50,
                                                                              color: Colors.white),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                      child: Image.network(
                                                                          urlImage,
                                                                          fit: BoxFit
                                                                              .contain),
                                                                    ),
                                                                    //
                                                                  ],
                                                                )
                                                        ]),
                                                  ],
                                                ),
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
                                        child: Stack(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: 400,
                                                  height: 79,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(context)
                                                              .odePrimary),
                                                ),
                                              ],
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        provider
                                                            .idEventos[index]
                                                            .vehicle
                                                            .licesensePlates,
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
                                                      Container(
                                                        width: 97,
                                                        height: 45,
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
                                                            Column(
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
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Opacity(
                                                                  opacity: 0.65,
                                                                  child: Text(
                                                                    DateFormat('hh:mm:ss a').format(provider
                                                                        .idEventos[
                                                                            index]
                                                                        .dateAddedR),
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppTheme
                                                                          .lightTheme
                                                                          .tertiaryColor,
                                                                      fontSize:
                                                                          12,
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
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 97,
                                                        height: 45,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              195, 155, 211, 1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            const Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
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
                                                                      fontSize:
                                                                          12,
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
                                                            Opacity(
                                                              opacity: 0.65,
                                                              child: Text(
                                                                DateFormat(
                                                                        'hh:mm:ss a')
                                                                    .format(provider
                                                                        .idEventos[
                                                                            index]
                                                                        .dateAddedD!),
                                                                style:
                                                                    const TextStyle(
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
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${provider.idEventos[index].worker.name} ${provider.idEventos[index].worker.lastName}',
                                                        style: TextStyle(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .secondaryColor,
                                                          fontFamily:
                                                              'Bicyclette-Thin',
                                                          fontSize: AppTheme.of(
                                                                  context)
                                                              .encabezadoTablas
                                                              .fontSize,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Spacer(),

                                                  provider.idEventos[index]
                                                              .vehicle.image !=
                                                          null
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.13,
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    provider
                                                                        .idEventos[
                                                                            index]
                                                                        .vehicle
                                                                        .image!,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.50,
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.13,
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: const BorderSide(
                                                                      width:
                                                                          2.50,
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                              child: Image.network(
                                                                  urlImage,
                                                                  fit: BoxFit
                                                                      .contain),
                                                            ),
                                                            //
                                                          ],
                                                        )
                                                ]),
                                          ],
                                        ),
                                      )
                                    //
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
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 400,
                                                      height: 79,
                                                      decoration: BoxDecoration(
                                                          color: AppTheme.of(
                                                                  context)
                                                              .cryPrimary),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            provider
                                                                .idEventos[
                                                                    index]
                                                                .vehicle
                                                                .licesensePlates,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      195,
                                                                      155,
                                                                      211,
                                                                      1),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 97,
                                                            height: 45,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppTheme
                                                                  .lightTheme
                                                                  .tertiaryColor
                                                                  .withOpacity(
                                                                      0.5),
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
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Opacity(
                                                                      opacity:
                                                                          0.65,
                                                                      child:
                                                                          Text(
                                                                        '● Check Out',
                                                                        style:
                                                                            TextStyle(
                                                                          color: AppTheme
                                                                              .lightTheme
                                                                              .tertiaryColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Opacity(
                                                                      opacity:
                                                                          0.65,
                                                                      child:
                                                                          Text(
                                                                        DateFormat('hh:mm:ss a').format(provider
                                                                            .idEventos[index]
                                                                            .dateAddedR),
                                                                        style:
                                                                            TextStyle(
                                                                          color: AppTheme
                                                                              .lightTheme
                                                                              .tertiaryColor,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 97,
                                                            height: 45,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  195,
                                                                  155,
                                                                  211,
                                                                  1),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                const Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Opacity(
                                                                      opacity:
                                                                          0.65,
                                                                      child:
                                                                          Text(
                                                                        '● Check In',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              245,
                                                                              6,
                                                                              213,
                                                                              1),
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Opacity(
                                                                  opacity: 0.65,
                                                                  child: Text(
                                                                    DateFormat('hh:mm:ss a').format(provider
                                                                        .idEventos[
                                                                            index]
                                                                        .dateAddedD!),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              245,
                                                                              6,
                                                                              213,
                                                                              1),
                                                                      fontSize:
                                                                          12,
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
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${provider.idEventos[index].worker.name} ${provider.idEventos[index].worker.lastName}',
                                                            style: TextStyle(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontFamily:
                                                                  'Bicyclette-Thin',
                                                              fontSize: AppTheme
                                                                      .of(context)
                                                                  .encabezadoTablas
                                                                  .fontSize,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Spacer(),

                                                      provider
                                                                  .idEventos[
                                                                      index]
                                                                  .vehicle
                                                                  .image !=
                                                              null
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.13,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        provider
                                                                            .idEventos[index]
                                                                            .vehicle
                                                                            .image!,
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: const BorderSide(
                                                                          width:
                                                                              2.50,
                                                                          color:
                                                                              Colors.white),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.13,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: const BorderSide(
                                                                          width:
                                                                              2.50,
                                                                          color:
                                                                              Colors.white),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  child: Image.network(
                                                                      urlImage,
                                                                      fit: BoxFit
                                                                          .contain),
                                                                ),
                                                                //
                                                              ],
                                                            )
                                                    ]),
                                              ],
                                            ),
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
                                                child: Stack(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          width: 400,
                                                          height: 79,
                                                          decoration: BoxDecoration(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .smiPrimary),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                provider
                                                                    .idEventos[
                                                                        index]
                                                                    .vehicle
                                                                    .licesensePlates,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
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
                                                              Container(
                                                                width: 97,
                                                                height: 45,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  color: AppTheme
                                                                      .lightTheme
                                                                      .tertiaryColor
                                                                      .withOpacity(
                                                                          0.5),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Opacity(
                                                                          opacity:
                                                                              0.65,
                                                                          child:
                                                                              Text(
                                                                            '● Check Out',
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppTheme.lightTheme.tertiaryColor,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Opacity(
                                                                          opacity:
                                                                              0.65,
                                                                          child:
                                                                              Text(
                                                                            DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppTheme.lightTheme.tertiaryColor,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 97,
                                                                height: 45,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      195,
                                                                      155,
                                                                      211,
                                                                      1),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    const Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Opacity(
                                                                          opacity:
                                                                              0.65,
                                                                          child:
                                                                              Text(
                                                                            '● Check In',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(245, 6, 213, 1),
                                                                              fontSize: 12,
                                                                              fontFamily: 'Poppins',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Opacity(
                                                                      opacity:
                                                                          0.65,
                                                                      child:
                                                                          Text(
                                                                        DateFormat('hh:mm:ss a').format(provider
                                                                            .idEventos[index]
                                                                            .dateAddedD!),
                                                                        style:
                                                                            const TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              245,
                                                                              6,
                                                                              213,
                                                                              1),
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'Poppins',
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
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                '${provider.idEventos[index].worker.name} ${provider.idEventos[index].worker.lastName}',
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      255,
                                                                      138,
                                                                      0,
                                                                      1),
                                                                  fontFamily:
                                                                      'Bicyclette-Thin',
                                                                  fontSize: AppTheme.of(
                                                                          context)
                                                                      .encabezadoTablas
                                                                      .fontSize,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Spacer(),
                                                          provider
                                                                      .idEventos[
                                                                          index]
                                                                      .vehicle
                                                                      .image !=
                                                                  null
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.12,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.13,
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            provider.idEventos[index].vehicle.image!,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          side: const BorderSide(
                                                                              width: 2.50,
                                                                              color: Colors.white),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.12,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.13,
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          side: const BorderSide(
                                                                              width: 2.50,
                                                                              color: Colors.white),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                      child: Image.network(
                                                                          urlImage,
                                                                          fit: BoxFit
                                                                              .contain),
                                                                    ),
                                                                    //
                                                                  ],
                                                                )
                                                        ]),
                                                  ],
                                                ),
                                              )
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
