import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../providers/jsa/jsa_safety_briefing_provider.dart';

class BriefingForm extends StatefulWidget {
  const BriefingForm({super.key});

  @override
  State<BriefingForm> createState() => _BriefingFormState();
}

class _BriefingFormState extends State<BriefingForm> {
  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return Column(
      children: [
        CustomtaskTextInput(
          task: "Issue",
          controller: provider.issueController,
        ),
        CustomtaskTextInput(
          task: "Background",
          controller: provider.backgroundController,
        ),
        CustomtaskTextInput(
          task: "Analysis",
          controller: provider.analisisController,
        ),
        CustomtaskTextInput(
          task: "Recomendations",
          controller: provider.recomendationsController,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.04,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppTheme.of(context).cryPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: const Text(
              "Add More Info +",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}
