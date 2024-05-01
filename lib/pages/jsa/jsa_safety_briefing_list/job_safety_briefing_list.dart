import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../theme/theme.dart';
import 'widgets/custom_card_safety.dart';

class JobSafetyBriefingList extends StatefulWidget {
  const JobSafetyBriefingList({super.key});

  @override
  State<JobSafetyBriefingList> createState() => _JobSafetyBriefingListState();
}

class _JobSafetyBriefingListState extends State<JobSafetyBriefingList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      Icons.description_outlined,
                                      color: AppTheme.of(context).primaryColor,
                                      size: 35,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Safety Briefing List',
                                    style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CustomCardSafetyList()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
