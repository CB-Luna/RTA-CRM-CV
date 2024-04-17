// ignore_for_file: must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/jsa/jsa_provider.dart';
import '../../risks_hazards_widget.dart';
import '../CustomTextInput.dart';

class AnimatedStepContainer extends StatefulWidget {
  const AnimatedStepContainer({
    super.key,
  });

  @override
  State<AnimatedStepContainer> createState() => _AnimatedStepContainerState();
}

class _AnimatedStepContainerState extends State<AnimatedStepContainer> {
  // @override
  // void initState() {
  //   JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: true);

  //   super.initState();
  //   setState(() {
  //     // context
  //     //     .read<UsuarioController>()
  //     //     .recoverPreviousControlForms(DateTime.now());
  //     // controlFormCheckOut = context
  //     //     .read<UsuarioController>()
  //     //     .getControlFormCheckOutToday(DateTime.now());
  //     // controlFormCheckIn = context
  //     //     .read<UsuarioController>()
  //     //     .getControlFormCheckInToday(DateTime.now());
  //     // context
  //     //     .read<UsuarioController>()
  //     //     .getUser(prefs.getString("userId") ?? "");
  //     // vehicleServicesList = context
  //     //     .read<UsuarioController>()
  //     //     .usuarioCurrent
  //     //     ?.vehicle
  //     //     .target
  //     //     ?.vehicleServices
  //     //     .where((element) => !element.completed)
  //     //     .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: true);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * 0.30,

      // height: MediaQuery.of(context).size.height * 0.21,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF335594)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          // First Row
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Menu Icon
                const Icon(
                  Icons.edit_document,
                  color: Color(0xFF335594),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                // Text "Steps"
                const Expanded(
                  child: Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF335594),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Spacer(),
                // Open/Close Button

                // IconButton(
                //   icon: const Icon(
                //     Icons.add,
                //     color: Color(0xFF335594),
                //   ),
                //   onPressed: () {
                //     stepNameController.text = "";
                //     stepDescriptionController.text = "";
                //     editStep = false;
                //     _showPopup(context);
                //   },
                // ),
              ],
            ),
          ),

          // Second Row (Additional content when the container is open)
          // if (isContainerOpen)
          Container(
            height: MediaQuery.of(context).size.height * 0.145,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jsaProvider.jsa.jsaStepsJson!.length,
              itemBuilder: (context, i) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                    child: const Icon(
                      Icons.more_vert_outlined,
                      color: Color(0xFF335594),
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: Text(
                            jsaProvider.jsa.jsaStepsJson!.isEmpty
                                ? ""
                                : jsaProvider.jsa.jsaStepsJson![i].title,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: Text(
                            jsaProvider.jsa.jsaStepsJson!.isEmpty
                                ? ""
                                : jsaProvider.jsa.jsaStepsJson![i].description,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF335594),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Outfit',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Color(0xFF335594),
                    ),
                    onPressed: () {
                      showDeleteConfirmation(
                          context, jsaProvider.jsa.jsaStepsJson![i].id!);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_document,
                      color: Color(0xFF335594),
                    ),
                    onPressed: () {
                      editStep = true;
                      print(jsaProvider.jsa.jsaStepsJson![i]);
                      id = jsaProvider.jsa.jsaStepsJson![i].id!;
                      stepNameController.text =
                          jsaProvider.jsa.jsaStepsJson![i].title;
                      stepDescriptionController.text =
                          jsaProvider.jsa.jsaStepsJson![i].description;
                      _showPopup(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomPopup();
    },
  );
}

class CustomPopup extends StatefulWidget {
  late ScrollController sController;

  CustomPopup({super.key});

  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  final formKey = GlobalKey<FormState>();

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

  contentBox(context) {
    return SingleChildScrollView(
      controller: ScrollController(
        initialScrollOffset: 0,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        // height: MediaQuery.of(context).size.height * 0.3,
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                editStep == false ? 'Create a Step' : 'Edit Step',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF335594)),
              ),
              const SizedBox(height: 16.0),
              CustomTextInput(
                  title: 'Step Name', controller: stepNameController),
              const SizedBox(height: 16.0),
              CustomTextInput(
                  title: 'Step Description',
                  controller: stepDescriptionController),
              const SizedBox(height: 24.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF335594),
                  )),
                  onPressed: () {
                    // Save your data or perform any action here
                    if (formKey.currentState!.validate()) {
                      _saveData();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all<Color>(
                  //     const Color(0xFF335594),
                  //   )),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: const Text('Cancel',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       )),
                  // ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveData() {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

    // Perform save operation with stepNameController.text and stepDescriptionController.text
    if (editStep == false) {
      jsaProvider.addJsaSteps(
          stepNameController.text, stepDescriptionController.text);
    } else {
      jsaProvider.jsa.jsaStepsJson!.forEach((element) {
        if (element.id == id) {
          element.title = stepNameController.text;
          element.description = stepDescriptionController.text;
        }
      });
      jsaProvider.notifyEdit();
    }
    setState(() {});
  }
}

showDeleteConfirmation(BuildContext context, String stepIdDel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteConfirmationDialog(stepIdDel: stepIdDel);
    },
  );
}

