// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/user.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/pages/jsa/jsa_training/widgets/pdf_viewer_page.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_training_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import '../../../../widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseFlutter;

class AddTraining extends StatefulWidget {
  const AddTraining({super.key});

  @override
  State<AddTraining> createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  @override
  Widget build(BuildContext context) {
    JsaTrainingProvider provider = Provider.of<JsaTrainingProvider>(context);
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          // String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
          String formattedDate = DateFormat('MMM/dd/yyyy').format(picked);

          provider.creationDateController.text = formattedDate;
          // provider.dateController.text = picked
          //     .toString(); // Aquí puedes formatear la fecha según tus necesidades
        });
      }
    }

    Future<void> selectDateDue(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          String formattedDate = DateFormat('MMM/dd/yyyy').format(picked);
          provider.expirationDateController.text = formattedDate;
          // provider.dateController.text = picked
          //     .toString(); // Aquí puedes formatear la fecha según tus necesidades
        });
      }
    }

    // List<String> users = ['Alice', 'Bob', 'Charlie', 'Dave', 'Eve'];
    // provider.getListUsers("CRY");
    // provider.selectedUser = null;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height * 950,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          CustomCard(
              title: "Add Training",
              height: height * 680,
              width: width * 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomtaskTextInput(
                    task: "Name Training",
                    controller: provider.titleController,
                  ),
                  Visibility(
                    visible: currentUser!.isAdminJSA,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .2,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const CustomDropSafety(
                            title: "OpCo Name",
                          ),
                          DropdownButton<String>(
                            hint: const Text(
                              'Select User',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF335594),
                              ),
                            ),
                            value: provider.selectedUser?.id,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                provider.selectUser(newValue);
                              }
                            },
                            items: provider.users
                                .map<DropdownMenuItem<String>>((User user) {
                              return DropdownMenuItem<String>(
                                value: user.id,
                                child: Text(user.name),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            provider.selectedUser == null
                                ? 'No user selected'
                                : 'User Selected: ${provider.selectedUser!.fullName}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF335594),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currentUser!.isTechnicianJSA,
                    child: CustomtaskTextInput(
                      task: currentUser!.name,
                      controller: provider.nameController,
                    ),
                  ),
                  Visibility(
                    visible: currentUser!.isTechnicianJSA,
                    child: CustomtaskTextInput(
                      task: currentUser!.lastName,
                      controller: provider.lastNameController,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        child: Text(
                          "Training Creation Date",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF737373),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          controller: provider.creationDateController,
                          readOnly: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Date';
                            }
                            // Puedes agregar más validaciones aquí (por ejemplo, para verificar un formato de email válido).
                            return null; // Retorna null si la validación es exitosa.
                          },
                          decoration: InputDecoration(
                            labelText: 'Training Creation Date',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                selectDate(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        child: Text(
                          "Training Expiration Date",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF737373),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: TextFormField(
                          controller: provider.expirationDateController,
                          readOnly: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Date';
                            }
                            // Puedes agregar más validaciones aquí (por ejemplo, para verificar un formato de email válido).
                            return null; // Retorna null si la validación es exitosa.
                          },
                          decoration: InputDecoration(
                            labelText: 'Training Expiration Date',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                selectDateDue(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      Completer<bool> completer = Completer<bool>();
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Impide cerrar el diálogo tocando fuera de él
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
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
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Uploading File Please Wait...',
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppTheme.of(context).title1,
                                            ),
                                            const CircularProgressIndicator()
                                          ],
                                        );
                                      } else {
                                        if (snapshot.hasError ||
                                            snapshot.data == false) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Error Uploading File',
                                                textAlign: TextAlign.center,
                                                style: AppTheme.of(context)
                                                    .title1
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color: Colors.red),
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
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Uploading File successfully',
                                                textAlign: TextAlign.center,
                                                style: AppTheme.of(context)
                                                    .title1
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color: Colors.green),
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
                      var uploadCorrect;
                      supabaseFlutter.PostgrestList response;
                      if (currentUser!.isAdminJSA) {
                        response = await provider.createTrainingAdmin();
                      } else {
                        response = await provider.createTrainingUser();
                      }
                      provider.pdfControllerPDF == null
                          // ? const CircularProgressIndicator()
                          ? provider.webImage == null
                              ? null
                              : uploadCorrect = await provider.uploadImage(
                                  response[0]['id_training'],
                                )
                          : uploadCorrect = await provider.uploadDocument(
                              currentUser!.sequentialId,
                              response[0]['id_training'],
                            );
                      // var uploadCorrect = await provider.uploadDocument(
                      //   currentUser!.sequentialId,
                      //   response[0]['id'],
                      // );
                      // var uploadCorrect = await provider.uploadImage();
                      // Completa el Future con el resultado del trabajo
                      completer.complete(uploadCorrect);
                      // Cierra el diálogo después de un tiempo
                      await Future.delayed(const Duration(seconds: 3));
                      Navigator.pop(context); // Cierra el diálogo
                      context.pushReplacement(routeTrainingList);
                    },
                    child: Container(
                      height: height * 65,
                      width: width * 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppTheme.of(context).cryPrimary,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_outlined,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Upload Training File",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          CustomCard(
            title: "Training File Preview",
            height: height * 680,
            width: width * 600,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextIconButton(
                                  color: provider.docProveedorPDF != null
                                      ? AppTheme.of(context).cryPrimary
                                      : AppTheme.of(context).odePrimary,
                                  isLoading: false,
                                  icon: Icon(
                                    provider.docProveedorPDF != null
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.picture_as_pdf_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                  ),
                                  text: 'Upload pdf',
                                  onTap: () {
                                    provider.pickProveedorDoc();
                                    provider.webImage = null;
                                    provider.pdfController = null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: CustomTextIconButton(
                                  color: provider.webImage != null
                                      ? AppTheme.of(context).cryPrimary
                                      : AppTheme.of(context).odePrimary,
                                  isLoading: false,
                                  icon: Icon(
                                    provider.webImage != null
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.add_photo_alternate_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                  ),
                                  text: 'Upload Image',
                                  onTap: () {
                                    // provider.pickDoc();
                                    provider.selectImage();
                                    provider.docProveedorPDF = null;
                                    provider.pdfControllerPDF = null;
                                  },
                                ),
                              ),
                              // const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: CustomTextIconButton(
                                  color: AppTheme.of(context).odePrimary,
                                  isLoading: false,
                                  icon: Icon(
                                    provider.webImage != null
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.add_photo_alternate_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                  ),
                                  text: 'Delete File',
                                  onTap: () {
                                    // provider.pickDoc();
                                    provider.deleteFile();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: height * 680,
                  width: width * 600,
                  child: provider.pdfControllerPDF == null
                      // ? const CircularProgressIndicator()
                      ? provider.webImage == null
                          ? null // Aquí puedes retornar null o cualquier otro widget que desees cuando imageBytes es nulo
                          : Image.memory(provider.webImage!)
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
        ]));
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

