import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/popups/image_popup.dart';

import '../../../../../providers/jsa/jsa_provider.dart';
import '../../../../../theme/theme.dart';

class ControlMatrixPopup extends StatefulWidget {
  final Function(String, String) onRiskSelected;

  const ControlMatrixPopup({super.key, required this.onRiskSelected});

  @override
  _ControlMatrixPopupState createState() => _ControlMatrixPopupState();
}

class _ControlMatrixPopupState extends State<ControlMatrixPopup> {
  List<String> likelihoodLevels = ['Low', 'Medium', 'High'];
  List<String> consequenceLevels = ['Low', 'Medium', 'High'];

  String selectedLikelihood = 'Low';
  String selectedConsequence = 'Low';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: Container(
        height: MediaQuery.of(context).size.height *
            0.4, // Set the height to half of the screen height
        color: Colors.white, // Set the background color to white
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Risk Matrix Assesment',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF335594),
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Likelihood:',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Outfit'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLikelihood = "1";
                    });
                  },
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(2, 2), // Shadow position
                          ),
                        ],
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                        color: selectedLikelihood == "1"
                            ? Colors.green
                            : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                              color: selectedLikelihood == "1"
                                  ? Colors.white
                                  : Colors.green,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Spacer between rectangles
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLikelihood = "2";
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                      border: Border.all(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color: selectedLikelihood == "2"
                          ? Colors.yellow
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                            color: selectedLikelihood == "2"
                                ? Colors.white
                                : Colors.yellow,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Spacer between rectangles
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLikelihood = "3";
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          selectedLikelihood == "3" ? Colors.red : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                            color: selectedLikelihood == "3"
                                ? Colors.white
                                : Colors.red,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Select Consequence:',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Outfit'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedConsequence = "1";
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color: selectedConsequence == "1"
                          ? Colors.green
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                            color: selectedConsequence == "1"
                                ? Colors.white
                                : Colors.green,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Spacer between rectangles
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedConsequence = "2";
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1), // Shadow position
                        ),
                      ],
                      border: Border.all(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color: selectedConsequence == "2"
                          ? Colors.yellow
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                            color: selectedConsequence == "2"
                                ? Colors.white
                                : Colors.yellow,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Spacer between rectangles
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedConsequence = "3";
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                      color: selectedConsequence == "3"
                          ? Colors.red
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                            color: selectedConsequence == "3"
                                ? Colors.white
                                : Colors.red,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onRiskSelected(selectedLikelihood, selectedConsequence);
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ImagePopup(
                        imagePath:
                            'assets/images/3x3-risk-assessment-matrix.png', // Change the path accordingly
                      );
                    },
                  );
                  // setState(() {});
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
                      Text("Open Image", style: AppTheme.of(context).subtitle2),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                  widget.onRiskSelected(
                      selectedLikelihood, selectedConsequence);
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
                      Text("OK", style: AppTheme.of(context).subtitle2),
                    ],
                  ),
                ),
              ),
            ],

            // Row(
            //   children: [
            //     TextButton(
            //         onPressed: () {
            //           // Show the image popup dialog on button press
            //           showDialog(
            //             context: context,
            //             builder: (BuildContext context) {
            //               return ImagePopup(
            //                 imagePath:
            //                     'assets/images/3x3-risk-assessment-matrix.png', // Change the path accordingly
            //               );
            //             },
            //           );
            //         },
            //         child: const Text(
            //           'Open Image',
            //           style: TextStyle(
            //             color: Color(0xFF335594),
            //             fontWeight: FontWeight.bold,
            //           ),
            //         )),
            //     const SizedBox(
            //       width: 60,
            //     ),
            //     const Text(
            //       'OK',
            //       style: TextStyle(
            //         color: Color(0xFF335594),
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
          ),
        ),
      ],
    );
  }
}

void showControlMatrixPopup(
    BuildContext context, String stepId, JsaProvider jsaProvider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ControlMatrixPopup(
        onRiskSelected: (selectedLikelihood, selectedConsequence) {
          // Handle the selected values, e.g., update the state or perform actions
          // print('Selected Likelihood: $selectedLikelihood');
          // print('Selected Consequence: $selectedConsequence');
          switch (selectedLikelihood) {
            case 'Low':
              selectedLikelihood = '1.0';
              break;
            case 'Medium':
              selectedLikelihood = '2.0';
              break;
            case 'High':
              selectedLikelihood = '3.0';
              break;
          }
          switch (selectedConsequence) {
            case 'Low':
              selectedConsequence = '1.0';
              break;
            case 'Medium':
              selectedConsequence = '2.0';
              break;
            case 'High':
              selectedConsequence = '3.0';
              break;
          }
          // print(selectedConsequence);
          // print(selectedLikelihood);
          String riskLevel = (double.parse(selectedLikelihood) *
                  double.parse(selectedConsequence))
              .toString();
          print("riskLevel $riskLevel");
          jsaProvider.setControlLevel(riskLevel, stepId);
        },
      );
    },
  );
}