// ignore: must_be_immutable
class DeleteConfirmationDialog extends StatelessWidget {
  String stepIdDel;

  DeleteConfirmationDialog({
    super.key,
    required this.stepIdDel,
  });
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
          fontFamily: 'Outfit',
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this item?',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: 'Outfit',
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
            _deleteItem(jsaProvider, stepIdDel);

            Navigator.of(context).pop();
          },
          child: const Text('Delete',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  _deleteItem(JsaProvider jsaProvider, String stepId) {
    jsaProvider.deleteJsaSteps(stepId);
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../providers/jsa/jsa_provider.dart';
// import '../../risks_hazards_widget.dart';
// import '../CustomTextInput.dart';

// class AnimatedStepContainer extends StatefulWidget {
//   const AnimatedStepContainer({
//     super.key,
//   });

//   @override
//   State<AnimatedStepContainer> createState() => _AnimatedStepContainerState();
// }

// class _AnimatedStepContainerState extends State<AnimatedStepContainer> {
//   @override
//   void initState() {
//     JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: true);

//     super.initState();
//     setState(() {


//       // context
//       //     .read<UsuarioController>()
//       //     .recoverPreviousControlForms(DateTime.now());
//       // controlFormCheckOut = context
//       //     .read<UsuarioController>()
//       //     .getControlFormCheckOutToday(DateTime.now());
//       // controlFormCheckIn = context
//       //     .read<UsuarioController>()
//       //     .getControlFormCheckInToday(DateTime.now());
//       // context
//       //     .read<UsuarioController>()
//       //     .getUser(prefs.getString("userId") ?? "");
//       // vehicleServicesList = context
//       //     .read<UsuarioController>()
//       //     .usuarioCurrent
//       //     ?.vehicle
//       //     .target
//       //     ?.vehicleServices
//       //     .where((element) => !element.completed)
//       //     .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: true);
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: isContainerOpen
//           ? MediaQuery.of(context).size.height * 0.21
//           : MediaQuery.of(context).size.height * 0.095,
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF335594)),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         children: [
//           // First Row
//           Container(
//             height: MediaQuery.of(context).size.height * 0.06,
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Menu Icon
//                 const Icon(
//                   Icons.edit_document,
//                   color: Color(0xFF335594),
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.02),

//                 // Text "Steps"
//                 const Expanded(
//                   child: Text(
//                     'Steps',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: Color(0xFF335594),
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Outfit',
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 // Open/Close Button

//                 IconButton(
//                   icon: const Icon(
//                     Icons.add,
//                     color: Color(0xFF335594),
//                   ),
//                   onPressed: () {
//                     stepNameController.text = "";
//                     stepDescriptionController.text = "";
//                     editStep = false;
//                     _showPopup(context);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     isContainerOpen
//                         ? Icons.keyboard_arrow_up
//                         : Icons.keyboard_arrow_down,
//                     color: const Color(0xFF335594),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isContainerOpen = !isContainerOpen;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),

