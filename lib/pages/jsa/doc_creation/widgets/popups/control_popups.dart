// ignore_for_file: library_private_types_in_public_api, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/jsa/jsa_general_information.dart';
import '../../../../../providers/jsa/jsa_provider.dart';
import '../../../../../theme/theme.dart';
import '../../risks_hazards_widget.dart';
import '../CustomTextInput.dart';

showControlPopup(BuildContext context, String title, String stepId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomControlPopup(
        title: title,
        stepId: stepId,
      );
    },
  );
}

class CustomControlPopup extends StatefulWidget {
  final String title;
  final String stepId;
  const CustomControlPopup(
      {super.key, required this.title, required this.stepId});
  @override
  // ignore: library_private_types_in_public_api
  _CustomControlPopupState createState() => _CustomControlPopupState();
}

class _CustomControlPopupState extends State<CustomControlPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.2,
        child: contentBox(context, stepId: widget.stepId),
      ),
    );
  }

  contentBox(context, {required String stepId}) {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context);
    // Find the JsaStepsJson object with the matching title
    JsaStepsJson? matchingStep =
        jsaProvider.jsa.jsaStepsJson!.firstWhere((step) => step.id == stepId);

// Get the length of risks if a matching step is found, otherwise set to 0
    // int controlLength = matchingStep.controls.length ?? 0;
    int controlLength = matchingStep.controls.length;

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
              "List of Controls",
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
                      color: const Color(0xFF335594)),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFF335594),
                  ),
                  onPressed: () {
                    controlNameController.text = "";
                    editControl = false;
                    showAddControlPopup(context, widget.title, widget.stepId);
                  },
                ),
              ],
            ),
            for (var i = 0; i < controlLength; i++)
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: Text(
                        matchingStep.controls[i].title.toString(),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF335594),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),
                    // Open/Close   Button
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Color(0xFF335594),
                      ),
                      onPressed: () {
                        //ToDo: hacer que esto funcione correctamente
                        setState(() {
                          //erasing works and the ui updates but second revision should be done
                          showControlDeleteConfirmation(
                              context,
                              matchingStep.controls[i].title.toString(),
                              widget.title,
                              widget.stepId);
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

                        controlNameController.text =
                            matchingStep.controls[i].title.toString();
                        compareControlTitle = controlNameController.text;

                        showAddControlPopup(
                            context, widget.title, widget.stepId);
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

showControlDeleteConfirmation(
    BuildContext context, String controlTitle, String title, String stepId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteControlConfirmationDialog(
        controlTitle: controlTitle,
        title: title,
        stepId: stepId,
      );
    },
  );
}

class DeleteControlConfirmationDialog extends StatefulWidget {
  final controlTitle, title, stepId;

  const DeleteControlConfirmationDialog(
      {super.key, required this.controlTitle, this.title, this.stepId});

  @override
  State<DeleteControlConfirmationDialog> createState() =>
      _DeleteControlConfirmationDialogState();
}

class _DeleteControlConfirmationDialogState
    extends State<DeleteControlConfirmationDialog> {
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
        ElevatedButton(
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
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFF335594),
          )),
          onPressed: () {
            deleteControlItem(widget.controlTitle, jsaProvider);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            showControlPopup(
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
  }

  deleteControlItem(String controlTitle, JsaProvider jsaProvider) {
    jsaProvider.deleteJsaControl(controlTitle);
  }
}

showAddControlPopup(BuildContext context, String title, String stepId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAddControlPopup(
        title: title,
        stepId: stepId,
      );
    },
  );
}

class CustomAddControlPopup extends StatefulWidget {
  const CustomAddControlPopup(
      {super.key, required this.title, required this.stepId});
  final String title;
  final String stepId;
  @override
  _CustomAddControlPopupState createState() => _CustomAddControlPopupState();
}

class _CustomAddControlPopupState extends State<CustomAddControlPopup> {
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
            editControl == false ? 'Add Control' : 'Edit Control',
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF335594)),
          ),
          const SizedBox(height: 16.0),
          CustomTextInput(
              title: 'Control Name', controller: controlNameController),
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
                onPressed: () {
                  // Save your data or perform any action here

                  if (editControl == false) {
                    provider.addJsaControl(
                        controlNameController.text, widget.stepId);
                  } else {
                    //agregar funcionalidad edit risks
                    provider.editJsaControl(compareControlTitle.toString(),
                        widget.stepId.toString(), controlNameController.text);
                  }

                  // _saveData();
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

  _saveData() {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);

    // Perform save operation with stepNameController.text and stepDescriptionController.text
    if (editControl == false) {
      jsaProvider.addJsaControl(controlNameController.text, widget.stepId);
    } else {
      //agregar funcionalidad edit risks
      jsaProvider.editJsaControl(compareControlTitle.toString(),
          widget.stepId.toString(), controlNameController.text);
    }
    setState(() {});
  }
}

String? compareControlTitle;
