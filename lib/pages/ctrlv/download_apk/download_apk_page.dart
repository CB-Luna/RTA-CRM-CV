import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/content_download_apk.dart';
import 'package:rta_crm_cv/providers/ctrlv/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DownloadAPKPage extends StatefulWidget {
  const DownloadAPKPage({super.key});

  @override
  State<DownloadAPKPage> createState() => _DownloadAPKPageState();
}

class _DownloadAPKPageState extends State<DownloadAPKPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final DashboardCVProvider provider = Provider.of<DashboardCVProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(13);
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
                      //Titulo
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
                                  child: sideM.aRDownloadAPK != null ? Rive(artboard: sideM.aRDownloadAPK!) : const CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Download APK', style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Contenido
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: ContentDownloadAPK(),
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
