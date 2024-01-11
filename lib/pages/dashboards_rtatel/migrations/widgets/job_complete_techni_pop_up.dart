import 'package:flutter/material.dart';

class JobCompleteTechniPopUp extends StatefulWidget {
  const JobCompleteTechniPopUp({super.key});

  @override
  State<JobCompleteTechniPopUp> createState() => _JobCompleteTechniPopUpState();
}

class _JobCompleteTechniPopUpState extends State<JobCompleteTechniPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.75,
        color: Colors.white,
      ),
    );
  }
}
