import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/detail_form.dart';

import '../../../../public/colors.dart';

class AnswerForm extends StatelessWidget {
  const AnswerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child:
       Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
           DetailControlForm(),
         ],
       ),
    );
  }
}
