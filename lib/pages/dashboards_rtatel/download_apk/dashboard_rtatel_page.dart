import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/download_apk/dashboard_rtatel_page_desktop.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/download_apk/dashboard_rtatel_page_mobile.dart';

class DashboardsRtatelPage extends StatefulWidget {
  final String title;
  final String source;
  const DashboardsRtatelPage(
      {Key? key, required this.title, required this.source})
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
    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) =>
              DashboardRtatelPageMobile(key: UniqueKey()),
          tablet: (BuildContext context) => DashboardRtatelPageDesktop(
              key: UniqueKey(), title: widget.title, source: widget.source),
          desktop: (BuildContext context) => DashboardRtatelPageDesktop(
              key: UniqueKey(), title: widget.title, source: widget.source),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
