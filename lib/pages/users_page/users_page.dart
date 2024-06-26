import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/users_page/widgets/save_user_popup.dart';
import 'package:rta_crm_cv/pages/users_page/widgets/verify_deletion_popup.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/providers/users_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/pluto_grid_cells/pluto_grid_company_cell.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../widgets/pluto_grid_cells/pluto_grid_status_user_cell.dart';
import 'PopUps/export_users.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final UsersProvider provider = Provider.of<UsersProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    UsersProvider provider = Provider.of<UsersProvider>(context);

    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(10);

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
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomCard(
                  title: 'User List',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(Icons.filter_alt_outlined,
                                  color:
                                      AppTheme.of(context).primaryBackground),
                              text: 'Filter',
                              style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                  ),
                              onTap: () => provider.stateManager!
                                  .setShowColumnFilter(
                                      !provider.stateManager!.showColumnFilter),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: CustomTextIconButton(
                                width: MediaQuery.of(context).size.width * 0.08,
                                isLoading: false,
                                icon: Icon(Icons.archive_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground),
                                text: 'Archive',
                                style: AppTheme.of(context)
                                    .contenidoTablas
                                    .override(
                                      fontFamily: 'Gotham-Regular',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                color: AppTheme.of(context).primaryColor,
                                onTap: () async {
                                  provider.page = 1;
                                  await provider.getUsers(active: 'Not Active');
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: CustomTextIconButton(
                                width: MediaQuery.of(context).size.width * 0.08,
                                isLoading: false,
                                icon: Icon(Icons.open_in_browser_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground),
                                text: 'Active',
                                style: AppTheme.of(context)
                                    .contenidoTablas
                                    .override(
                                      fontFamily: 'Gotham-Regular',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                color: AppTheme.of(context).primaryColor,
                                onTap: () async {
                                  await provider.updateState();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: CustomTextIconButton(
                                mainAxisAlignment: MainAxisAlignment.center,
                                width: MediaQuery.of(context).size.width * 0.10,
                                isLoading: false,
                                icon: Icon(Icons.download_for_offline_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground),
                                text: 'Export Data',
                                style: AppTheme.of(context)
                                    .contenidoTablas
                                    .override(
                                      fontFamily: 'Gotham-Regular',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                color: AppTheme.of(context).primaryColor,
                                onTap: () async {
                                  provider.clearControllerExportData(
                                      notify: false);
                                  if (!mounted) return;
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const ExportUsers();
                                      });
                                },
                              ),
                            ),
                            CustomTextField(
                              width: 500,
                              enabled: true,
                              controller: provider.searchController,
                              icon: Icons.search,
                              label: 'Search',
                              keyboardType: TextInputType.text,
                              onChanged: (p0) {
                                setState(() {
                                  provider.updateState();
                                });
                              },
                            ),
                            if (!currentUser!.isAdmin)
                              const SizedBox(width: 106),
                            if (currentUser!.isAdmin)
                              CustomTextIconButton(
                                isLoading: false,
                                icon: Icon(Icons.add,
                                    color:
                                        AppTheme.of(context).primaryBackground),
                                text: 'Add User',
                                style: AppTheme.of(context)
                                    .contenidoTablas
                                    .override(
                                      fontFamily: 'Gotham-Regular',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                onTap: () async {
                                  provider.clearControllers(notify: false);
                                  await provider.getRoles(notify: false);
                                  await provider.getCompanies(notify: false);
                                  await provider.getStates(notify: false);
                                  if (!mounted) return;
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SaveUserPopUp();
                                    },
                                  );
                                  await provider.updateState();
                                },
                              )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: getHeight(850, context),
                          width: getWidth(2450, context),
                          child: PlutoGrid(
                            key: UniqueKey(),
                            configuration: PlutoGridConfiguration(
                              scrollbar: plutoGridScrollbarConfig(context),
                              style: plutoGridStyleConfig(context),
                              columnFilter: PlutoGridColumnFilterConfig(
                                filters: const [
                                  ...FilterHelper.defaultFilters,
                                ],
                                resolveDefaultColumnFilter: (column, resolver) {
                                  if (column.field == 'ID_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'AVATAR_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'USER_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'ROLE_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'EMAIL_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'MOBILE_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'ADDRESS_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'STATE_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'COMPANY_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'STATUS_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field ==
                                      'LicenseP_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field == 'LICENSE_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  } else if (column.field ==
                                      'CERTIFICATION_Column') {
                                    return resolver<PlutoFilterTypeContains>()
                                        as PlutoFilterType;
                                  }
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                },
                              ),
                            ),
                            columns: [
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.vpn_key_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'ID',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'ID',
                                field: 'ID_Column',
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableRowDrag: false,
                                enableDropToResize: false,
                                enableEditingMode: false,
                                width: 120,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                      child: Text(
                                        rendererContext.cell.value.toString(),
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                                  );
                                },
                                footerRenderer: (context) {
                                  return SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconButton(
                                          icon: Icons
                                              .keyboard_arrow_down_outlined,
                                          toolTip: 'less',
                                          onTap: () {
                                            provider.setPageSize('less');
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          provider.pageRowCount.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 10),
                                        CustomIconButton(
                                          icon:
                                              Icons.keyboard_arrow_up_outlined,
                                          toolTip: 'more',
                                          onTap: () {
                                            provider.setPageSize('more');
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        /* CustomIconButton(
                                          icon: const Icon(Icons.refresh_rounded),
                                          toolTip: 'load',
                                          onTap: () {
                                            provider.load();
                                          },
                                        ), */
                                      ],
                                    ),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.person_outline,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'USER',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'USER',
                                field: 'USER_Column',
                                width: 225,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                                footerRenderer: (context) {
                                  return SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconButton(
                                          icon:
                                              Icons.keyboard_double_arrow_left,
                                          toolTip: 'start',
                                          onTap: () {
                                            provider.setPage('start');
                                          },
                                        ),
                                        const SizedBox(width: 2),
                                        CustomIconButton(
                                          icon: Icons
                                              .keyboard_arrow_left_outlined,
                                          toolTip: 'previous',
                                          onTap: () {
                                            provider.setPage('previous');
                                          },
                                        ),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: 30,
                                          child: Center(
                                            child: Text(
                                              provider.page.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        CustomIconButton(
                                          icon: Icons
                                              .keyboard_arrow_right_outlined,
                                          toolTip: 'next',
                                          onTap: () {
                                            provider.setPage('next');
                                          },
                                        ),
                                        const SizedBox(width: 2),
                                        CustomIconButton(
                                          icon:
                                              Icons.keyboard_double_arrow_right,
                                          toolTip: 'end',
                                          onTap: () {
                                            provider.setPage('end');
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                  //PlutoPagination(context.stateManager);
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.local_offer_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'ROLE',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'ROLE',
                                field: 'ROLE_Column',
                                width: 150,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.alternate_email,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'EMAIL',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'EMAIL',
                                field: 'EMAIL_Column',
                                width: 225,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.phone_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'MOBILE PHONE',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'MOBILE PHONE',
                                field: 'MOBILE_Column',
                                width: 200,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.home_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'ADDRESS',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'ADDRESS',
                                field: 'ADDRESS_Column',
                                width: 200,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.location_on_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'STATE',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'STATE',
                                field: 'STATE_Column',
                                width: 175,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.warehouse_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'COMPANY',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'COMPANY',
                                field: 'COMPANY_Column',
                                width: 200,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  // return PlutoGridCompanyCellCV(
                                  //     text: rendererContext.cell.value ?? "-");
                                  return PlutoGridCompanyCellCV(
                                      companies:
                                          rendererContext.cell.value ?? "-");
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.credit_card_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'License Plates',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'License Plates',
                                field: 'LicenseP_Column',
                                width: 200,
                                hide: currentUser!.isAdminDashboards ||
                                    currentUser!.isAdminCrm,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                      rendererContext.cell.value ?? '-',
                                      style: AppTheme.of(context)
                                          .contenidoTablas
                                          .override(
                                              fontFamily: 'Gotham-Regular',
                                              useGoogleFonts: false),
                                    )),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                          Icons.manage_accounts_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'Status',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'Status',
                                field: 'STATUS_Column',
                                width: 200,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return PlutoGridStatusCellUserCV(
                                      text: rendererContext.cell.value ?? "-");
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                          Icons.card_membership_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'License',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'License',
                                field: 'LICENSE_Column',
                                width: 200,
                                hide: currentUser!.isAdminDashboards ||
                                    currentUser!.isAdminCrm,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                            rendererContext.cell.value ?? '-')),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                          Icons.workspace_premium_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground)),
                                  const WidgetSpan(child: SizedBox(width: 10)),
                                  TextSpan(
                                      text: 'Certification',
                                      style:
                                          AppTheme.of(context).encabezadoTablas)
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'Certification',
                                field: 'CERTIFICATION_Column',
                                width: 200,
                                hide: currentUser!.isAdminDashboards ||
                                    currentUser!.isAdminCrm,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Center(
                                        child: Text(
                                            rendererContext.cell.value ?? '-')),
                                  );
                                },
                              ),
                              PlutoColumn(
                                titleSpan: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.list,
                                        color: AppTheme.of(context)
                                            .primaryBackground),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(width: 10),
                                  ),
                                  TextSpan(
                                    text: 'ACTIONS',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground),
                                  )
                                ]),
                                backgroundColor: const Color(0XFF6491F7),
                                title: 'ACTIONS',
                                field: 'ACTIONS_Column',
                                width: 190,
                                titleTextAlign: PlutoColumnTextAlign.start,
                                textAlign: PlutoColumnTextAlign.center,
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                enableSorting: false,
                                enableContextMenu: false,
                                enableDropToResize: false,
                                cellPadding: EdgeInsets.zero,
                                renderer: (rendererContext) {
                                  return Container(
                                    height: rowHeight,
                                    // width: rendererContext.cell.column.width,
                                    decoration:
                                        BoxDecoration(gradient: whiteGradient),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomTextIconButton(
                                          isLoading: false,
                                          icon: Icon(
                                            Icons.fact_check_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          text: 'Edit',
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                          onTap: () async {
                                            await provider.getCompanies(
                                                notify: false);
                                            await provider.getStates(
                                                notify: false);
                                            await provider.getRoles(
                                                notify: false);
                                            await provider.getVehicleUser(
                                                rendererContext.cell.value,
                                                notify: false);
                                            await provider.getVehicleActiveInit(
                                              rendererContext.cell.value,
                                              notify: false,
                                            );
                                            provider.initEditUser(
                                                rendererContext.cell.value);

                                            if (!mounted) return;
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return SaveUserPopUp(
                                                      user: rendererContext
                                                          .cell.value);
                                                });
                                              },
                                            );
                                            await provider.updateState();
                                          },
                                        ),
                                        CustomTextIconButton(
                                          isLoading: false,
                                          icon: Icon(
                                            Icons.shopping_basket_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          color: secondaryColor,
                                          text: 'Delete',
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryBackground,
                                              ),
                                          onTap: () async {
                                            await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return DeletePopUp(
                                                        user: rendererContext
                                                            .cell.value);
                                                  });
                                                });
                                            await provider.getUsers();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                            rows: provider.rows,
                            onLoaded: (event) async {
                              provider.stateManager = event.stateManager;
                              // provider.stateManager!.setShowColumnFilter(true);
                              // provider.stateManager!.showFilterPopup(context);
                              // provider.stateManager!.setPage(10);
                            },
                            createFooter: (stateManager) {
                              stateManager.setPageSize(provider.pageRowCount,
                                  notify: false);
                              stateManager.setPage(provider.page);
                              return const SizedBox(height: 0, width: 0);
                            },
                          ),
                        ),
                      ),
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
