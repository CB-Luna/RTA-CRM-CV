import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rta_crm_cv/pages/crm/campaigns/campaigns_page.dart';
import 'package:rta_crm_cv/pages/crm/reports_page.dart';
import 'package:rta_crm_cv/pages/crm/schedulings_page.dart';
import 'package:rta_crm_cv/pages/crm/tickets_page.dart';
import 'package:rta_crm_cv/pages/ctrlv/dashboard/dashboards_page_ctrlv.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/download_apk_page.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/inventory_page_desktop.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/service_pop_up.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/monitory_page_desktop.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/download_apk/dashboard_rtatel_page.dart';
import 'package:rta_crm_cv/pages/login_page/login_page.dart';
import 'package:rta_crm_cv/pages/pages.dart';

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/quotes/create_quote.dart';
import 'package:rta_crm_cv/pages/crm/quotes/detail_quote.dart';
import 'package:rta_crm_cv/pages/crm/quotes/quotes_page.dart';
import 'package:rta_crm_cv/pages/crm/quotes/validate_quote.dart';
import 'package:rta_crm_cv/services/navigation_service.dart';

import '../pages/ctrlv/inventory_page/pop_up/reported_issues_pop_up.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = currentUser != null;
    final bool isLoggingIn = state.location == '/login';

    if (state.location == '/change-password') return null;

    //If user is not logged in and not in the login page
    if (!loggedIn && !isLoggingIn) return '/login';

    //if user is logged in and in the login page

    if (loggedIn && isLoggingIn) return '/';

    return null;
  },
  errorBuilder: (context, state) => const PageNotFoundPage(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'root',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.isCRM) {
          return const QuotesPage();
        } else if (currentUser!.isAdminCv || currentUser!.isManager) {
          return const MonitoryPageDesktop();
        } else if (currentUser!.isEmployee) {
          return const DownloadAPKPage();
        } else if (currentUser!.isDashboardsRTATEL) {
          return const DashboardsRtatelPage();
        } else {
          return const PageNotFoundPage();
        }
      },
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: currentUser!.isCRM
            ? const QuotesPage()
            : currentUser!.isAdminCv ||
                    currentUser!.isManager ||
                    currentUser!.isTechSupervisor
                ? const MonitoryPageDesktop()
                : currentUser!.isEmployee
                    ? const DownloadAPKPage()
                    : currentUser!.isDashboardsRTATEL
                    ? const DashboardsRtatelPage()
                    : const PageNotFoundPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser == null) {
          return const PageNotFoundPage();
        }
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/cambio-contrasena',
      name: 'cambio_contrasena',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser == null) return const LoginPage();
        return const ChangePasswordPage();
      },
    ),
    GoRoute(
      path: '/dashboards',
      name: 'Dashboards',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.isCRM) {
          return const DashboardsCRMPage();
        } else if (currentUser!.isCV) {
          return const DashboardsCTRLVPage();
        } else {
          return const PageNotFoundPage();
        }
      },
      pageBuilder: (context, state) {
        if (currentUser!.isCRM) {
          return pageTransition(context, state, const DashboardsCRMPage());
        } else if (currentUser!.isCV) {
          return pageTransition(context, state, const DashboardsCTRLVPage());
        } else {
          return pageTransition(context, state, const PageNotFoundPage());
        }
      },
    ),
    GoRoute(
      path: routeProspects,
      name: 'Prospects',
      builder: (BuildContext context, GoRouterState state) {
        return const AccountsPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const AccountsPage()),
    ),
    GoRoute(
      path: routeQuoteCreation,
      name: 'Quote Creation',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateQuotePage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const CreateQuotePage()),
    ),
    GoRoute(
      path: routeQuoteDetail,
      name: 'Quote Detail',
      builder: (BuildContext context, GoRouterState state) {
        return const DetailQuotePage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const DetailQuotePage()),
    ),
    GoRoute(
      path: routeQuoteValidation,
      name: 'Quote Validation',
      builder: (BuildContext context, GoRouterState state) {
        return const ValidateQuotePage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const ValidateQuotePage()),
    ),
    GoRoute(
      path: '/schedulings',
      name: 'Schedulings',
      builder: (BuildContext context, GoRouterState state) {
        return const SchedulingsPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const SchedulingsPage()),
    ),
    GoRoute(
      path: '/network',
      name: 'Network',
      builder: (BuildContext context, GoRouterState state) {
        return const NetworkPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const NetworkPage()),
    ),
    GoRoute(
      path: '/tickets',
      name: 'Tickets',
      builder: (BuildContext context, GoRouterState state) {
        return const TicketsPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const TicketsPage()),
    ),
    GoRoute(
      path: routeQuotes,
      name: 'Quotes',
      builder: (BuildContext context, GoRouterState state) {
        return const QuotesPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const QuotesPage()),
    ),

    GoRoute(
      path: routeCampaigns,
      name: 'Campaigns',
      builder: (BuildContext context, GoRouterState state) {
        return const CampaignsPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const CampaignsPage()),
    ),
    GoRoute(
      path: '/reports',
      name: 'Reports',
      builder: (BuildContext context, GoRouterState state) {
        return const ReportsPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const ReportsPage()),
    ),
    GoRoute(
      path: '/users',
      name: 'Users',
      builder: (BuildContext context, GoRouterState state) {
        return const UsersPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const UsersPage()),
    ),
    GoRoute(
      path: '/vehicle_status',
      name: 'Vehicle_Status',
      builder: (BuildContext context, GoRouterState state) {
        return const MonitoryPageDesktop();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const MonitoryPageDesktop()),
    ),
    GoRoute(
      path: '/inventory',
      name: 'Inventory',
      builder: (BuildContext context, GoRouterState state) {
        return const InventoryPageDesktop();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const InventoryPageDesktop()),
    ),
    GoRoute(
      path: routeDetailsInventory,
      name: 'Details_Inventory',
      builder: (BuildContext context, GoRouterState state) {
        if (state.extra == null) return const InventoryPageDesktop();
        // return ReportedIssues(vehicle: state.extra as Vehicle);
        return const ReportedIssues();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: routeService,
      name: 'Services',
      builder: (BuildContext context, GoRouterState state) {
        if (state.extra == null) return const InventoryPageDesktop();
        // return ReportedIssues(vehicle: state.extra as Vehicle);
        return const ServicePopUp();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: routeDownloadAPK,
      name: 'Download APK',
      builder: (BuildContext context, GoRouterState state) {
        return const DownloadAPKPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Sales
    GoRoute(
      path: opcoSuscriberTarget,
      name: 'OpCo Suscriber Targets',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: newSalesTrackingDashboard,
      name: 'New Sales Tracking Dashboards',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyChurn,
      name: 'Monthly Churn %',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: configuratorStats,
      name: 'Configurator Stats',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: noCoverageLeads,
      name: 'No Coverage Leads',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: newConfiguratorStats,
      name: 'New Configurator Stats',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: referralsTracking,
      name: 'Referrals Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: residentialAndBusinessCustomer,
      name: 'Residentials and Business Customers',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: wirelessAndFiberCustomer,
      name: 'Wireless and Fiber Customers',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: voIPTracking,
      name: 'VoIP Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: ipTVTracking,
      name: 'IPTV Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: arpuTrackingResidential,
      name: 'ARPU Tracking Residential',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: arpuTrackingWholesale,
      name: 'ARPU Tracking Wholesale',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyARPUTrackingWholesale,
      name: 'Monthly ARPU Tracking Wholesale',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyARPUTrackingResidential,
      name: 'Monthly ARPU Tracking Residential',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: engageOption,
      name: 'Engage Option',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: conversionRate,
      name: 'Conversion rate',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: deactContactLog,
      name: 'Deact Contact Log',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Surveys
    GoRoute(
      path: wispapalooza2021Survey,
      name: 'WISPAPALOOZA 2021 Survey',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteIncentives,
      name: 'Job Complete Incentives',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompletedServiceOverall,
      name: 'Job Completed Service Overall',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteCRY,
      name: 'Job Complete CRY',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteEAS,
      name: 'Job Complete EAS',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteODE,
      name: 'Job Complete ODE',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteSMI,
      name: 'Job Complete SMI',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteSMI,
      name: 'Job Complete Joseph Aycock',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteAdamBilliot,
      name: 'Job Complete Adam Billiot',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTerryIsreal,
      name: 'Job Complete Terry Isreal',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteCharlieMilich,
      name: 'Job Complete Charile Milich',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteKamrinLilley,
      name: 'Job Complete Kamrin Lilley',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteAlexanderOgle,
      name: 'Job Complete Alexander Ogle',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTimothyMcClaine,
      name: 'Job Complete Timothy McClaine',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteDylanNowell,
      name: 'Job Complete Dylan Nowell',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJosephThomson,
      name: 'Job Complete Joseph Thomson',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteScottNowell,
      name: 'Job Complete Scott Nowell',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteLarryPhilips,
      name: 'Job Complete Larry Philips',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteZacharyLawson,
      name: 'Job Complete Zachary Lawson',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBrandonMurdock,
      name: 'Job Complete Brandon Murdock',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteLynnMcDaniel,
      name: 'Job Complete Lynn McDaniel',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteStephenMcKinney,
      name: 'Job Complete Stephen McKinney',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteThomasHenry,
      name: 'Job Complete Thomas Henry',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJosephBartek,
      name: 'Job Complete Joseph Bartek',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJohnnieThomas,
      name: 'Job Complete Johnnie Thomas',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBrandonSims,
      name: 'Job Complete Brandon Sims',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteEricBranton,
      name: 'Job Complete Eric Branton',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTristanBilbo,
      name: 'Job Complete Tristan Bilbo',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),GoRoute(
      path: jobCompleteGarrettstephens,
      name: 'Job Complete Garrett Stephens',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteMasonCoon,
      name: 'Job Complete Mason Coon',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBriceDrisdale,
      name: 'Job Complete Brice Drisdale',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteAdamKosel,
      name: 'Job Complete Adam Kosel',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteRossHenry,
      name: 'Job Complete Ross Henry',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteEricHarmon,
      name: 'Job Complete Eric Harmon',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompletePaulHill,
      name: 'Job Complete Paul Hill',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBrysonSmith,
      name: 'Job Complete Brynson Smith',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: itSurveyOctober2021,
      name: 'IT Survey October 2021',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Manager
    GoRoute(
      path: bolivarPeninsulaFibertotheHome,
      name: 'Bolivar Peninsula Fiber to the home',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: operationReport,
      name: 'Operation Report',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: techJobTimeTracking,
      name: 'Tech Job Time Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobsTracking,
      name: 'Jobs Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobsUtilizationTracking,
      name: 'Jobs Utilization Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: ivrStats,
      name: 'IVR Stats',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////GigFast Network
    GoRoute(
      path: monitoringDashboard,
      name: 'Monitoring Dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: mapCoverage,
      name: 'Map Coverage',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Call Center
    GoRoute(
      path: ecommerceRTA,
      name: 'EcommerceRTA',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////FMT
    GoRoute(
      path: fmt,
      name: 'FMT',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
     ////////WOP
    GoRoute(
      path: wop,
      name: 'WOP',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage();
      },
      // (context, state, const DetailsPopUp()),
    ),

    /////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////
    GoRoute(
      path: '/config',
      name: 'Configurator',
      builder: (BuildContext context, GoRouterState state) {
        return const ConfigPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const ConfigPage()),
    ),
  ],
);
