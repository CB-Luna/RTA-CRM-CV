// ignore_for_file: library_private_types_in_public_api, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../../models/jsa/jsa_general_information.dart';
import '../../../../../providers/jsa/jsa_provider.dart';
import '../../risks_hazards_widget.dart';
import '../CustomTextInput.dart';

showRiskPopup(BuildContext context, String title, String stepId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomRiskPopup(
        title: title,
        stepId: stepId,
      );
    },
  );
}

class CustomRiskPopup extends StatefulWidget {
  final String title;
  final String stepId;
  const CustomRiskPopup({super.key, required this.title, required this.stepId});
  @override
  // ignore: library_private_types_in_public_api
  _CustomRiskPopupState createState() => _CustomRiskPopupState();
}

class _CustomRiskPopupState extends State<CustomRiskPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      // Aqui Controlo la altura del recuadro
      child: SizedBox(
          // width: 100,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.2,
          child: contentBox(context, stepId: widget.stepId)),
    );
  }

  contentBox(context, {required String stepId}) {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context);
    // Find the JsaStepsJson object with the matching title
    JsaStepsJson? matchingStep =
        jsaProvider.jsa.jsaStepsJson!.firstWhere((step) => step.id == stepId);

// Get the length of risks if a matching step is found, otherwise set to 0
    // int risksLength = matchingStep.risks.length ?? 0;
    int risksLength = matchingStep.risks.length;
    // Este es pero no reacciona los width

    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF335594)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "List of Risk",
              style: AppTheme.of(context).title3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF335594)),
                ),
                const Spacer(),
                // Aqui está el boton para agregar un Risk
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFF335594),
                  ),
                  onPressed: () async {
                    controlNameController.text = "";
                    jsaProvider.editControl = false;
                    showAddRiskPopup(context, widget.title, widget.stepId);
                    // Este set state es para que cuando le des otra vez, se vean cada uno.
                    setState(() {});
                  },
                ),
              ],
            ),
            for (var i = 0; i < risksLength; i++)
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Menu Icon
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                      child: const Icon(
                        Icons.more_vert_outlined,
                        color: Color(0xFF335594),
                        size: 24,
                      ),
                    ),
                    // Text "Steps"
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: Text(
                        matchingStep.risks[i].title.toString(),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF335594),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),

                    // const Spacer(),
                    // Open/Close   Button
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFF335594),
                      ),
                      onPressed: () {
                        //ToDo: hacer que esto funcione correctamente
                        setState(() {
                          showRiskDeleteConfirmation(
                              context,
                              matchingStep.risks[i].title.toString(),
                              widget.stepId,
                              widget.title);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_document,
                        color: Color(0xFF335594),
                      ),
                      onPressed: () {
                        jsaProvider.editControl = true;

                        controlNameController.text =
                            matchingStep.risks[i].title.toString();
                        jsaProvider.compareRiskTitle =
                            controlNameController.text;
                        showAddRiskPopup(context, widget.title, widget.stepId);
                        // setState(() {
                        //   showAddRiskPopup(
                        //       context, widget.title, widget.stepId);
                        // });
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

showRiskDeleteConfirmation(
    BuildContext context, String riskTitle, String stepId, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteRiskConfirmationDialog(
        riskTitle: riskTitle,
        stepId: stepId,
        title: title,
      );
    },
  );
}

class DeleteRiskConfirmationDialog extends StatefulWidget {
  final riskTitle, title, stepId;

  const DeleteRiskConfirmationDialog(
      {super.key, required this.riskTitle, this.title, this.stepId});

  @override
  State<DeleteRiskConfirmationDialog> createState() =>
      _DeleteRiskConfirmationDialogState();
}

class _DeleteRiskConfirmationDialogState
    extends State<DeleteRiskConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Delete Confirmation',
        style: TextStyle(
          fontSize: 18.0,
          color: Color(0xFF335594),
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this item?',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: 'Quicksand',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF335594),
            )),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel',
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF335594),
          )),
          onPressed: () {
            // Perform delete operation here
            setState(() {
              _deleteRiskItem(widget.riskTitle, jsaProvider);
            });
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            // showRiskPopup(
            //   context,
            //   widget.title,
            //   widget.stepId,
            // );
          },
          child: const Text('Delete',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  _deleteRiskItem(String riskTitle, JsaProvider jsaProvider) {
    setState(() {
      jsaProvider.deleteJsaRisk(riskTitle);
    });
  }
}

