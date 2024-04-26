// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/success_toast.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import '../../../../helpers/globals.dart';
import '../../../../widgets/custom_card.dart';
import 'Briefing_form.dart';
import 'create_info_form.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseFlutter;

class CustomCardJSB extends StatefulWidget {
  const CustomCardJSB({super.key});

  @override
  State<CustomCardJSB> createState() => _CustomCardJSBState();
}

class _CustomCardJSBState extends State<CustomCardJSB> {
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(
        context,
        listen: false,
      );

      await provider.clearAll();

      // provider.titleController.text = "Titulo";
      // provider.UserController.text = "Usuario";
      // provider.teamMembers = [];
      // provider.dateController.text = "22/04/2024";
      // provider.issueController.text = "aaa";
      // provider.backgroundController.text = "bbb";
      // provider.analisisController.text = "ccc";
      // provider.recomendationsController.text = "ddd";

      await provider.clientPDF();
    });
  }

  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);
    fToast.init(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CustomCard(
                title: "Create Info",
                height: MediaQuery.of(context).size.height * 0.43,
                width: MediaQuery.of(context).size.width * 0.20,
                child: const CreateInfoForm()),
            const SizedBox(
              height: 30,
            ),
            CustomCard(
              title: "Briefing Details",
              height: MediaQuery.of(context).size.height * 0.43,
              width: MediaQuery.of(context).size.width * 0.20,
              child: const BriefingForm(),
            )
          ],
        ),
        Column(
          children: [
            CustomCard(
                title: "TEMPLATE PREVIEW ",
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.500,
                padding: const EdgeInsets.all(10),
                // width: MediaQuery.of(context).size.width * 0.600,
                child: Container(
                  color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.400,
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
                )),
            InkWell(
              onTap: () async {
                // supabaseFlutter.PostgrestList response =
                //     await provider.mainUpload();
                // var teamResponse;

                // // //DOCUMENT
                // var uploadCorrect = await provider.uploadDocument(
                //   currentUser!.sequentialId,
                //   response[0]['id'],
                // );

                // // // //USERS
                // if (uploadCorrect) {
                //   for (int i = 0; i < provider.teamMembers.length; i++) {
                //     teamResponse =
                //         await provider.teamUpload(i, response, teamResponse);
                //   }
                // }

                // if (!uploadCorrect) {
                //   await ApiErrorHandler.callToast(
                //       'Error to create Safety Briefing Document');
                //   return;
                // }

                // if (!mounted) return;
                // fToast.showToast(
                //   child: const SuccessToast(
                //     message: 'Safety Briefing Added Succesfuly',
                //   ),
                //   gravity: ToastGravity.BOTTOM,
                //   toastDuration: const Duration(seconds: 2),
                // );

                // // context.pushReplacement(routeJSADochument);
                // if (uploadCorrect) {
                //   print("Subido con exito a supabase");
                // }
                // setState(() {});
                context.pushReplacement(routeSafetyBriefingResume);
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
    );
  }
}
