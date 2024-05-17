// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/jsa/training_list/widgets/image_popup_training.dart';
import 'package:rta_crm_cv/pages/jsa/training_list/widgets/plutogrid_training_list.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_training_list_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../theme/theme.dart';
import 'pdf_popup_training.dart';

class ContainerCardTraining extends StatefulWidget {
  final int index;
  bool isExpanded;

  ContainerCardTraining(
      {required this.index, required this.isExpanded, super.key});

  @override
  State<ContainerCardTraining> createState() => _ContainerCardTrainingState();
}

class _ContainerCardTrainingState extends State<ContainerCardTraining> {
  @override
  Widget build(BuildContext context) {
    JsaTrainingListProvider provider =
        Provider.of<JsaTrainingListProvider>(context);
    double width = MediaQuery.of(context).size.width / 1440;
    // double height = MediaQuery.of(context).size.height / 1024;

    provider.userTrainingSelected?.trainings
        .sort((a, b) => b.idTraining.compareTo(a.idTraining));
    return currentUser!.isAdmin
        ? Container(
            // height: MediaQuery.of(context).size.height * 0.07,
            // width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                gradient: whiteGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey)),
            child: SizedBox(
              child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                elevation: 0,
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: Colors.transparent,
                    headerBuilder: (context, expanded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ID USER
                            Container(
                              width: 10,
                              height: 50,
                            ),
                            Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(
                                "${provider.usersTrainings[widget.index].sequentialId}",
                                style: AppTheme.of(context).title2.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 50,
                            ),
                            // FULL NAME
                            Visibility(
                              visible: !widget.isExpanded,
                              child: Container(
                                width: 150,
                                alignment: Alignment.center,
                                child: Text(
                                  "${provider.usersTrainings[widget.index].name}\n${provider.usersTrainings[widget.index].lastName}",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.of(context).title3.override(
                                      fontFamily:
                                          AppTheme.of(context).title3Family,
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              margin: const EdgeInsets.only(right: 120),
                            ),
                            // Número de trainings asignados
                            Container(
                              width: 120,
                              alignment: Alignment.center,
                              child: Visibility(
                                visible: !widget.isExpanded,
                                child: Text(
                                  '${provider.usersTrainings[widget.index].trainings.length}',
                                  style: AppTheme.of(context).title3.override(
                                      fontFamily:
                                          AppTheme.of(context).title3Family,
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 50,
                            ),
                            // Role
                            Container(
                              width: 120,
                              alignment: Alignment.center,
                              child: Visibility(
                                visible: !widget.isExpanded,
                                child: Text(
                                  provider
                                      .usersTrainings[widget.index].role.name,
                                  style: AppTheme.of(context).title3.override(
                                      fontFamily:
                                          AppTheme.of(context).title3Family,
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 50,
                            ),
                            // Compania
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: companyColor(
                                          provider.usersTrainings[widget.index]
                                              .company.name,
                                          context),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          provider.usersTrainings[widget.index]
                                              .company.name,
                                          style: AppTheme.of(context)
                                              .title3
                                              .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .title3Family,
                                                  useGoogleFonts: false,
                                                  color: AppTheme.of(context)
                                                      .primaryBackground,
                                                  fontSize: 20),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            Container(
                              width: 10,
                              height: 50,
                            ),
                            Visibility(
                              visible: !widget.isExpanded,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: AppTheme.of(context).primaryText,
                                  ),
                                  Text(
                                    'Preview',
                                    style: AppTheme.of(context).title3.override(
                                        fontFamily:
                                            AppTheme.of(context).title3Family,
                                        useGoogleFonts: false,
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            //const SizedBox(width: 65),
                          ],
                        ),
                      );
                    },
                    body: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            //horizontal: 24,
                            vertical: 6,
                          ),
                          child: PlutoGridTrainingList(
                            iDUser: provider
                                .usersTrainings[widget.index].userProfileId,
                          )),
                    ),
                    isExpanded: widget.isExpanded,
                    // isExpanded: provider.istaped,
                  ),
                ],
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    widget.isExpanded = !widget.isExpanded;
                    provider.getInformationTraining(
                        provider.usersTrainings[widget.index].userProfileId);
                  });
                },
              ),
            ),
          )
        //  Parte del Usuario
        : Container(
            // height: MediaQuery.of(context).size.height * 0.07,
            // width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                gradient: whiteGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey)),
            child: SizedBox(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Id Safety
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ),
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Text(
                      '${provider.trainingList[widget.index].idTraining}',
                      style: AppTheme.of(context).title2.override(
                          fontFamily: AppTheme.of(context).title3Family,
                          useGoogleFonts: false,
                          color: AppTheme.of(context).primaryText,
                          fontSize: 20),
                    ),
                  ),
                  // Id Title
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: Text(
                      provider.trainingList[widget.index].title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.of(context).title3.override(
                          fontFamily: AppTheme.of(context).title3Family,
                          useGoogleFonts: false,
                          color: AppTheme.of(context).primaryText,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ),
                  // Creation Date
                  SizedBox(
                    width: 150,
                    // margin: const EdgeInsets.only(left: 30),
                    child: Visibility(
                      visible: !widget.isExpanded,
                      child: Text(
                        DateFormat("MMM/dd/yyyy").format(
                            provider.trainingList[widget.index].creationDate),
                        style: AppTheme.of(context).title3.override(
                            fontFamily: AppTheme.of(context).title3Family,
                            useGoogleFonts: false,
                            color: AppTheme.of(context).primaryText,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ),
                  // Expiration Date
                  SizedBox(
                    width: 150,
                    // margin: const EdgeInsets.only(left: 30),
                    child: Text(
                      DateFormat("MMM/dd/yyyy").format(
                          provider.trainingList[widget.index].expirationDate),
                      style: AppTheme.of(context).title3.override(
                          fontFamily: AppTheme.of(context).title3Family,
                          useGoogleFonts: false,
                          color: AppTheme.of(context).primaryText,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ), // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Visibility(
                  //       visible: !widget.isExpanded,
                  //       child: Text(
                  //         DateFormat("MMM/dd/yyyy").format(provider
                  //             .trainingList[widget.index].expirationDate!),
                  //         style: AppTheme.of(context).title3.override(
                  //             fontFamily: AppTheme.of(context).title3Family,
                  //             useGoogleFonts: false,
                  //             color: AppTheme.of(context).primaryText,
                  //             fontSize: 20),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Status
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: statusColor(
                                provider.trainingList[widget.index].status.name,
                                context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                provider.trainingList[widget.index].status.name,
                                style: AppTheme.of(context).title3.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                    fontSize: 20),
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () async {
                            await provider.pickDocument(
                                provider.trainingList[widget.index].docname);
                            provider.documento != null
                                ? await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PdfPopupJSATraining(
                                          name: provider
                                              .trainingList[widget.index]
                                              .docname);
                                    },
                                  )
                                : await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ImagePopupJSATraining(
                                          name: provider
                                              .trainingList[widget.index]
                                              .docname);
                                    },
                                  );
                          },
                          child: Container(
                              width: width * 75,
                              // height: height * 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove_red_eye_outlined),
                                  Text("Preview"),
                                ],
                              ))),
                      // InkWell(
                      //     onTap: () {},
                      //     child: Container(
                      //         width: width * 75,
                      //         // height: height * 120,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           border: Border.all(color: Colors.black),
                      //         ),
                      //         child: const Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(Icons.download_outlined),
                      //             Text("Download"),
                      //           ],
                      //         ))),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ),
                  //const SizedBox(width: 65),
                ],
              ),
            )),
          );
  }
}

Color statusColor(String? status, BuildContext context) {
  late Color color;

  switch (status) {
    case "Active": //
      color = Colors.green;
      break;
    case "Expired": //
      color = AppTheme.of(context).secondaryColor;
      break;

    default:
      return Colors.black;
  }
  return color;
}

Color companyColor(String? status, BuildContext context) {
  late Color color;

  switch (status) {
    case "CRY": //Sen. Exec. Validate
      color = AppTheme.of(context).cryPrimary;
      break;
    case "ODE": //Sen. Exec. Validate
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
