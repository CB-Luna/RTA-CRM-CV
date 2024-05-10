import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import 'info_widgets.dart';

class AddMoreInfo extends StatefulWidget {
  const AddMoreInfo({super.key});

  @override
  State<AddMoreInfo> createState() => _AddMoreInfoState();
}

class _AddMoreInfoState extends State<AddMoreInfo> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: "Add More Info",
        height: height * 320,
        width: width * 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                provider.infowidgets = 1;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const InfoWidgets();
                      });
                    });
              },
              child: Container(
                height: height * 50,
                // width: width * 120,
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppTheme.of(context).cryPrimary,
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                provider.infowidgets = 2;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const InfoWidgets();
                      });
                    });
              },
              child: Container(
                height: height * 50,
                // width: width * 120,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: AppTheme.of(context).cryPrimary,
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add URL",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.link_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                provider.infowidgets = 3;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const InfoWidgets();
                      });
                    });
              },
              child: Container(
                height: height * 50,
                // width: width * 120,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: AppTheme.of(context).cryPrimary,
                    borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add File",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.upload_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
