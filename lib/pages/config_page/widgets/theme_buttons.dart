import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/config_page/widgets/download_theme_popup.dart';
import 'package:rta_crm_cv/pages/config_page/widgets/upload_theme_popup.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/animated_hover_buttom.dart';



class ThemeButtons extends StatefulWidget {
  const ThemeButtons({Key? key}) : super(key: key);

  @override
  State<ThemeButtons> createState() => _ThemeButtonsState();
}

class _ThemeButtonsState extends State<ThemeButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedHoverButton(
              tooltip: 'Cargar tema',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.upload,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const UploadThemePopup();
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 250),
            child: AnimatedHoverButton(
              tooltip: 'Descargar tema',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.download,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const DownloadThemePopup();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}