import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/token_safety.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'dart:html' as html;

import 'package:rta_crm_cv/widgets/success_toast.dart';

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

      // await provider.pickDocumentSafetyBriefing(51);
      await provider.pickDocumentSafetyBriefing(widget.token.documentId);

      // await provider.clientPDF();

      // provider.anexo = false;
      // provider.firmaAnexo = false;
    });
  }

  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);

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
                            var uploadCorrect = provider.updateUserStatus(
                                widget.token.documentId, widget.token.userfk);
                            // var uploadCorrect = await provider.updateUserStatus(
                            //     51, "d4a1ca9c-19b0-4302-a1dc-a4429e342766");
                            Completer<bool> completer = Completer<bool>();
                            if (!mounted) return;
                            fToast.showToast(
                              child: const SuccessToast(
                                message:
                                    'Safety Briefing Document Accepted Succesfully',
                              ),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: const Duration(seconds: 2),
                            );
                            completer.complete(uploadCorrect);
                            // Cierra el diálogo después de un tiempo
                            await Future.delayed(const Duration(seconds: 3));
                            html.window.location.assign('https://rtatel.com/');
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
                          // width: 750,
                          // height: 750,
                          width: width * 810,
                          height: height * 820,
                          decoration: BoxDecoration(
                            gradient: whiteGradient,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(21),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // const Spacer(),
                                  // //Pantalla Completa
                                  // Padding(
                                  //   padding: const EdgeInsets.all(20),
                                  //   child: IconButton(
                                  //       icon: Icon(Icons.fullscreen,
                                  //           color: AppTheme.of(context)
                                  //               .primaryColor),
                                  //       tooltip: 'Full Screen',
                                  //       color:
                                  //           AppTheme.of(context).primaryColor,
                                  //       onPressed: () async {}),
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              content: SizedBox(
                                                width: width * 1000,
                                                height: height * 1000,
                                                child: PdfView(
                                                  backgroundDecoration:
                                                      const BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(21),
                                                    ),
                                                  ),
                                                  controller:
                                                      provider.pdfController!,
                                                ),
                                              ));
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: width * 50,
                                      width: height * 125,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              AppTheme.of(context).cryPrimary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.fullscreen,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Expand",
                                            style:
                                                AppTheme.of(context).subtitle2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 25,
                                  ),
                                  //Descargar Anexo
                                  InkWell(
                                    onTap: () {
                                      provider.descargarArchivo(
                                          provider.documento,
                                          provider.nameSafetyBriefing
                                              .first["doc_name"]);
                                      // provider.anexo = true;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: width * 50,
                                      width: height * 125,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              AppTheme.of(context).cryPrimary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.download_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Download",
                                            style:
                                                AppTheme.of(context).subtitle2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )

                                  // Padding(
                                  //   padding: const EdgeInsets.all(20),
                                  //   child: IconButton(
                                  //     icon: Icon(Icons.file_download_outlined,
                                  //         color: AppTheme.of(context)
                                  //             .primaryColor),
                                  //     tooltip: 'Download',
                                  //     color: AppTheme.of(context).primaryColor,
                                  //     onPressed: () {
                                  //       provider.descargarArchivo(
                                  //           provider.documento,
                                  //           provider.nameSafetyBriefing
                                  //               .first["doc_name"]);
                                  //       // provider.anexo = true;
                                  //       setState(() {});
                                  //     },
                                  //   ),
                                  // ),

                                  // const Spacer(),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(20),
                                  //   child: IconButton(
                                  //     icon: Icon(Icons.close,
                                  //         color: AppTheme.of(context)
                                  //             .primaryColor),
                                  //     tooltip: 'Exit',
                                  //     color: AppTheme.of(context).primaryColor,
                                  //     onPressed: () {
                                  //       provider.pdfController = null;
                                  //       Navigator.pop(context);
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff262626),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              AppTheme.of(context).primaryColor,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: provider.pdfController == null
                                          ? const CircularProgressIndicator()
                                          : PdfView(
                                              pageSnapping: false,
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              renderer: (PdfPage page) {
                                                if (page.width >= page.height) {
                                                  return page.render(
                                                    width: page.width * 7,
                                                    height: page.height * 4,
                                                    format:
                                                        PdfPageImageFormat.jpeg,
                                                    backgroundColor: '#15FF0D',
                                                  );
                                                } else if (page.width ==
                                                    page.height) {
                                                  return page.render(
                                                    width: page.width * 4,
                                                    height: page.height * 4,
                                                    format:
                                                        PdfPageImageFormat.jpeg,
                                                    backgroundColor: '#15FF0D',
                                                  );
                                                } else {
                                                  return page.render(
                                                    width: page.width * 4,
                                                    height: page.height * 7,
                                                    format:
                                                        PdfPageImageFormat.jpeg,
                                                    backgroundColor: '#15FF0D',
                                                  );
                                                }
                                              },
                                              controller:
                                                  provider.pdfController!,
                                              onDocumentLoaded: (document) {},
                                              onPageChanged: (page) {},
                                              onDocumentError: (error) {},
                                            )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: width * 810,
                        //   height: height * 820,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(8),
                        //     border: Border.all(
                        //       color: AppTheme.of(context).primaryColor,
                        //       width: 1.5,
                        //     ),
                        //   ),
                        //   child: provider.finalPdfController == null
                        //       ? const CircularProgressIndicator()
                        //       : PdfView(
                        //           pageSnapping: false,
                        //           scrollDirection: Axis.vertical,
                        //           physics: const BouncingScrollPhysics(),
                        //           renderer: (PdfPage page) {
                        //             if (page.width >= page.height) {
                        //               return page.render(
                        //                 width: page.width * 7,
                        //                 height: page.height * 4,
                        //                 format: PdfPageImageFormat.jpeg,
                        //                 backgroundColor: '#15FF0D',
                        //               );
                        //             } else if (page.width == page.height) {
                        //               return page.render(
                        //                 width: page.width * 4,
                        //                 height: page.height * 4,
                        //                 format: PdfPageImageFormat.jpeg,
                        //                 backgroundColor: '#15FF0D',
                        //               );
                        //             } else {
                        //               return page.render(
                        //                 width: page.width * 4,
                        //                 height: page.height * 7,
                        //                 format: PdfPageImageFormat.jpeg,
                        //                 backgroundColor: '#15FF0D',
                        //               );
                        //             }
                        //           },
                        //           controller: provider.finalPdfController!,
                        //           onDocumentLoaded: (document) {},
                        //           onPageChanged: (page) {},
                        //           onDocumentError: (error) {},
                        //         ),
                        // ),
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
