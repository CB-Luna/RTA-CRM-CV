import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

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
  Widget build(BuildContext context) {
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 0.70,
        title:
            issueReportedProvider.actualIssueOpenClose?.nameIssue ?? "Prueba",
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
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
                          // issueReportedProvider.clearactualIssueOpenClose(
                          //     notify: false);
                        },
                      ),
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
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    width: 250,
                    height: 50,
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
                      width: 400,
                      height: 350,
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
                          Text("NOTES"),
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
                        height: 335,
                        width: 400,
                        child: CarouselSlider.builder(
                          itemCount: 1,
                          itemBuilder: (context, index, realIndex) {
                            const urlImage =
                                "https://supa43.rtatel.com/storage/v1/object/public/assets/no_image.jpg";

                            return buildImage(urlImage, index);
                          },
                          options: CarouselOptions(height: 200),
                        ),
                      )
                    : SizedBox(
                        height: 335,
                        width: 400,
                        child: CarouselSlider.builder(
                          itemCount: issueReportedProvider
                              .actualIssueOpenClose!.listImages!.length,
                          itemBuilder: (context, index, realIndex) {
                            print("----------------");
                            print(
                                "Length listImages ${issueReportedProvider.actualIssueOpenClose!.listImages!.length}");
                            final urlImage = issueReportedProvider
                                .actualIssueOpenClose!.listImages![index];

                            return buildImage(urlImage, index);
                          },
                          options: CarouselOptions(height: 200),
                        ),
                      )
                // SizedBox(
                //   height: 335,
                //   width: 400,
                //   child: CarouselSlider.builder(
                //     itemCount: issueReportedProvider
                //                 .actualIssueOpenClose?.listImages ==
                //             null
                //         ? 0
                //         : issueReportedProvider
                //             .actualIssueOpenClose?.listImages?.length,
                //     itemBuilder: (context, index, realIndex) {
                //       final urlImage = issueReportedProvider
                //           .actualIssueOpenClose?.listImages![index];
                //       // const urlImage = "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png";
                //       return buildImage(
                //           urlImage ??
                //               "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png",
                //           index);
                //     },
                //     options: CarouselOptions(height: 200),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status) {
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

Widget buildImage(String urlImage, int index) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
