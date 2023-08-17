import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/download_apk_page_desktop.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/download_apk_page_mobile.dart';

class DownloadAPKPage extends StatefulWidget {
  const DownloadAPKPage({Key? key}) : super(key: key);

  @override
  State<DownloadAPKPage> createState() => _DownloadAPKPageState();
}

class _DownloadAPKPageState extends State<DownloadAPKPage> {

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
          mobile: (BuildContext context) => DownloadAPKPageMobile(
            key: UniqueKey()),
          tablet: (BuildContext context) => DownloadAPKPageDesktop(
            key: UniqueKey()),
          desktop: (BuildContext context) => DownloadAPKPageDesktop(
            key: UniqueKey()),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