//           // Second Row (Additional content when the container is open)
//           if (isContainerOpen)
//             Container(
//               height: MediaQuery.of(context).size.height * 0.145,
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: jsaProvider.jsa.jsaStepsJson!.length,
//                 itemBuilder: (context, i) => Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.02,
//                       child: const Icon(
//                         Icons.more_vert_outlined,
//                         color: Color(0xFF335594),
//                         size: 24,
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.26,
//                             child: Text(
//                               jsaProvider.jsa.jsaStepsJson!.isEmpty
//                                   ? ""
//                                   : jsaProvider.jsa.jsaStepsJson![i].title,
//                               style: TextStyle(
//                                 fontSize: 15.0,
//                                 color: Colors.grey[600],
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Outfit',
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.26,
//                             child: Text(
//                               jsaProvider.jsa.jsaStepsJson!.isEmpty
//                                   ? ""
//                                   : jsaProvider
//                                           .jsa.jsaStepsJson![i].description ??
//                                       "",
//                               style: const TextStyle(
//                                 fontSize: 15.0,
//                                 color: Color(0xFF335594),
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Outfit',
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.remove,
//                         color: Color(0xFF335594),
//                       ),
//                       onPressed: () {
//                         showDeleteConfirmation(
//                             context, jsaProvider.jsa.jsaStepsJson![i].id!);
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.edit_document,
//                         color: Color(0xFF335594),
//                       ),
//                       onPressed: () {
//                         editStep = true;
//                         print(jsaProvider.jsa.jsaStepsJson![i]);
//                         id = jsaProvider.jsa.jsaStepsJson![i].id!;
//                         stepNameController.text =
//                             jsaProvider.jsa.jsaStepsJson![i].title;
//                         stepDescriptionController.text =
//                             jsaProvider.jsa.jsaStepsJson![i].description;
//                         _showPopup(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// _showPopup(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CustomPopup();
//     },
//   );
// }

// class CustomPopup extends StatefulWidget {
//   late ScrollController sController;

//   @override
//   _CustomPopupState createState() => _CustomPopupState();
// }

// class _CustomPopupState extends State<CustomPopup> {
//   final formKey = GlobalKey<FormState>();

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

//   contentBox(context) {
//     return SingleChildScrollView(
//       controller: ScrollController(
//         initialScrollOffset: 0,
//       ),
//       child: Container(
//         // height: MediaQuery.of(context).size.height * 0.6,
//         height: MediaQuery.of(context).size.height * 0.3,
//         width: MediaQuery.of(context).size.width * 0.2,
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black,
//               offset: Offset(0, 10),
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 editStep == false ? 'Create a Step' : 'Edit Step',
//                 style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF335594)),
//               ),
//               const SizedBox(height: 16.0),
//               CustomTextInput(
//                   title: 'Step Name', controller: stepNameController),
//               const SizedBox(height: 16.0),
//               CustomTextInput(
//                   title: 'Step Description',
//                   controller: stepDescriptionController),
//               const SizedBox(height: 24.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color(0xFF335594),
//                     )),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('Cancel',
//                         style: TextStyle(
//                           color: Colors.white,
//                         )),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                   ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color(0xFF335594),
//                     )),
//                     onPressed: () {
//                       // Save your data or perform any action here
//                       if (formKey.currentState!.validate()) {
//                         _saveData();
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: const Text('Save',
//                         style: TextStyle(
//                           color: Colors.white,
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _saveData() {
//     JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

//     // Perform save operation with stepNameController.text and stepDescriptionController.text
//     if (editStep == false) {
//       jsaProvider.addJsaSteps(
//           stepNameController.text, stepDescriptionController.text);
//     } else {
//       jsaProvider.jsa.jsaStepsJson!.forEach((element) {
//         if (element.id == id) {
//           element.title = stepNameController.text;
//           element.description = stepDescriptionController.text;
//         }
//       });
//       jsaProvider.notifyEdit();
//     }
//     setState(() {});
//   }
// }

// showDeleteConfirmation(BuildContext context, String stepIdDel) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return DeleteConfirmationDialog(stepIdDel: stepIdDel);
//     },
//   );
// }

// // ignore: must_be_immutable
// class DeleteConfirmationDialog extends StatelessWidget {
//   String stepIdDel;

//   DeleteConfirmationDialog({
//     super.key,
//     required this.stepIdDel,
//   });
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
//           fontFamily: 'Outfit',
//         ),
//       ),
//       content: const Text(
//         'Are you sure you want to delete this item?',
//         style: TextStyle(
//           fontSize: 16.0,
//           color: Colors.black,
//           fontWeight: FontWeight.w400,
//           fontFamily: 'Outfit',
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
//             _deleteItem(jsaProvider, stepIdDel);

//             Navigator.of(context).pop();
//           },
//           child: const Text('Delete',
//               style: TextStyle(
//                 color: Colors.white,
//               )),
//         ),
//       ],
//     );
//   }

//   _deleteItem(JsaProvider jsaProvider, String stepId) {
//     jsaProvider.deleteJsaSteps(stepId);
//   }
// }