// Show Add Risk
showAddRiskPopup(BuildContext context, String title, String stepId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAddRiskPopup(
        title: title,
        stepId: stepId,
      );
    },
  );
}

class CustomAddRiskPopup extends StatefulWidget {
  const CustomAddRiskPopup(
      {super.key, required this.title, required this.stepId});
  final String title;
  final String stepId;
  @override
  _CustomAddRiskPopupState createState() => _CustomAddRiskPopupState();
}

class _CustomAddRiskPopupState extends State<CustomAddRiskPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  // Este es agregar el risk
  contentBox(context) {
    JsaProvider provider = Provider.of<JsaProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            provider.editControl == false ? 'Add Risk' : 'Edit Risk',
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF335594)),
          ),
          const SizedBox(height: 16.0),
          CustomTextInput(
              title: 'Risk Name', controller: controlNameController),
          const SizedBox(height: 16.0),
          // CustomTextInput(
          //     title: 'Step Description', controller: stepDescriptionController),
          // SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF335594),
                )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF335594),
                )),
                onPressed: () async {
                  // Save your data or perform any action here
                  if (provider.editControl == false) {
                    provider.addJsaRisks(
                        controlNameController.text, widget.stepId);
                  } else {
                    provider.editJsaRisk(provider.compareRiskTitle.toString(),
                        widget.stepId.toString(), controlNameController.text);
                  }
                  // _saveData();
                  // setState(() {});

                  Navigator.of(context).pop();
                },
                child: const Text('Save',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // _saveData() {
  //   JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

  //   // Perform save operation with stepNameController.text and stepDescriptionController.text
  //   if (editControl == false) {
  //     jsaProvider.addJsaRisks(controlNameController.text, widget.stepId);
  //   } else {
  //     //agregar funcionalidad edit risks
  //     jsaProvider.editJsaRisk(compareRiskTitle.toString(),
  //         widget.stepId.toString(), controlNameController.text);
  //   }
  //   setState(() {});
  // }
}



// // ignore_for_file: library_private_types_in_public_api, duplicate_ignore
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rta_crm_cv/theme/theme.dart';

// import '../../../../../models/jsa/jsa_general_information.dart';
// import '../../../../../providers/jsa/jsa_provider.dart';
// import '../../risks_hazards_widget.dart';
// import '../CustomTextInput.dart';

// showRiskPopup(BuildContext context, String title, String stepId) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CustomRiskPopup(
//         title: title,
//         stepId: stepId,
//       );
//     },
//   );
// }

// class CustomRiskPopup extends StatefulWidget {
//   final String title;
//   final String stepId;
//   const CustomRiskPopup({super.key, required this.title, required this.stepId});
//   @override
//   // ignore: library_private_types_in_public_api
//   _CustomRiskPopupState createState() => _CustomRiskPopupState();
// }

// class _CustomRiskPopupState extends State<CustomRiskPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       // Aqui Controlo la altura del recuadro
//       child: SizedBox(
//           // width: 100,
//           height: MediaQuery.of(context).size.height * 0.4,
//           width: MediaQuery.of(context).size.width * 0.2,
//           child: contentBox(context, stepId: widget.stepId)),
//     );
//   }

//   contentBox(context, {required String stepId}) {
//     JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);
//     // Find the JsaStepsJson object with the matching title
//     JsaStepsJson? matchingStep =
//         jsaProvider.jsa.jsaStepsJson!.firstWhere((step) => step.id == stepId);

