import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';

import '../../../../providers/jsa/jsa_document_list_provider.dart';
import '../../../../widgets/custom_card.dart';
import 'Briefing_form.dart';
import 'create_info_form.dart';

class CustomCardJSB extends StatefulWidget {
  const CustomCardJSB({super.key});

  @override
  State<CustomCardJSB> createState() => _CustomCardJSBState();
}

class _CustomCardJSBState extends State<CustomCardJSB> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final JSADocumentListProvider provider =
          Provider.of<JSADocumentListProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CustomCard(
                title: "Create Info",
                height: MediaQuery.of(context).size.height * 0.43,
                width: MediaQuery.of(context).size.width * 0.20,
                child: const CreateInfoForm()),
            const SizedBox(
              height: 30,
            ),
            CustomCard(
              title: "Briefing Details",
              height: MediaQuery.of(context).size.height * 0.43,
              width: MediaQuery.of(context).size.width * 0.20,
              child: const BriefingForm(),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCard(
              title: "Briefing Preview",
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.600,
              child: Column(
                children: [
                  Text(provider.titleController.text),
                  Text(provider.dateController.text),
                  Text(provider.UserController.text),
                  Text(provider.issueController.text),
                  Text(provider.backgroundController.text),
                  Text(provider.analisisController.text),
                  Text(provider.recomendationsController.text),
                ],
              )),
        )
      ],
    );
  }
}
