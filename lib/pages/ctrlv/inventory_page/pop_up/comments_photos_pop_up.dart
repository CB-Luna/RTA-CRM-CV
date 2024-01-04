// ignore_for_file: prefer_is_empty

import 'package:card_swiper/card_swiper.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../helpers/constants.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import 'close_issue_pop_up.dart';

class CommentsPhotosPopUp extends StatefulWidget {
  const CommentsPhotosPopUp({super.key});

  @override
  State<CommentsPhotosPopUp> createState() => _CommentsPhotosPopUpState();
}

class _CommentsPhotosPopUpState extends State<CommentsPhotosPopUp> {
  @override
  build(BuildContext context) {
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    const urlImage =
        "$supabaseUrl/storage/v1/object/public/assets/no_image.jpg";
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 0.75,
        title:
            issueReportedProvider.actualIssueOpenClose?.nameIssue ?? "No Issue",
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextIconButton(
                        width: 60,
                        isLoading: false,
                        icon: Icon(Icons.arrow_back_outlined,
                            color: AppTheme.of(context).primaryBackground),
                        text: '',
                        color: AppTheme.of(context).primaryColor,
                        onTap: () {
                          context.pop();
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.03,
                          decoration: BoxDecoration(
                            color: statusColor(
                                issueReportedProvider
                                    .actualVehicle!.company.company,
                                context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              issueReportedProvider
                                  .actualVehicle!.licesensePlates,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        width: 250,
                        child: Text(
                          issueReportedProvider
                                      .actualIssueOpenClose?.nameIssue ==
                                  null
                              ? "No Issue"
                              : issueReportedProvider
                                  .actualIssueOpenClose!.nameIssue.capitalize
                                  .replaceAll("_", " "),
                          style: TextStyle(
                              color: Colors.orange,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        // width: 250,
                        // height: 50,
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          issueReportedProvider
                                      .actualIssueOpenClose?.dateAddedOpen ==
                                  null
                              ? "No Date"
                              : DateFormat("MMM/dd/yyyy").format(
                                  issueReportedProvider
                                      .actualIssueOpenClose!.dateAddedOpen),
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: MediaQuery.of(context).size.height * 0.4,
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
                      child: Column(
                        children: [
                          const Text("NOTES"),
                          SingleChildScrollView(
                            child: Text(issueReportedProvider
                                        .actualIssueOpenClose?.comments ==
                                    null
                                ? "No Comments"
                                : "${issueReportedProvider.actualIssueOpenClose?.comments}."),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomTextIconButton(
                        mainAxisAlignment: MainAxisAlignment.center,
                        width: 140,
                        isLoading: false,
                        icon: Icon(Icons.remove_red_eye_outlined,
                            color: AppTheme.of(context).primaryBackground),
                        text: 'Close Issue',
                        color: AppTheme.of(context).primaryColor,
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return const CloseIssuePopUp();
                                });
                              });
                        },
                      ),
                    ),
                  ],
                ),
                issueReportedProvider.actualIssueOpenClose?.listImages ==
                            null ||
                        issueReportedProvider
                                .actualIssueOpenClose?.listImages?.length ==
                            0
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Image.network(urlImage, fit: BoxFit.contain))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Swiper(
                          itemCount: issueReportedProvider
                              .actualIssueOpenClose!.listImages!.length,
                          itemBuilder: (context, index) {
                            final urlImage = issueReportedProvider
                                .actualIssueOpenClose!.listImages![index];
                            return Image.network(urlImage, fit: BoxFit.fill);
                          },
                          itemWidth: 300.0,
                          layout: SwiperLayout.STACK,
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

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