// // Get the length of risks if a matching step is found, otherwise set to 0
//     int risksLength = matchingStep.risks.length ?? 0;
//     // Este es pero no reacciona los width
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.2,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black,
//             offset: Offset(0, 10),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: const Color(0xFF335594)),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text(
//               "List of Risk",
//               style: AppTheme.of(context).title3,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                 Text(
//                   widget.title,
//                   style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF335594)),
//                 ),
//                 const Spacer(),
//                 // Aqui está el boton para agregar un Risk
//                 IconButton(
//                   icon: const Icon(
//                     Icons.add,
//                     color: Color(0xFF335594),
//                   ),
//                   onPressed: () async {
//                     controlNameController.text = "";
//                     jsaProvider.editControl = false;
//                     showAddRiskPopup(context, widget.title, widget.stepId);
//                     // Este set state es para que cuando le des otra vez, se vean cada uno.
//                     setState(() {});
//                   },
//                 ),
//               ],
//             ),
//             for (var i = 0; i < risksLength; i++)
//               Container(
//                 color: Colors.blue,
//                 // color: Colors.red,
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     // Menu Icon
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.05,
//                       child: const Icon(
//                         Icons.more_vert_outlined,
//                         color: Color(0xFF335594),
//                         size: 24,
//                       ),
//                     ),
//                     // Text "Steps"
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.07,
//                       child: Text(
//                         matchingStep.risks[i].title.toString(),
//                         style: const TextStyle(
//                           fontSize: 15.0,
//                           color: Color(0xFF335594),
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Quicksand',
//                         ),
//                       ),
//                     ),

//                     // const Spacer(),
//                     // Open/Close   Button
//                     IconButton(
//                       icon: const Icon(
//                         Icons.remove,
//                         color: Color(0xFF335594),
//                       ),
//                       onPressed: () {
//                         //ToDo: hacer que esto funcione correctamente
//                         setState(() {
//                           showRiskDeleteConfirmation(
//                               context,
//                               matchingStep.risks[i].title.toString(),
//                               widget.stepId,
//                               widget.title);
//                         });
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.edit_document,
//                         color: Color(0xFF335594),
//                       ),
//                       onPressed: () {
//                         jsaProvider.editControl = true;

//                         controlNameController.text =
//                             matchingStep.risks[i].title.toString();
//                         jsaProvider.compareRiskTitle =
//                             controlNameController.text;
//                         showAddRiskPopup(context, widget.title, widget.stepId);
//                         // setState(() {
//                         //   showAddRiskPopup(
//                         //       context, widget.title, widget.stepId);
//                         // });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// showRiskDeleteConfirmation(
//     BuildContext context, String riskTitle, String stepId, String title) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return DeleteRiskConfirmationDialog(
//         riskTitle: riskTitle,
//         stepId: stepId,
//         title: title,
//       );
//     },
//   );
// }

// class DeleteRiskConfirmationDialog extends StatefulWidget {
//   final riskTitle, title, stepId;

//   const DeleteRiskConfirmationDialog(
//       {super.key, required this.riskTitle, this.title, this.stepId});

//   @override
//   State<DeleteRiskConfirmationDialog> createState() =>
//       _DeleteRiskConfirmationDialogState();
// }

