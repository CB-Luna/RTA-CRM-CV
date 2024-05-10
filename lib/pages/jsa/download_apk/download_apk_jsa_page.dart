import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rta_crm_cv/pages/jsa/download_apk/download_apk_jsa_page_desktop.dart';
import 'package:rta_crm_cv/pages/jsa/download_apk/download_apk_jsa_page_mobile.dart';

class DownloadAPKJSAPage extends StatefulWidget {
  const DownloadAPKJSAPage({Key? key}) : super(key: key);

  @override
  State<DownloadAPKJSAPage> createState() => _DownloadAPKJSAPageState();
}

class _DownloadAPKJSAPageState extends State<DownloadAPKJSAPage> {

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
          mobile: (BuildContext context) => DownloadAPKJSAPageMobile(
            key: UniqueKey()),
          tablet: (BuildContext context) => DownloadAPKJSAPageDesktop(
            key: UniqueKey()),
          desktop: (BuildContext context) => DownloadAPKJSAPageDesktop(
            key: UniqueKey()),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
