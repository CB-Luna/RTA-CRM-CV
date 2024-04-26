import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class SafetyBriefingResume extends StatefulWidget {
  const SafetyBriefingResume({super.key});

  @override
  State<SafetyBriefingResume> createState() => _SafetyBriefingResumeState();
}

class _SafetyBriefingResumeState extends State<SafetyBriefingResume> {
  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      Icons.description_outlined,
                                      color: AppTheme.of(context).primaryColor,
                                      size: 35,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Safety Briefing Resume',
                                    style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomCard(
                              title: "TEMPLATE PREVIEW ",
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width * 0.500,
                              padding: const EdgeInsets.all(10),
                              // width: MediaQuery.of(context).size.width * 0.600,
                              child: Container(
                                color: Colors.grey,
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                width:
                                    MediaQuery.of(context).size.width * 0.400,
                                child: provider.finalPdfController == null
                                    ? const CircularProgressIndicator()
                                    : PdfView(
                                        pageSnapping: false,
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        renderer: (PdfPage page) {
                                          if (page.width >= page.height) {
                                            return page.render(
                                              width: page.width * 7,
                                              height: page.height * 4,
                                              format: PdfPageImageFormat.jpeg,
                                              backgroundColor: '#15FF0D',
                                            );
                                          } else if (page.width ==
                                              page.height) {
                                            return page.render(
                                              width: page.width * 4,
                                              height: page.height * 4,
                                              format: PdfPageImageFormat.jpeg,
                                              backgroundColor: '#15FF0D',
                                            );
                                          } else {
                                            return page.render(
                                              width: page.width * 4,
                                              height: page.height * 7,
                                              format: PdfPageImageFormat.jpeg,
                                              backgroundColor: '#15FF0D',
                                            );
                                          }
                                        },
                                        controller:
                                            provider.finalPdfController!,
                                        onDocumentLoaded: (document) {},
                                        onPageChanged: (page) {},
                                        onDocumentError: (error) {},
                                      ),
                              )),
                          CustomCard(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width * 0.300,
                              title: 'Safety Resume',
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Title: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider.titleController.text)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Prepared By: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider.userController.text)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Prepared For: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Row(
                                          children: List.generate(
                                              provider.teamMembers.length,
                                              (index) {
                                            return Row(
                                              children: [
                                                Text(
                                                  provider
                                                      .teamMembers[index].name!,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFF335594),
                                                  ),
                                                ),
                                                if (index <
                                                    provider.teamMembers
                                                            .length -
                                                        1)
                                                  const Text(', '),
                                              ],
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Date: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider.dateController.text)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Issue: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider.issueController.text)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Background: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider.backgroundController.text)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Recommendations: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider
                                            .recomendationsController.text)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Contact: ",
                                            style: TextStyle(
                                              fontFamily: 'Gotham-Light',
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            )),
                                        Text(provider.contactController.text)
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      )
                      // const CustomCardJSB()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
