import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/get_image_widget.dart';

import '../../../ctrlv/download_apk/widgets/failed_toastJA.dart';
import '../../doc_creation/widgets/custom_task_input.dart';

class InfoWidgets extends StatefulWidget {
  const InfoWidgets({super.key});

  @override
  State<InfoWidgets> createState() => _InfoWidgetsState();
}

class _InfoWidgetsState extends State<InfoWidgets> {
  @override
  Widget build(BuildContext context) {
    FToast fToast = FToast();

    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: provider.infowidgets == 1
            ? CustomCard(
                title: "Add Image",
                height: height * 320,
                width: width * 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
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
                              provider.webImage = null;
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
                        height: height * 320,
                        width: width * 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                context.pop();
                                context.pop();
                              },
                              child: Container(
                                height: height * 50,
                                // width: width * 120,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: AppTheme.of(context).cryPrimary,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container());
  }
}
