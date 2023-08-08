import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        color: Colors.white,
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
                          isssueReportedProvider.clearRegistroIssueComments(
                              notify: false);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        width: 250,
                        child: Text(
                          isssueReportedProvider
                                      .registroIssueComments?.nameIssue ==
                                  null
                              ? "No Issue"
                              : isssueReportedProvider
                                  .registroIssueComments!.nameIssue.capitalize
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
                      isssueReportedProvider.registroIssueComments?.dateAdded ==
                              null
                          ? "No Date"
                          : DateFormat("MMM/dd/yyyy").format(
                              isssueReportedProvider
                                  .registroIssueComments!.dateAdded),
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
                            child: Text(isssueReportedProvider
                                        .registroIssueComments?.comments ==
                                    null
                                ? "No Comments"
                                : "${isssueReportedProvider.registroIssueComments?.comments}."),
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
                SizedBox(
                  height: 335,
                  width: 400,
                  child: CarouselSlider.builder(
                    itemCount: isssueReportedProvider
                                .registroIssueComments?.listImages ==
                            null
                        ? 0
                        : isssueReportedProvider
                            .registroIssueComments?.listImages?.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = isssueReportedProvider
                          .actualissuesComments?.listImages![index];
                      // const urlImage = "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png";
                      return buildImage(
                          urlImage ??
                              "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png",
                          index);
                    },
                    options: CarouselOptions(height: 200),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
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
