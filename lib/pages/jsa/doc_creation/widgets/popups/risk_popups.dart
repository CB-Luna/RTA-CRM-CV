import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: contentBox(context, stepId: widget.stepId),
    );
  }

  contentBox(context, {required String stepId}) {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);
    // Find the JsaStepsJson object with the matching title
    JsaStepsJson? matchingStep =
        jsaProvider.jsa.jsaStepsJson!.firstWhere((step) => step.id == stepId);

// Get the length of risks if a matching step is found, otherwise set to 0
    int risksLength = matchingStep.risks.length ?? 0;

    return Container(
      padding: EdgeInsets.all(16.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF335594)),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: const Color(0xFF335594),
                  ),
                  onPressed: () {
                    controlNameController.text = "";
                    editControl = false;

                    showAddRiskPopup(context, widget.title, widget.stepId);
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

                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: const Icon(
                        Icons.more_vert_outlined,
                        color: Color(0xFF335594),
                        size: 24,
                      ),
                    ),

                    // Text "Steps"
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        matchingStep.risks[i].title.toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF335594),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),

                    Spacer(),
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
                        editControl = true;

                        controlNameController.text =                         matchingStep.risks[i].title.toString();
                        compareRiskTitle = controlNameController.text;

                        showAddRiskPopup(context, widget.title, widget.stepId);
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
      title:  const Text(
              'Delete Confirmation',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFF335594),
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
      content:  const Text(
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
          child:     ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF335594),
                )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',
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
            showRiskPopup(
              context,
              widget.title,
              widget.stepId,
            );
          },
                
                child: Text('Delete',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
       
      ],
    );

    return AlertDialog(
      title: Text('Delete Confirmation'),
      content: Text('Are you sure you want to delete this item?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
     child: Text('Cancel',
              style: TextStyle(
                color:  Colors.white,
              )),
        ),
        TextButton(
          onPressed: () {
            // Perform delete operation here
            setState(() {
              _deleteRiskItem(widget.riskTitle, jsaProvider);
            });
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            showRiskPopup(
              context,
              widget.title,
              widget.stepId,
            );
          },
          child: Text('Delete'),
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

  contentBox(context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
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
            editControl == false ? 'Add Risk' : 'Edit Risk',
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF335594)),
          ),
          SizedBox(height: 16.0),
          CustomTextInput(
              title: 'Risk Name', controller: controlNameController),
          SizedBox(height: 16.0),
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
                color:  Colors.white,
              )),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF335594),
                )),
                onPressed: () {
                  // Save your data or perform any action here

                  _saveData();
                  setState(() {});
                  Navigator.of(context).pop();
                },
         child: Text('Save',
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

  _saveData() {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

    // Perform save operation with stepNameController.text and stepDescriptionController.text
    if (editControl == false) {
      jsaProvider.addJsaRisks(controlNameController.text, widget.stepId);
    } else {
      //agregar funcionalidad edit risks
      jsaProvider.editJsaRisk(compareRiskTitle.toString(),
          widget.stepId.toString(), controlNameController.text);
    }
    setState(() {});
  }
}

String? compareRiskTitle;
