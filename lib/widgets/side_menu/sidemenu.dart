import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/items_list.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/side_menu_footer.dart';

import '../../models/role.dart';
import '../../pages/login_page/widgets/select_app_form.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Future<void> _refresh() async {
    // Aquí puedes realizar las operaciones de actualización de datos
    // Por ejemplo, puedes llamar a una API, actualizar desde una base de datos, etc.
    await Future.delayed(Duration(seconds: 2));

    // Actualizar el estado de los datos y detener el indicador de actualización
    setState(() {});
  }

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
            border: Border.all(
                width: 1.5, color: AppTheme.of(context).primaryBackground),
          ),
          child: CustomScrollBar(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SelectAppForm(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
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
                                AppTheme.themeMode == ThemeMode.dark
                                    ? Image.network(
                                        assets.logoBlanco,
                                        key: ValueKey(Random().nextInt(100)),
                                        height: getHeight(25, context),
                                      )
                                    : Image.network(
                                        assets.logoColor,
                                        key: ValueKey(Random().nextInt(100)),
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
                                      provider.forcedOpen =
                                          !provider.forcedOpen;
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
                                      key: ValueKey(Random().nextInt(100)),
                                      height: getHeight(25, context),
                                    )
                                  : Image.network(
                                      assets.logoColor,
                                      key: ValueKey(Random().nextInt(100)),
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
                  provider.isOpen
                      ? LoginDropDown<Role>(
                          label: 'Choose an app:',
                          icon: Icons.person,
                          width: 282,
                          list: currentUser!.roles,
                          dropdownValue: currentUser!.currentRole,
                          onChanged: (role) async {
                            if (role == null) return;
                            print(currentUser!.currentRole.roleName);
                            currentUser!.currentRole = role;
                            print("----------");
                            print(currentUser!.currentRole.roleName);
                            // ignore: invalid_use_of_protected_member
                            await prefs.setString('currentRole',
                                currentUser!.currentRole.roleName);
                            if (!mounted) return;
                            print("-------------- a");
                            print(currentUser!.currentRole.roleName);
                            context.pushReplacement('/');

                            setState(() {});
                          },
                          items: currentUser!.roles
                              .map<DropdownMenuItem<Role>>((Role value) {
                            return DropdownMenuItem<Role>(
                              value: value,
                              child: Text(
                                value.roleApplication,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                        )
                      : Container(
                          width: 85,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.of(context).primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.1,
                                blurRadius: 3,
                                // changes position of shadow
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Tooltip(
                            message: "Open side menu to change an app",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: AppTheme.of(context).hintText.color,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppTheme.of(context).hintText.color,
                                )
                              ],
                            ),
                          )),
                  const Spacer(),
                  SideMenuItemsList(isOpen: provider.isOpen),
                  const Spacer(),
                  SideMenuFooter(
                    isOpen: provider.isOpen,
                    image: currentUser!.image ?? assets.avatar,
                    text1: currentUser!.fullName,
                    text2: currentUser!.currentRole.roleName,
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
