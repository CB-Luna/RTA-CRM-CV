// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/ctrlv/homeowner_ftth_document_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_email.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_buttom.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/homeowner_ftth_document/widgets/firma_pdf.dart';
import 'dart:html' as html;

class HomeOwnerFTTHDocument extends StatefulWidget {
  const HomeOwnerFTTHDocument({super.key});

  @override
  State<HomeOwnerFTTHDocument> createState() => _HomeOwnerFTTHDocumentState();
}

class _HomeOwnerFTTHDocumentState extends State<HomeOwnerFTTHDocument> {
  bool hover = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(
        context,
        listen: false,
      );
      await provider.clearAll();
      await provider.crearPDF();
      /*  provider.acountController.text = '';//'8958';
      provider.zipcodeController.text = ''; //'77650';
      provider.emailController.text = '';
      provider.addressController.text = '';
      provider.acountNameController.text = '';
      provider.phoneController.text = '';
      provider.dateController.text = ''; */
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
                  child: Column(
                    children: [
                      //Titulo
                      Padding(
                        padding: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.only(right: 10, left: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Homeowner FTTH Document', style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Contenido
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CustomCard(
                                    width: width * 410,
                                    height: height * 620,
                                    title: 'Document Info',
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomTextField(
                                                width: width * 300,
                                                enabled: true,
                                                controller: provider.acountController,
                                                icon: Icons.settings,
                                                label: 'Account Number',
                                                keyboardType: TextInputType.name,
                                              ),
                                              /*   CustomTextField(
                                                width: width * 140,
                                                enabled: true,
                                                controller: provider.zipcodeController,
                                                icon: Icons.maps_home_work,
                                                label: 'Zip Code',
                                                keyboardType: TextInputType.name,
                                              ), */
                                              CustomTextIconButton(
                                                text: 'Search',
                                                isLoading: false,
                                                icon: Icon(
                                                  Icons.search,
                                                  color: AppTheme.of(context).primaryBackground,
                                                ),
                                                color: AppTheme.of(context).primaryColor,
                                                onTap: () async {
                                                  //Metodo para buscar el account number
                                                  await provider.documentInfo();
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomTextField(
                                                width: width * 280,
                                                enabled: true,
                                                controller: provider.emailController,
                                                icon: Icons.email,
                                                label: 'Account Email',
                                                keyboardType: TextInputType.emailAddress,
                                              ),
                                              CustomTextIconButton(
                                                text: 'Add Email',
                                                isLoading: false,
                                                icon: Icon(
                                                  Icons.add,
                                                  color: AppTheme.of(context).primaryBackground,
                                                ),
                                                color: AppTheme.of(context).primaryColor,
                                                onTap: () {
                                                  setState(() {
                                                    provider.addemail = true;
                                                    provider.agregarContacto();
                                                    // print((provider.emails.toString()));
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        /* provider.addemail == true
                                            ? */
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: CustomTextEmail(
                                              width: width * 380,
                                            )
                                            /*  CustomTextField(
                                                  width: width * 380,
                                                  enabled: true,
                                                  controller: provider.email2Controller,
                                                  icon: Icons.email,
                                                  label: 'Other Email',
                                                  keyboardType: TextInputType.emailAddress,
                                                ), */
                                            ),
                                        // : const SizedBox.shrink(),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            width: width * 380,
                                            enabled: true,
                                            controller: provider.representativeNameController,
                                            icon: Icons.person,
                                            label: 'Designated Representative',
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
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            width: width * 380,
                                            enabled: false,
                                            controller: provider.acountNameController,
                                            icon: Icons.person_pin,
                                            label: 'Account Name',
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
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextIconButton(
                                            width: width * 120,
                                            text: 'Refresh File',
                                            isLoading: false,
                                            icon: Icon(
                                              Icons.refresh,
                                              color: AppTheme.of(context).primaryBackground,
                                            ),
                                            color: AppTheme.of(context).primaryColor,
                                            onTap: () async {
                                              await provider.crearPDF();
                                            },
                                          ),
                                        ),
                                        /*       Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextIconButton(
                                            width: width * 120,
                                            text: 'Popup Preview',
                                            isLoading: false,
                                            icon: Icon(
                                              Icons.refresh,
                                              color: AppTheme.of(context).primaryBackground,
                                            ),
                                            color: AppTheme.of(context).primaryColor,
                                            onTap: () async {
                                              showDialog(
                                                context: context, barrierDismissible: true, // Impide cerrar el diálogo tocando fuera de él
                                                builder: (context) {
                                                  return AlertDialog(
                                                    key: UniqueKey(),
                                                    backgroundColor: Colors.transparent,
                                                    shadowColor: Colors.transparent,
                                                    content: Container(
                                                      width: width * 420,
                                                      height: height * 150,
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
                                                          const Spacer(),
                                                          Text(
                                                            'Document sent successfully',
                                                            textAlign: TextAlign.center,
                                                            style: AppTheme.of(context).title1.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: Colors.green),
                                                          ),
                                                          const Spacer(),
                                                          CustomButton(
                                                            text: 'Close Page',
                                                            icon: const Icon(Icons.close),
                                                            options: ButtonOptions(
                                                              color: AppTheme.of(context).primaryColor,
                                                              iconColor: AppTheme.of(context).primaryBackground,
                                                              textStyle: AppTheme.of(context).title1.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: Colors.white),
                                                              iconSize: 35
                                                            ),
                                                            onPressed: () {
                                                              // Cierra la página actual
                                                              //html.window.close();

                                                              // O redirecciona a una URL específica
                                                              html.window.location.assign('https://rtatel.com/');
                                                            },
                                                          ),
                                                          const Spacer()
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                   */
                                      ],
                                    ),
                                  ),
                                ),
                                /* SizedBox(
                                  width: width * 380,
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      children: [
                                       const Padding(
                                          padding:  EdgeInsets.only(right: 5),
                                          child:  Tooltip(
                                            message: 'The default signature is created based on the account name in an italic format',
                                            child: Icon(Icons.info, size: 20),
                                          ),
                                        ),
                                        Text(
                                          'I agree to use the default signature:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: const Color(0xFF4D4D4D),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          provider.acountNameController.text,
                                          style: const TextStyle(fontSize: 30, fontFamily: 'Raghen'),
                                        ),
                                      ],
                                    ),
                                    value: provider.firmacheck,
                                    onChanged: (value) async {
                                      setState(() {
                                        provider.firmacheck = !provider.firmacheck;
                                      });
                                      await provider.clientPDF();
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: AppTheme.of(context).primaryColor,
                                  ),
                                ),
                                provider.firmacheck == false
                                    ? Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: CustomCard(
                                          title: 'Signature',
                                          width: width * 410,
                                          height: height * 275,
                                          child: const FirmaPDF(),
                                        ),
                                      )
                                    :  */
                                SizedBox(
                                  height: height * 235,
                                ),
                                provider.search == false
                                    ? const SizedBox(
                                        height: 35,
                                      )
                                    : CustomTextIconButton(
                                        isLoading: false,
                                        icon: Icon(Icons.email, color: AppTheme.of(context).primaryBackground),
                                        text: 'Send Document',
                                        onTap: () async {
                                          await provider.crearPDF();
                                          Completer<bool> completer = Completer<bool>();
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false, // Impide cerrar el diálogo tocando fuera de él
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState) {
                                                  return AlertDialog(
                                                    key: UniqueKey(),
                                                    backgroundColor: Colors.transparent,
                                                    shadowColor: Colors.transparent,
                                                    content: Container(
                                                      width: width * 420,
                                                      height: height * 150,
                                                      decoration: BoxDecoration(
                                                        gradient: whiteGradient,
                                                        borderRadius: const BorderRadius.all(
                                                          Radius.circular(21),
                                                        ),
                                                      ),
                                                      child: FutureBuilder<bool>(
                                                        future: completer.future,
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  'Uploading File Please Wait...',
                                                                  textAlign: TextAlign.center,
                                                                  style: AppTheme.of(context).title1,
                                                                ),
                                                                const CircularProgressIndicator()
                                                              ],
                                                            );
                                                          } else {
                                                            if (snapshot.hasError || snapshot.data == false) {
                                                              return Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Error Uploading File',
                                                                    textAlign: TextAlign.center,
                                                                    style: AppTheme.of(context).title1.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: Colors.red),
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
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'Document sent successfully',
                                                                    textAlign: TextAlign.center,
                                                                    style: AppTheme.of(context).title1.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: Colors.green),
                                                                  ),
                                                                  const Icon(
                                                                    Icons.check,
                                                                    color: Colors.green,
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
                                          // Realiza el trabajo asincrónico
                                          bool success = await provider.createHomeowner();
                                          // Completa el Future con el resultado del trabajo
                                          completer.complete(success);
                                          // Cierra el diálogo después de un tiempo
                                          await Future.delayed(const Duration(seconds: 3));
                                          Navigator.pop(context); // Cierra el diálogo
                                          context.pushReplacement(homeownerFTTHDocumentList);
                                        },
                                      ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
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
