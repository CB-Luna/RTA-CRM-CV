import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/accounts/tabs/quotes_tab.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/quotes_provider.dart';

import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_tab_filter/custom_tab_filter_option.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
/*   @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final QuotesProvider provider = Provider.of<QuotesProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  } */

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(4);

    QuotesProvider provider = Provider.of<QuotesProvider>(context);

    double filterWidth = 360;

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
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
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
                                  child: sideM.aRAccounts != null ? Rive(artboard: sideM.aRTickets!) : const CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Orders', style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (currentUser!.isSales)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomScrollBar(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[2],
                                          text: 'Sen. Exec. Validate',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[3],
                                          text: 'Finance Validate',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(3),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[4],
                                          text: 'Network Validate',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(4),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[7],
                                          text: 'Approved',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[8],
                                          text: 'Order Created',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(8),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[9],
                                          text: 'Network Cross-Connected',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(9),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[10],
                                          text: 'Network Issues',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[11],
                                          text: 'Ticket Closed',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(11),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[1],
                                          text: 'Sales Form',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(1),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[12],
                                          text: 'Canceled',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(12),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[6],
                                          text: 'Closed',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(6),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[0],
                                          text: 'All',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (currentUser!.isOpperations)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomScrollBar(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[4],
                                          text: 'Network Validate',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(4),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[7],
                                          text: 'Approved',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(7),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[9],
                                          text: 'Network Cross-Connected',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(9),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[10],
                                          text: 'Network Issues',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[11],
                                          text: 'Ticket Closed',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(11),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: CustomTabFilterOption(
                                          width: filterWidth,
                                          isOn: provider.indexSelected[0],
                                          text: 'All',
                                          border: greenGradient,
                                          gradient: greenRadial,
                                          onTap: () => provider.setIndex(0),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: QuotesTab(),
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
