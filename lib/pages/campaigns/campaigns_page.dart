import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/pages/accounts/tabs/campaigns_tab.dart';

import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class CampaignsPage extends StatefulWidget {
  const CampaignsPage({super.key});

  @override
  State<CampaignsPage> createState() => _CampaignsPageState();
}

class _CampaignsPageState extends State<CampaignsPage> {
  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(5);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: sideM.aRAccounts != null ? Rive(artboard: sideM.aRInventories!) : const CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Campaigns', style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getHeight(65, context)),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: CampaignsTab(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