String text = "CRY";

class CustomDropSafety extends StatefulWidget {
  final String title;
  const CustomDropSafety({Key? key, required this.title});

  @override
  _CustomDropSafetyState createState() => _CustomDropSafetyState();
}

class _CustomDropSafetyState extends State<CustomDropSafety> {
  @override
  Widget build(BuildContext context) {
    // JsaProvider provider = Provider.of<JsaProvider>(context);
    JsaTrainingProvider provider = Provider.of<JsaTrainingProvider>(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Color(0xFF737373),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFF335594), width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton(
                value: text,
                items: const [
                  DropdownMenuItem(
                    value: "CRY",
                    child: Text("CRY"),
                  ),
                  DropdownMenuItem(
                    value: "ODE",
                    child: Text("ODE"),
                  ),
                  DropdownMenuItem(
                    value: "SMI",
                    child: Text("SMI"),
                  ),
                  DropdownMenuItem(
                    value: "RTA",
                    child: Text("RTA"),
                  ),
                ],
                onChanged: (value) {
                  text = value.toString();
                  provider.companyController.text = text;
                  // print(provider.companyController.text);
                  provider.getListUsers(provider.companyController.text);

                  // if (provider.companyController.text ==
                  //     provider.companyController.text) {
                  //   provider.teamMembers.clear();
                  // }
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
