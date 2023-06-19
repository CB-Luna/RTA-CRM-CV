import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/detail_form.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';

class AnswerFormDelivered extends StatelessWidget {

  const AnswerFormDelivered({super.key});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
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
          DetailControlForm(title:"Measures",
          icon: Icons.speed_outlined,
          state: provider.measureInspectD,
          index:1,
          provider: provider,
          list: provider.measureD),
          DetailControlForm(title:"Lights",
          icon: Icons.lightbulb_outline,
          state: provider.ligthsInspectD,
          index:2,
          provider: provider,
          list: provider.lightsD),
          DetailControlForm(title:"C. Bodywork",
          icon: Icons.no_crash_outlined,
          state: provider.carBodyInspectD,
          index:3,
          provider: provider,
          list: provider.carBodyWorkD),
          DetailControlForm(title:"Fluid Check",icon: Icons.invert_colors_outlined,state: provider.fluidCheckInspectD,index:4,provider: provider,list: provider.fluidCheckD,),
          DetailControlForm(title:"B. Inspection",icon: Icons.search_outlined,state: provider.bucketInspectD,index:5,provider: provider,list: provider.bucketInspectionD,),
          DetailControlForm(title:"Security",icon: Icons.health_and_safety_outlined,state: provider.securityInspectD,index:6,provider: provider,list: provider.securityD,),
          DetailControlForm(title:"Extra",icon: Icons.more_outlined,state: provider.extraInspectD,index:7,provider: provider,list: provider.extraD,),
          DetailControlForm(title:"Equipment",icon: Icons.home_repair_service_outlined,state: provider.equipmentInspectD,index:8,provider: provider,list: provider.equipmentD,),
        ],
      ),
    );
  }
}