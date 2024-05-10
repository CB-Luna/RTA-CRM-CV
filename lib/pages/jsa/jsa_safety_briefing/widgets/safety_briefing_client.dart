import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/models/token.dart';
import 'package:rta_crm_cv/models/token_safety.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'dart:html' as html;

class SafetyBriefingClient extends StatefulWidget {
  const SafetyBriefingClient({
    super.key,
    required this.token,
  });

  final TokenSafety token;

  @override
  State<SafetyBriefingClient> createState() => _SafetyBriefingClientState();
}

class _SafetyBriefingClientState extends State<SafetyBriefingClient> {
  bool hover = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(
        context,
        listen: false,
      );
      await provider.documentInfoSafety(
          widget.token.documentId, widget.token.userfk);

      await provider.updateStatusOpenSB(
          widget.token.documentId, widget.token.userfk);
      // await provider.updateStatusOpenSB(
      //     51, "d4a1ca9c-19b0-4302-a1dc-a4429e342766");
      // await provider.documentInfoSafety(
      //     51, "d4a1ca9c-19b0-4302-a1dc-a4429e342766");

      await provider.clientPDF();

      // provider.anexo = false;
      // provider.firmaAnexo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: whiteGradient),
          child: CustomScrollBar(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                //Titulo
                SizedBox(
                  height: 40,
                  child: Text('Safety Briefing Document',
                      style: AppTheme.of(context).title1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 8),
                          child: CustomCard(
                            width: width * 410,
                            // height: height * 580,
                            height: height * 620,
                            title: 'Document Info',
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.titleController,
                                    icon: Icons.settings,
                                    label: 'Safety Title',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.dateController,
                                    icon: Icons.email,
                                    label: 'Date',
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.datedueController,
                                    icon: Icons.person,
                                    label: 'Due Date',
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.statusController,
                                    icon: Icons.person,
                                    label: 'Status',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.issueController,
                                    icon: Icons.person,
                                    label: 'Issue',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.backgroundController,
                                    icon: Icons.person,
                                    label: 'Background',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller:
                                        provider.recomendationsController,
                                    icon: Icons.person,
                                    label: 'Recommendations',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextField(
                                    width: width * 380,
                                    enabled: false,
                                    controller: provider.contactController,
                                    icon: Icons.person,
                                    label: 'Contact',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          // height: height * 235,
                          height: height * 150,
                        ),
                        CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.check_box_outlined,
                              color: AppTheme.of(context).primaryBackground),
                          text: 'Accept',
                          onTap: () async {
                            provider.updateUserStatus(
                                widget.token.documentId, widget.token.userfk);
                            // await provider.updateUserStatus(
                            //     51, "d4a1ca9c-19b0-4302-a1dc-a4429e342766");
                            html.window.close();
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomCard(
                        width: width * 810,
                        title: 'Document Preview',
                        child: Container(
                          width: width * 810,
                          height: height * 820,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppTheme.of(context).primaryColor,
                              width: 1.5,
                            ),
                          ),
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
                                    } else if (page.width == page.height) {
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
                                  controller: provider.finalPdfController!,
                                  onDocumentLoaded: (document) {},
                                  onPageChanged: (page) {},
                                  onDocumentError: (error) {},
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
