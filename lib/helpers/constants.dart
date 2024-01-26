import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/theme/theme.dart';


//////// DEV ////////
// final Uri urlFMTAPK = Uri.parse("https://drive.google.com/file/d/1lUdS__gG-g4zSPjq_3-LFhnMOmHhYAR8/view?usp=share_link");
// const String supabaseUrl = 'https://supa43.rtatel.com';
// const String anonKey =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjg0ODI1MjAwLAogICAgImV4cCI6IDE4NDI2NzgwMDAKfQ.Atj9wTNbdEEVPOjstsO14DtxbY2SEpnr50elVXBgAmM';
// const redirectUrl = 'https://supabase.cbluna-dev.com/arux-change-pass/#/change-password/token';
// const themeId = String.fromEnvironment('themeId', defaultValue: '2');
// String urlNotifications = 'https://supa43.rtatel.com/notifications/api';

//////// TEST ////////
final Uri urlFMTAPK = Uri.parse(
    "https://drive.google.com/file/d/1lUdS__gG-g4zSPjq_3-LFhnMOmHhYAR8/view?usp=share_link");
const String supabaseUrl = 'https://supa42.rtatel.com';
const String anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjg0ODI1MjAwLAogICAgImV4cCI6IDE4NDI2NzgwMDAKfQ.Atj9wTNbdEEVPOjstsO14DtxbY2SEpnr50elVXBgAmM';
const redirectUrl =
    'https://supabase.cbluna-dev.com/arux-change-pass/#/change-password/token';
const themeId = String.fromEnvironment('themeId', defaultValue: '2');
String urlNotifications = 'https://supa42.rtatel.com/notifications/api';
const String configurator = 'https://cblsrvr404.rtatel.com';
String apiGatewayURL = "https://apps.cblsrv41.rtatel.com/wop_x2/api";

PlutoGridScrollbarConfig plutoGridScrollbarConfig(BuildContext context) {
  return PlutoGridScrollbarConfig(
    isAlwaysShown: true,
    scrollbarThickness: 5,
    hoverWidth: 20,
    scrollBarColor: AppTheme.of(context).primaryColor,
  );
}

PlutoGridScrollbarConfig plutoGridScrollbarConfigDashboard(
    BuildContext context) {
  return PlutoGridScrollbarConfig(
    isAlwaysShown: true,
    scrollbarThickness: 5,
    hoverWidth: 20,
    scrollBarColor: AppTheme.of(context).gris,
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
          menuBackgroundColor: AppTheme.of(context).gris,
          activatedColor: AppTheme.of(context).gris,
          /////////////////////////////////////
          enableCellBorderVertical: false,
          borderColor: Colors.black,
          gridBorderColor: Colors.black,
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

double rowHeightDashboard = 40;

PlutoGridStyleConfig plutoGridStyleConfigDashboard(BuildContext context) {
  return AppTheme.themeMode == ThemeMode.light
      ? PlutoGridStyleConfig(
          //columnContextIcon: Icons.more_horiz,
          rowHeight: rowHeightDashboard,
          iconColor: AppTheme.of(context).primaryColor,
          checkedColor: AppTheme.themeMode == ThemeMode.light
              ? const Color(0xFFC7D8ED)
              : const Color(0XFF4B4B4B),
          /////////////////////////////////////
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          /////////////////////////////////////
          rowColor: AppTheme.of(context).gris,
          enableRowColorAnimation: true,
          /////////////////////////////////////
          gridBackgroundColor: Colors.transparent,
          menuBackgroundColor: AppTheme.of(context).gris,
          activatedColor: AppTheme.of(context).gris,
          /////////////////////////////////////
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).gris,
          gridBorderColor: AppTheme.of(context).gris,
          // gridBorderRadius: BorderRadius.circular(15),
          // gridPopupBorderRadius: BorderRadius.circular(15),
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
const String routeTickets = '/tickets';
const String routeQuotes = '/order';
const String routeCampaigns = '/campaigns';
const String routeDownloadAPK = '/download_apk';
const String routeInventory = '/inventory';
const String routeJobCompleteTechni = '/job_complete_technicians';
const String routemaintenanceDashboard = '/maintenanceDashboard';
//Sales
const String opcoSuscriberTarget = '/sales/opco_suscriber_target';
const String newSalesTrackingDashboard = '/sales/new_sales_tracking_dashboard';
const String monthlyChurn = '/sales/monthly_churn';
const String configuratorStats = '/sales/configurator_stats';
const String noCoverageLeads = '/sales/no_coverage_leads';
const String newConfiguratorStats = '/sales/new_configurator_stats';
const String referralsTracking = '/sales/referrals_tracking';
const String residentialAndBusinessCustomer =
    '/sales/residential_and_business_customer';
const String wirelessAndFiberCustomer = '/sales/wirelessAndFiberCustomer';
const String voIPTracking = '/sales/voip_tracking';
const String ipTVTracking = '/sales/iptv_tracking';
const String arpuTrackingResidential = '/sales/arpu_tracking_residential';
const String arpuTrackingWholesale = '/sales/arpu_tracking_wholesale';
const String monthlyARPUTrackingWholesale =
    '/sales/monthly_arpu_tracking_wholesale';
const String monthlyARPUTrackingResidential =
    '/sales/monthly_arpu_tracking_residential';
const String engageOption = '/sales/engage_option';
const String conversionRate = '/sales/conversion_rate';
const String deactContactLog = '/sales/deact_contact_log';
// Manager
const String bolivarPeninsulaFibertotheHome =
    '/manager/bolivar_peninsula_fiber_to_the_home';
const String operationReport = '/manager/operation_report';
const String techJobTimeTracking = '/manager/tech_job_time_tracking';
const String jobsTracking = '/manager/jobs_tracking';
const String jobsUtilizationTracking = '/manager/jobs_utilization_tracking';
const String ivrStats = '/manager/ivr_stats';
// Gigfast Network
const String monitoringDashboard = '/gigfast_network/monitoring_dashboard';
const String mapCoverage = '/gigfast_network/map_coverage';
// Call Center
const String ecommerceRTA = '/call_center/ecommerceRTA';
const String homeownerFTTHDocument = '/call_center/homeownerFTTHDocument';
const String homeownerFTTHDocumentList =
    '/call_center/homeownerFTTHDocumentList';
const String homeownerFTTHDocumentClient =
    '/call_center/homeownerFTTHDocumentClient';
// Surveys
const String wispapalooza2021Survey = '/surveys/wispapalooza_2021_survey';
const String jobComplete = '/surveys/job_complete';
const String jobCompleteTechnicians = '/surveys/job_complete_technicians';
const String jobCompleteTech = '/surveys/job_complete_technicians';
const String itSurveyOctober2021 = '/surveys/it_survey_october_2021';

// Job Complete
const String jobCompleteIncentives = '/job_complete/job_complete_incentives';
const String jobCompletedServiceOverall =
    '/job_complete/job_completed_service_overall';
const String jobCompleteCRY = '/job_complete/job_complete_CRY';
const String jobCompleteEAS = '/job_complete/job_complete_EAS';
const String jobCompleteODE = '/job_complete/job_completeODE';
const String jobCompleteSMI = '/job_complete/job_completeSMI';

const String fmt = '/fmt';
const String wop = '/wop';
