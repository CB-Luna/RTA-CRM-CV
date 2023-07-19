import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/detail_form.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';

class AnswerFormReceived extends StatelessWidget {
  const AnswerFormReceived({super.key});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: blueRadial,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailControlForm(title: "Fluid Check", icon: Icons.invert_colors_outlined, state: provider.fluidCheckInspectR, index: 4, provider: provider, list: provider.fluidCheckR),
          DetailControlForm(title: "Lights", icon: Icons.lightbulb_outline, state: provider.ligthsInspectR, index: 2, provider: provider, list: provider.lightsR),
          DetailControlForm(title: "C. Bodywork", icon: Icons.no_crash_outlined, state: provider.carBodyInspectR, index: 3, provider: provider, list: provider.carBodyWorkR),
          DetailControlForm(title: "Security", icon: Icons.health_and_safety_outlined, state: provider.securityInspectR, index: 6, provider: provider, list: provider.securityR),
          DetailControlForm(title: "Extra", icon: Icons.more_outlined, state: provider.extraInspectR, index: 7, provider: provider, list: provider.extraR),
          DetailControlForm(title: "Equipment", icon: Icons.home_repair_service_outlined, state: provider.equipmentInspectR, index: 8, provider: provider, list: provider.equipmentR),
          DetailControlForm(title: "B. Inspection", icon: Icons.search_outlined, state: provider.bucketInspectR, index: 5, provider: provider, list: provider.bucketInspectionR),
          DetailControlForm(title: "Measures", icon: Icons.speed_outlined, state: provider.measureInspectR, index: 1, provider: provider, list: provider.measureR),
           
        ],
      ),
    );
  }
}
