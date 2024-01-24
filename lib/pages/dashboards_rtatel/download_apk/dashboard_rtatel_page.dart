import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/download_apk/dashboard_rtatel_page_desktop.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/download_apk/dashboard_rtatel_page_mobile.dart';

import '../../../helpers/constants.dart';
import '../../../providers/users_provider.dart';

class DashboardsRtatelPage extends StatefulWidget {
  final String title;
  final String source;
  final bool? searchVisibility;
  bool? isjobcompletetech = false;
  DashboardsRtatelPage(
      {Key? key,
      required this.title,
      required this.source,
      this.searchVisibility,
      this.isjobcompletetech})
      : super(key: key);

  @override
  State<DashboardsRtatelPage> createState() => _DashboardsRtatelPageState();
}

class _DashboardsRtatelPageState extends State<DashboardsRtatelPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool bandera = false;
    return ResponsiveApp(
      builder: (context) {
        UsersProvider provider = Provider.of<UsersProvider>(context);
        String email = currentUser!.email;
        String source = "";
        if (widget.isjobcompletetech == true) {
          if (provider.userSelected?.email == null) {
            source = widget.source + email;
          } else {
            source = widget.source + email;
            email = provider.userSelected!.email;
          }
        }
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) =>
              DashboardRtatelPageMobile(key: UniqueKey()),
          tablet: (BuildContext context) => DashboardRtatelPageDesktop(
            key: UniqueKey(),
            title: widget.title,
            source: widget.source,
            searchVisibility: widget.searchVisibility,
          ),
          desktop: (BuildContext context) => DashboardRtatelPageDesktop(
            key: UniqueKey(),
            title: widget.title,
            source: widget.source,
            // source: widget.isjobcompletetech! ? source : widget.source,
            searchVisibility: widget.searchVisibility,
          ),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
