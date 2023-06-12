import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/detail_form.dart';

import '../../../../public/colors.dart';

class AnswerForm extends StatelessWidget {
  const AnswerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          gradient: blueRadial,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailControlForm(title:"Measures",icon: Icons.speed_outlined,state: true,index:1),
          DetailControlForm(title:"Lights",icon: Icons.lightbulb_outline,state: false,index:2),
          DetailControlForm(title:"C. Bodywork",icon: Icons.no_crash_outlined,state: true,index:3),
          DetailControlForm(title:"Fluid Check",icon: Icons.invert_colors_outlined,state: false,index:4),
          DetailControlForm(title:"B. Inspection",icon: Icons.search_outlined,state: true,index:5),
          DetailControlForm(title:"Security",icon: Icons.health_and_safety_outlined,state: false,index:6),
          DetailControlForm(title:"Extra",icon: Icons.more_outlined,state: true,index:7),
          DetailControlForm(title:"Equipment",icon: Icons.home_repair_service_outlined,state: false,index:8),
        ],
      ),
    );
  }
}
