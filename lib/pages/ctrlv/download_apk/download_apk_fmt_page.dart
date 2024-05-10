import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/download_apk_fmt_page_desktop.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/download_apk_fmt_page_mobile.dart';

class DownloadAPKFMTPage extends StatefulWidget {
  const DownloadAPKFMTPage({Key? key}) : super(key: key);

  @override
  State<DownloadAPKFMTPage> createState() => _DownloadAPKFMTPageState();
}

class _DownloadAPKFMTPageState extends State<DownloadAPKFMTPage> {

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
          mobile: (BuildContext context) => DownloadAPKFMTPageMobile(
            key: UniqueKey()),
          tablet: (BuildContext context) => DownloadAPKFMTPageDesktop(
            key: UniqueKey()),
          desktop: (BuildContext context) => DownloadAPKFMTPageDesktop(
            key: UniqueKey()),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
