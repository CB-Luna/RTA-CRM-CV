import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/ctrlv/homeowner_ftth_document_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import 'widgets/firma_pdf.dart';

class HomeOwnerFTTHDocumentClient extends StatefulWidget {
  const HomeOwnerFTTHDocumentClient({super.key});

  @override
  State<HomeOwnerFTTHDocumentClient> createState() => _HomeOwnerFTTHDocumentClientState();
}

class _HomeOwnerFTTHDocumentClientState extends State<HomeOwnerFTTHDocumentClient> {
  bool hover = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(
        context,
        listen: false,
      );
      await provider.documentInfoClient(10);
      provider.anexo = false;
      provider.firmaAnexo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(context);
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Titulo
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.pushReplacement(homeownerFTTHDocumentList);
                                  },
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: AppTheme.of(context).primaryColor,
                                    size: 35,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 40,
                                    child: Text('Homeowner FTTH Document', style: AppTheme.of(context).title1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomCard(
                              width: width * 410,
                              height: height * 580,
                              title: 'Document Info',
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.acountController,
                                      icon: Icons.settings,
                                      label: 'Acount Number',
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.zipcodeController,
                                      icon: Icons.settings,
                                      label: 'Zip Code',
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.emailController,
                                      icon: Icons.email,
                                      label: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.representativeNameController,
                                      icon: Icons.person,
                                      label: 'Representative Name',
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.addressController,
                                      icon: Icons.location_on,
                                      label: 'Address',
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.dateController,
                                      icon: Icons.calendar_month,
                                      label: 'Creation Date',
                                      keyboardType: TextInputType.datetime,
                                    ),
                                  ),
                                  /* Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomTextIconButton(
                                    isLoading: false,
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      color: AppTheme.primary,
                                    ),
                                    text: 'Date: ${DateFormat('MMMM, MM-dd-yyyy').format(provider.create)}',
                                    style: const TextStyle(color: AppTheme.primary),
                                    onTap: () {
                                      provider.selectdate(context);
                                    },
                                    color: AppTheme.primaryBackground,
                                  ),
                                ), */
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.acountNameController,
                                      icon: Icons.person_pin,
                                      label: 'Acount Name',
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextField(
                                      width: width * 380,
                                      enabled: false,
                                      controller: provider.phoneController,
                                      icon: Icons.phone,
                                      label: 'Phone Number',
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomCard(
                              title: 'Signature',
                              width: width * 410,
                              height: height * 275,
                              child: const FirmaPDF(),
                            ),
                          ),
                          CustomTextIconButton(
                            isLoading: false,
                            icon: Icon(Icons.email, color: AppTheme.of(context).primaryBackground),
                            text: 'Send Document',
                            onTap: () async {
                              //pendiente metodo y apis
                              if (await provider.updateDocument()) {
                                if (!mounted) return;
                                Fluttertoast.showToast(
                                  msg: 'sent successfully',
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: AppTheme.of(context).primaryColor,
                                  textColor: AppTheme.of(context).primaryBackground,
                                  fontSize: 16.0,
                                  webBgColor: "linear-gradient(to right, #0XFF2E78FF, #0x00FFFFFF)",
                                  webPosition: "center",
                                );
                                setState(() {
                                  provider.ejecBloq = false;
                                });
                              } else {
                                if (!mounted) return;
                                Fluttertoast.showToast(
                                  msg: 'sent error',
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: AppTheme.of(context).secondaryColor,
                                  textColor: AppTheme.of(context).primaryBackground,
                                  fontSize: 16.0,
                                  webBgColor: "linear-gradient(to right, #B2333A, #4D4D4D)",
                                  webPosition: "center",
                                );
                              }
                            },
                          ),
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
                            child: provider.pdfController == null
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
                                    controller: provider.pdfController!,
                                    onDocumentLoaded: (document) {},
                                    onPageChanged: (page) {},
                                    onDocumentError: (error) {},
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
