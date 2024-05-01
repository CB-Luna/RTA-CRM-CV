// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/success_toast.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseFlutter;

import '../../../helpers/constants.dart';
import '../../../providers/jsa/jsa_provider.dart';
import '../../../theme/theme.dart';
import 'widgets/pdf_full_size.dart';

TextEditingController titleController = TextEditingController();
TextEditingController taskController = TextEditingController();
TextEditingController companyController = TextEditingController();

class CustomDocCreationFinalDocument extends StatefulWidget {
  const CustomDocCreationFinalDocument({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDocCreationFinalDocument> createState() =>
      _CustomDocCreationFinalDocumentState();
}

class _CustomDocCreationFinalDocumentState
    extends State<CustomDocCreationFinalDocument> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    JsaProvider provider = Provider.of<JsaProvider>(context);
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    fToast.init(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      // alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                  title: "JSA PREVIEW",
                  height: MediaQuery.of(context).size.height * 0.79,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: IconButton(
                                icon: Icon(Icons.fullscreen,
                                    color: AppTheme.of(context).primaryColor),
                                tooltip: 'Full Screen',
                                color: AppTheme.of(context).primaryColor,
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          content: SizedBox(
                                            width: width * 1000,
                                            height: height * 1000,
                                            child: PdfView(
                                              backgroundDecoration:
                                                  const BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(21),
                                                ),
                                              ),
                                              controller:
                                                  provider.finalPdfController!,
                                            ),
                                          ));
                                    },
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: IconButton(
                              icon: Icon(Icons.file_download_outlined,
                                  color: AppTheme.of(context).primaryColor),
                              tooltip: 'Download',
                              color: AppTheme.of(context).primaryColor,
                              onPressed: () {
                                provider.descargarArchivo(provider.documento!,
                                    '${provider.jsaGeneralInfo!.title}');
                                // provider.anexo = true;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      provider.finalPdfController == null
                          ? const CircularProgressIndicator()
                          : PdfFullSize(
                              pdfController: provider.finalPdfController!,
                            ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                CustomCard(
                    title: "JSA TEMPLATE PREVIEW ",
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: SizedBox(
                      child: Row(
                        children: [
                          Container(
                            color: Colors.grey,
                            height: MediaQuery.of(context).size.height * 0.2,
                            // width: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.height * 0.2,
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
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              alignment: Alignment.topCenter,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Title : ",
                                      style: TextStyle(
                                        fontFamily: 'Gotham-Light',
                                        color: AppTheme.of(context).cryPrimary,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                      )),
                                  Text(
                                      provider.jsaGeneralInfo?.title ??
                                          "No Name",
                                      style: TextStyle(
                                        fontFamily: 'Gotham-Light',
                                        color: AppTheme.of(context).odePrimary,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                      )),
                                  Text("Task: ",
                                      style: TextStyle(
                                        fontFamily: 'Gotham-Light',
                                        color: AppTheme.of(context).cryPrimary,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                      )),
                                  Text(
                                      provider.jsaGeneralInfo?.taskName ??
                                          "No Task",
                                      style: TextStyle(
                                        fontFamily: 'Gotham-Light',
                                        color: AppTheme.of(context).cryPrimary,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                      )),
                                  Text("Creation Date: ",
                                      style: TextStyle(
                                        fontFamily: 'Gotham-Light',
                                        color: AppTheme.of(context).cryPrimary,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                      )),
                                  Text(provider.date.toString(),
                                      style: AppTheme.of(context).bodyText2)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    provider.setButtonViewTaped(2);
                    provider.setIcons(2);
                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.04,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppTheme.of(context).cryPrimary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_left_outlined,
                          color: Colors.white,
                        ),
                        Text("Previous", style: AppTheme.of(context).subtitle2),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // provider.setButtonViewTaped(2);
                    // provider.setIcons(2);
                    //PDF
                    var pdfDesglose =
                        await provider.finalPdfController!.document;

                    Map<String, dynamic> risksData = {};
                    var stepResponse;
                    var teamResponse;

                    int company = 1000;

                    // Subir el JSA
                    supabaseFlutter.PostgrestList response =
                        await provider.mainUpload(provider, company);
                    //STEPS
                    for (int i = 0;
                        i < provider.jsa.jsaStepsJson!.length;
                        i++) {
                      stepResponse = await provider.stepUpload(
                          provider, i, response, stepResponse);
                      //RISKS
                      for (int x = 0;
                          x < provider.jsa.jsaStepsJson![i].risks.length;
                          x++) {
                        await provider.riskUpload(provider, i, x, stepResponse);
                      }
                      // Controls
                      for (int x = 0;
                          x < provider.jsa.jsaStepsJson![i].controls.length;
                          x++) {
                        await provider.controlUpload(
                            provider, i, x, stepResponse);
                      }
                    }

                    //DOCUMENT
                    var uploadCorrect = await provider.uploadDocument(
                      currentUser!.sequentialId,
                      response[0]['id'],
                    );
                    // //USERS
                    if (uploadCorrect) {
                      for (int i = 0;
                          i < provider.jsa.teamMembers!.length;
                          i++) {
                        teamResponse = await provider.teamUpload(
                            provider, i, response, teamResponse);

                        await provider.linkTemplateMembers(
                            provider.jsa.teamMembers![i].id.toString(),
                            response[0]['id']);
                      }
                    }

                    if (!uploadCorrect) {
                      await ApiErrorHandler.callToast(
                          'Error to create JSA Document');
                      return;
                    }

                    if (!mounted) return;
                    fToast.showToast(
                      child: const SuccessToast(
                        message: 'JSA Document Added Succesfuly',
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );

                    context.pushReplacement(routeJSADochument);

                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.04,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppTheme.of(context).cryPrimary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_left_outlined,
                          color: Colors.white,
                        ),
                        Text("Submit", style: AppTheme.of(context).subtitle2),
                      ],
                    ),
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