// class _DeleteRiskConfirmationDialogState
//     extends State<DeleteRiskConfirmationDialog> {
//   @override
//   Widget build(BuildContext context) {
//     JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.white,
//       title: const Text(
//         'Delete Confirmation',
//         style: TextStyle(
//           fontSize: 18.0,
//           color: Color(0xFF335594),
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Quicksand',
//         ),
//       ),
//       content: const Text(
//         'Are you sure you want to delete this item?',
//         style: TextStyle(
//           fontSize: 16.0,
//           color: Colors.black,
//           fontWeight: FontWeight.w400,
//           fontFamily: 'Quicksand',
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//               const Color(0xFF335594),
//             )),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel',
//                 style: TextStyle(
//                   color: Colors.white,
//                 )),
//           ),
//         ),
//         ElevatedButton(
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(
//             const Color(0xFF335594),
//           )),
//           onPressed: () {
//             // Perform delete operation here
//             setState(() {
//               _deleteRiskItem(widget.riskTitle, jsaProvider);
//             });
//             Navigator.of(context).pop();
//             Navigator.of(context).pop();
//             showRiskPopup(
//               context,
//               widget.title,
//               widget.stepId,
//             );
//           },
//           child: const Text('Delete',
//               style: TextStyle(
//                 color: Colors.white,
//               )),
//         ),
//       ],
//     );

//     return AlertDialog(
//       title: Text('Delete Confirmation'),
//       content: Text('Are you sure you want to delete this item?'),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel',
//               style: TextStyle(
//                 color: Colors.white,
//               )),
//         ),
//         TextButton(
//           onPressed: () {
//             // Perform delete operation here
//             setState(() {
//               _deleteRiskItem(widget.riskTitle, jsaProvider);
//             });
//             Navigator.of(context).pop();
//             Navigator.of(context).pop();
//             showRiskPopup(
//               context,
//               widget.title,
//               widget.stepId,
//             );
//           },
//           child: Text('Delete'),
//         ),
//       ],
//     );
//   }

//   _deleteRiskItem(String riskTitle, JsaProvider jsaProvider) {
//     setState(() {
//       jsaProvider.deleteJsaRisk(riskTitle);
//     });
//   }
// }

// // Show Add Risk
// showAddRiskPopup(BuildContext context, String title, String stepId) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CustomAddRiskPopup(
//         title: title,
//         stepId: stepId,
//       );
//     },
//   );
// }

// class CustomAddRiskPopup extends StatefulWidget {
//   const CustomAddRiskPopup(
//       {super.key, required this.title, required this.stepId});
//   final String title;
//   final String stepId;
//   @override
//   _CustomAddRiskPopupState createState() => _CustomAddRiskPopupState();
// }

// class _CustomAddRiskPopupState extends State<CustomAddRiskPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   // Este es agregar el risk
//   contentBox(context) {
//     JsaProvider provider = Provider.of<JsaProvider>(context);

//     return Container(
//       width: MediaQuery.of(context).size.width * 0.2,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black,
//             offset: Offset(0, 10),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Text(
//             provider.editControl == false ? 'Add Risk' : 'Edit Risk',
//             style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF335594)),
//           ),
//           const SizedBox(height: 16.0),
//           CustomTextInput(
//               title: 'Risk Name', controller: controlNameController),
//           const SizedBox(height: 16.0),
//           // CustomTextInput(
//           //     title: 'Step Description', controller: stepDescriptionController),
//           // SizedBox(height: 24.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color(0xFF335594),
//                 )),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel',
//                     style: TextStyle(
//                       color: Colors.white,
//                     )),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//               ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color(0xFF335594),
//                 )),
//                 onPressed: () async {
//                   // Save your data or perform any action here
//                   if (provider.editControl == false) {
//                     provider.addJsaRisks(
//                         controlNameController.text, widget.stepId);
//                   } else {
//                     provider.editJsaRisk(provider.compareRiskTitle.toString(),
//                         widget.stepId.toString(), controlNameController.text);
//                   }
//                   // _saveData();
//                   // setState(() {});

//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Save',
//                     style: TextStyle(
//                       color: Colors.white,
//                     )),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // _saveData() {
//   //   JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

//   //   // Perform save operation with stepNameController.text and stepDescriptionController.text
//   //   if (editControl == false) {
//   //     jsaProvider.addJsaRisks(controlNameController.text, widget.stepId);
//   //   } else {
//   //     //agregar funcionalidad edit risks
//   //     jsaProvider.editJsaRisk(compareRiskTitle.toString(),
//   //         widget.stepId.toString(), controlNameController.text);
//   //   }
//   //   setState(() {});
//   // }
// }
