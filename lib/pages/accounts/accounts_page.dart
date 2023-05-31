import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/pages/accounts/widgets/billing_tab.dart';
import 'package:rta_crm_cv/pages/accounts/widgets/campaigns_tab.dart';
import 'package:rta_crm_cv/pages/accounts/widgets/leads_tab.dart';
import 'package:rta_crm_cv/pages/accounts/widgets/opportunities_tab.dart';
import 'package:rta_crm_cv/pages/accounts/widgets/quotes_tab.dart';

import 'package:rta_crm_cv/providers/accounts/accounts_provider.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_tab_bar/custom_tab_bar_option.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final AccountsProvider provider = Provider.of<AccountsProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    AccountsProvider provider = Provider.of<AccountsProvider>(context);
    /* AccountsProvider providerOpp = Provider.of<AccountsProvider>(context);
    AccountsProvider providerLea = Provider.of<AccountsProvider>(context);
    AccountsProvider providerCam = Provider.of<AccountsProvider>(context);
    AccountsProvider providerBil = Provider.of<AccountsProvider>(context); */

    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(1);

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
                        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: sideM.aRAccounts != null ? Rive(artboard: sideM.aRAccounts!) : const CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Accounts', style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTabBarOption(
                                  isOn: provider.tabBar[0],
                                  width: MediaQuery.of(context).size.width / 6,
                                  text: 'Quotes',
                                  border: greenGradient,
                                  gradient: greenRadial,
                                  onTap: () => provider.setIndex(0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTabBarOption(
                                  isOn: provider.tabBar[1],
                                  width: MediaQuery.of(context).size.width / 6,
                                  text: 'Opportunities',
                                  border: greenGradient,
                                  gradient: greenRadial,
                                  onTap: () => provider.setIndex(1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTabBarOption(
                                  isOn: provider.tabBar[2],
                                  width: MediaQuery.of(context).size.width / 6,
                                  text: 'Leads',
                                  border: greenGradient,
                                  gradient: greenRadial,
                                  onTap: () => provider.setIndex(2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTabBarOption(
                                  isOn: provider.tabBar[3],
                                  width: MediaQuery.of(context).size.width / 6,
                                  text: 'Campaigns',
                                  border: greenGradient,
                                  gradient: greenRadial,
                                  onTap: () => provider.setIndex(3),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTabBarOption(
                                  isOn: provider.tabBar[4],
                                  width: MediaQuery.of(context).size.width / 6,
                                  text: 'Billing',
                                  border: greenGradient,
                                  gradient: greenRadial,
                                  onTap: () => provider.setIndex(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (provider.tabBar[0])
                        const QuotesTab()
                      else if (provider.tabBar[1])
                        const OpportunitiesTab()
                      else if (provider.tabBar[2])
                        const LeadsTab()
                      else if (provider.tabBar[3])
                        const CampaignsTab()
                      else
                        const BillingTab()
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
