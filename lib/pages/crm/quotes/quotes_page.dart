import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/accounts/tabs/quotes_tab.dart';
//import 'package:rta_crm_cv/pages/ctrlv/monitory_page/monitory_page_desktop.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/quotes_provider.dart';

import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
//import 'package:rta_crm_cv/widgets/custom_tab_filter/custom_tab_filter_option.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final QuotesProvider provider = Provider.of<QuotesProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(4);

    QuotesProvider provider = Provider.of<QuotesProvider>(context);

    //double filterWidth = 360;
    //provider.tabController = TabController(length: 9, vsync: this);
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
                                  child: sideM.aRAccounts != null
                                      ? Rive(artboard: sideM.aRTickets!)
                                      : const CircularProgressIndicator(),
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
                        DefaultTabController(
                          length: 9,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: whiteGradient,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  border: Border.all(
                                      color: AppTheme.of(context).primaryColor, width: 2),
                                ),
                                child: TabBar(
                                  onTap: (value) {
                                    switch (value) {
                                      case 0:
                                        provider.setIndex(0);
                                        break;
                                      case 1:
                                        provider.setIndex(1);
                                        break;
                                      case 2:
                                        provider.setIndex(13); //2-3-4
                                        break;
                                      case 3:
                                        provider.setIndex(14); //12-5
                                        break;
                                      case 4:
                                        provider.setIndex(6);
                                        break;
                                      case 5:
                                        provider.setIndex(7);
                                        break;
                                      case 6:
                                        provider.setIndex(8);
                                        break;
                                      case 7:
                                        provider.setIndex(15); //9-10
                                        break;
                                      case 8:
                                        provider.setIndex(11);
                                        break;
                                      default:
                                    }
                                  },
                                  indicator: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    color: provider.indexSelected[1]
                                        ? Colors.greenAccent
                                        : provider.indexSelected[0]
                                            ? AppTheme.of(context).primaryColor
                                            : provider.indexSelected[13] ||
                                                    provider.indexSelected[2] ||
                                                    provider.indexSelected[3] ||
                                                    provider.indexSelected[4]
                                                ? Colors.orangeAccent
                                                : provider.indexSelected[6]
                                                    ? Colors.redAccent
                                                    : provider.indexSelected[7]
                                                        ? Colors.green
                                                        : provider.indexSelected[8]
                                                            ? Colors.blueAccent
                                                            : provider.indexSelected[11]
                                                                ? Colors.deepPurpleAccent
                                                                : provider.indexSelected[14] ||
                                                                        provider.indexSelected[5] ||
                                                                        provider.indexSelected[12]
                                                                    ? Colors.red
                                                                    : Colors.black,
                                  ),
                                  splashBorderRadius: BorderRadius.circular(40),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'UniNeue',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  unselectedLabelColor: AppTheme.of(context).primaryColor,
                                  unselectedLabelStyle: const TextStyle(
                                    fontFamily: 'UniNeue',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                  tabs: const [
                                    Tab(text: 'All'),
                                    Tab(text: 'Form'),
                                    Tab(text: 'Validate'),
                                    Tab(text: 'Canceled'),
                                    Tab(text: 'Closed'),
                                    Tab(text: 'Approved'),
                                    Tab(text: 'Order Created'),
                                    Tab(text: 'Network'),
                                    Tab(text: 'Tickets'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: getHeight(0, context),
                                  child: const TabBarView(
                                    children: [
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (currentUser!.isOpperations)
                        DefaultTabController(
                          length: 5,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: whiteGradient,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  border: Border.all(
                                      color: AppTheme.of(context).primaryColor, width: 2),
                                ),
                                child: TabBar(
                                  onTap: (value) {
                                    switch (value) {
                                      case 0:
                                        provider.setIndex(0);
                                        break;
                                      case 1:
                                        provider.setIndex(4);
                                        break;
                                      case 2:
                                        provider.setIndex(7);
                                        break;
                                      case 3:
                                        provider.setIndex(15); //9-10
                                        break;
                                      case 4:
                                        provider.setIndex(11);
                                        break;
                                      default:
                                    }
                                  },
                                  indicator: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    color: provider.indexSelected[0]
                                        ? AppTheme.of(context).primaryColor
                                        : provider.indexSelected[4]
                                            ? Colors.orangeAccent
                                            : provider.indexSelected[7]
                                                ? Colors.green
                                                : provider.indexSelected[11]
                                                    ? Colors.deepPurpleAccent
                                                    : Colors.black,
                                  ),
                                  splashBorderRadius: BorderRadius.circular(40),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'UniNeue',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  unselectedLabelColor: AppTheme.of(context).primaryColor,
                                  unselectedLabelStyle: const TextStyle(
                                    fontFamily: 'UniNeue',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                  tabs: const [
                                    Tab(text: 'All'),
                                    Tab(text: 'Validate'),
                                    Tab(text: 'Approved'),
                                    Tab(text: 'Network'),
                                    Tab(text: 'Tickets'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: getHeight(0, context),
                                  child: const TabBarView(
                                    children: [
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                      SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const QuotesTab(),
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
