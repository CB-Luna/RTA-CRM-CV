import 'package:flutter/material.dart';

import '../../../public/colors.dart';

class AnswerForm extends StatelessWidget {
  const AnswerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 800,
      height: 100,
      decoration: BoxDecoration(
          gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
          
    );
  }
}