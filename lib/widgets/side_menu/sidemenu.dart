import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/items_list.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/side_menu_footer.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    provider.checkWindowSize(context);

    return Material(
      child: Container(
        decoration: BoxDecoration(gradient: whiteGradient),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: provider.isOpen ? 300 : 100,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            //color:AppTheme.of(context).primaryColor
            gradient: whiteGradient,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            border: Border.all(width: 1.5, color: AppTheme.of(context).primaryBackground),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: provider.isOpen
                        ? SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Image.network(
                                //   'https://rtatel.com/wp-content/uploads/2022/11/cropped-RTAREGISTERED.png',
                                //   height: getHeight(60, context),
                                // ),
                                Image.asset(
                                  "assets/images/rta_logo.png",
                                  height: getHeight(60, context),
                                ),

                                InkWell(
                                  hoverColor: Colors.transparent,
                                  child: Icon(
                                    Icons.menu,
                                    color: AppTheme.of(context).primaryColor,
                                    size: getHeight(40, context),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      provider.isOpen = !provider.isOpen;
                                      provider.forcedOpen = !provider.forcedOpen;
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTheme.themeMode == ThemeMode.dark
                                  ? Image.network(
                                      assets.logoBlanco,
                                      height: getHeight(25, context),
                                    )
                                  : Image.network(
                                      assets.logoColor,
                                      height: getHeight(25, context),
                                    ),
                              InkWell(
                                hoverColor: Colors.transparent,
                                child: Icon(
                                  Icons.menu,
                                  color: AppTheme.of(context).primaryColor,
                                  size: getHeight(40, context),
                                ),
                                onTap: () {
                                  setState(() {
                                    provider.isOpen = !provider.isOpen;
                                    provider.forcedOpen = !provider.forcedOpen;
                                  });
                                },
                              )
                            ],
                          ),
                  ),
                  const Spacer(),
                  SideMenuItemsList(isOpen: provider.isOpen),
                  const Spacer(),
                  SideMenuFooter(
                    isOpen: provider.isOpen,
                    image: 'https://www.sadm.gob.mx/AyD_Aclaraciones/Content/user.png',
                    text1: 'Loremipsum 1',
                    text2: 'Loermipsum 2',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
