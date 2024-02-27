import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../../providers/dashboard_rta/monitoring_dashboard_provider.dart';

class TopBarButtons extends StatefulWidget {
  const TopBarButtons({super.key});

  @override
  State<TopBarButtons> createState() => _TopBarButtonsState();
}

class _TopBarButtonsState extends State<TopBarButtons> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        provider.viewPopup == 1
            ? Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.1,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Up to \n 13 Feb 2024",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )
            : SizedBox.shrink(),
        InkWell(
          onTap: () {
            provider.updateViewPopup(1);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Text("Summary",
                style: TextStyle(
                    fontFamily: 'Gotham-Regular',
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        InkWell(
          onTap: () {
            provider.updateViewPopup(2);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              border: Border.all(color: Colors.blue[600]!, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_double_arrow_right_outlined,
                  color: Colors.blue[600],
                ),
                Text("OpCo BreakDown",
                    style: TextStyle(
                        fontFamily: 'Gotham-Regular',
                        color: Colors.blue[600],
                        decoration: TextDecoration.underline,
                        fontSize: 25,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Events",
                  style: AppTheme.of(context).bodyText1,
                ),
                Text(
                  "653",
                  style: AppTheme.of(context).title2,
                ),
              ],
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.17,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Average #Incidents/day",
                style: AppTheme.of(context).bodyText1,
              ),
              Text(
                "1,43",
                style: AppTheme.of(context).title2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
