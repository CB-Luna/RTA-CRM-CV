// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toastJA.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/get_image_widget.dart';

import '../../doc_creation/widgets/custom_task_input.dart';

class InfoWidgets extends StatefulWidget {
  const InfoWidgets({super.key});

  @override
  State<InfoWidgets> createState() => _InfoWidgetsState();
}

class _InfoWidgetsState extends State<InfoWidgets> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: provider.infowidgets == 1
            ? CustomCard(
                title: "Add Image",
                // height: height * 320,
                // width: width * 250,
                height: height * 520,
                width: width * 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Select Image",
                          style: TextStyle(
                            fontFamily: 'Gotham-Regular',
                            color: AppTheme.of(context).cryPrimary,
                            fontSize: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // await provider.selectImagesAndGeneratePdf(context);
                            bool valorImage = await provider.selectImage();
                            if (!valorImage) {
                              if (!mounted) return;
                              fToast.showToast(
                                child: const FailedToastJA(
                                    message: 'The image is larger than 1 MB'),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: const Duration(seconds: 2),
                              );
                            }
                          },
                          child: Container(
                            width: width * 105,
                            height: height * 105,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: getAddImageSafetyBrifing(
                              provider.webImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Ha seleccionado un total de :${provider.imageBytesList.length}",
                      style: TextStyle(
                        fontFamily: 'Gotham-Regular',
                        color: AppTheme.of(context).cryPrimary,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Swiper(
                        itemCount: provider.imageBytesList.length,
                        itemBuilder: (context, index) {
                          final urlImage = provider.imageBytesList[index];
                          return Image.memory(urlImage, fit: BoxFit.fill);
                        },
                        itemWidth: 300.0,
                        layout: SwiperLayout.STACK,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              context.pop();
                              context.pop();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppTheme.of(context).cryPrimary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Confirm",
                                    style: AppTheme.of(context).subtitle2),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              // provider.webImage = null;
                              provider.imageBytesList.clear();
                              // context.pop();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppTheme.of(context).odePrimary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Delete Image",
                                    style: AppTheme.of(context).subtitle2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : provider.infowidgets == 2
                ? CustomCard(
                    title: "Add URL",
                    height: height * 250,
                    width: width * 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomtaskTextInput(
                          task: "Add URL",
                          controller: provider.urlController,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              context.pop();
                              context.pop();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppTheme.of(context).cryPrimary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Confirm",
                                    style: AppTheme.of(context).subtitle2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : provider.infowidgets == 3
                    ? CustomCard(
                        title: "Add File",
                        // height: height * 320,
                        // width: width * 250,
                        height: height * 680,
                        // width: width * 600,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // context.pop();
                                    // context.pop();
                                    provider.pickProveedorDoc();
                                  },
                                  child: Container(
                                    height: height * 50,
                                    width: width * 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: AppTheme.of(context).cryPrimary,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Add File",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Icon(
                                          Icons.upload_file_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // context.pop();
                                    // context.pop();
                                    Completer<bool> completer =
                                        Completer<bool>();
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // Impide cerrar el diálogo tocando fuera de él
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return AlertDialog(
                                              key: UniqueKey(),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              content: Container(
                                                width: width * 420,
                                                height: height * 150,
                                                decoration: BoxDecoration(
                                                  gradient: whiteGradient,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(21),
                                                  ),
                                                ),
                                                child: FutureBuilder<bool>(
                                                  future: completer.future,
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Uploading File Please Wait...',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTheme.of(
                                                                    context)
                                                                .title1,
                                                          ),
                                                          const CircularProgressIndicator()
                                                        ],
                                                      );
                                                    } else {
                                                      if (snapshot.hasError ||
                                                          snapshot.data ==
                                                              false) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Error Uploading File',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .title1
                                                                  .override(
                                                                      fontFamily:
                                                                          'Gotham-Regular',
                                                                      useGoogleFonts:
                                                                          false,
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            const Icon(
                                                              Icons.error,
                                                              color: Colors.red,
                                                              size: 30,
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Uploaded PDF successfully',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .title1
                                                                  .override(
                                                                      fontFamily:
                                                                          'Gotham-Regular',
                                                                      useGoogleFonts:
                                                                          false,
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                            const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 30,
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                    var uploadCorrect =
                                        provider.uploadDocumentComplement();

                                    completer.complete(uploadCorrect);
                                    // Cierra el diálogo después de un tiempo
                                    await Future.delayed(
                                        const Duration(seconds: 3));
                                    Navigator.pop(context);
                                    context.pop();
                                  },
                                  child: Container(
                                    height: height * 50,
                                    width: width * 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: AppTheme.of(context).cryPrimary,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Upload File",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Icon(
                                          Icons.send_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // provider.pickProveedorDoc();
                                    // provider.pdfControllerPDF = null;
                                    // provider.documentoComplement.clear();
                                    // setState(() {});
                                    provider.deleteFile();
                                  },
                                  child: Container(
                                    height: height * 50,
                                    width: width * 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: AppTheme.of(context).odePrimary,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 680,
                              width: width * 600,
                              child: provider.pdfControllerPDF == null
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
                                      controller: provider.pdfControllerPDF!,
                                      onDocumentLoaded: (document) {},
                                      onPageChanged: (page) {},
                                      onDocumentError: (error) {},
                                    ),
                            ),
                          ],
                        ),
                      )
                    : Container());
  }
}
