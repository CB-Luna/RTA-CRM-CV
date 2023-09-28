import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/theme/theme.dart';

//////// DEV ////////
/* final Uri urlFMTAPK = Uri.parse(
    "https://drive.google.com/file/d/1t7K-NSZJMIlhDXZU2Zz58-w55VUo1cGP/view?usp=share_link");
const String supabaseUrl = 'https://supa43.rtatel.com';
const String anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjg0ODI1MjAwLAogICAgImV4cCI6IDE4NDI2NzgwMDAKfQ.Atj9wTNbdEEVPOjstsO14DtxbY2SEpnr50elVXBgAmM';
const redirectUrl =
    'https://supabase.cbluna-dev.com/arux-change-pass/#/change-password/token';
const themeId = String.fromEnvironment('themeId', defaultValue: '2'); */

//////// PROD ////////
final Uri urlFMTAPK = Uri.parse(
    "https://drive.google.com/file/d/1t7K-NSZJMIlhDXZU2Zz58-w55VUo1cGP/view?usp=share_link");
const String supabaseUrl = 'https://supa41.rtatel.com';
const String anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjg0ODI1MjAwLAogICAgImV4cCI6IDE4NDI2NzgwMDAKfQ.Atj9wTNbdEEVPOjstsO14DtxbY2SEpnr50elVXBgAmM';
const redirectUrl =
    'https://supabase.cbluna-dev.com/arux-change-pass/#/change-password/token';
const themeId = String.fromEnvironment('themeId', defaultValue: '2');

//String apiGatewayURL = "http://10.5.24.43:8082/x2/api"; //DEV
//String apiGatewayURL = "https://apps.cblsrv43.rtatel.com/wop_x2/api"; //DEV
String apiGatewayURL = "https://apps.cblsrv41.rtatel.com/wop_x2/api"; //PROD

PlutoGridScrollbarConfig plutoGridScrollbarConfig(BuildContext context) {
  return PlutoGridScrollbarConfig(
    isAlwaysShown: true,
    scrollbarThickness: 5,
    hoverWidth: 20,
    scrollBarColor: AppTheme.of(context).primaryColor,
  );
}

double rowHeight = 60;

PlutoGridStyleConfig plutoGridStyleConfig(BuildContext context) {
  return AppTheme.themeMode == ThemeMode.light
      ? PlutoGridStyleConfig(
          //columnContextIcon: Icons.more_horiz,
          rowHeight: rowHeight,
          iconColor: AppTheme.of(context).primaryColor,
          checkedColor: AppTheme.themeMode == ThemeMode.light
              ? const Color(0xFFC7D8ED)
              : const Color(0XFF4B4B4B),
          /////////////////////////////////////
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          /////////////////////////////////////
          rowColor: AppTheme.of(context).primaryBackground,
          enableRowColorAnimation: true,
          /////////////////////////////////////
          gridBackgroundColor: Colors.transparent,
          menuBackgroundColor: AppTheme.of(context).primaryBackground,
          activatedColor: AppTheme.of(context).primaryBackground,
          /////////////////////////////////////
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).primaryBackground,
          gridBorderColor: AppTheme.of(context).primaryColor,
          gridBorderRadius: BorderRadius.circular(15),
          gridPopupBorderRadius: BorderRadius.circular(15),
        )
      : PlutoGridStyleConfig.dark(
          rowHeight: rowHeight,
          iconColor: AppTheme.of(context).primaryColor,
          checkedColor: AppTheme.themeMode == ThemeMode.light
              ? const Color(0xFFC7D8ED)
              : const Color(0XFF4B4B4B),
          /////////////////////////////////////
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          /////////////////////////////////////
          rowColor: AppTheme.of(context).primaryBackground,
          enableRowColorAnimation: true,
          /////////////////////////////////////
          menuBackgroundColor: AppTheme.of(context).primaryBackground,
          activatedColor: AppTheme.of(context).primaryBackground,
          /////////////////////////////////////
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).primaryBackground,
          gridBorderColor: Colors.transparent,
          gridBackgroundColor: AppTheme.of(context).primaryBackground,
          gridBorderRadius: BorderRadius.circular(15),
          gridPopupBorderRadius: BorderRadius.circular(15),
        );
}

CustomTransitionPage<void> pageTransition(
    BuildContext context, GoRouterState state, Widget page) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

const String routeProspects = '/prospects';
const String routeQuoteCreation = '/order_creation';
const String routeQuoteDetail = '/order_detail';
const String routeQuoteValidation = '/order_validation';
const String routeDetailsInventory = '/details_inventory';
const String routeService = '/service';
const String routeQuotes = '/order';
const String routeCampaigns = '/campaigns';
const String routeDownloadAPK = '/download_apk';
const String routeInventory = '/inventory';
const String routeTickets = '/tickets';
