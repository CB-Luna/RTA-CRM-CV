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
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/homeowner_ftth_document/homeowner_ftth_document_client.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/homeowner_ftth_document/homeowner_ftth_document_list.dart';

import '../pages/ctrlv/inventory_page/pop_up/reported_issues_pop_up.dart';
import '../widgets/side_menu/widgets/surveys/homeowner_ftth_document/homeowner_ftth_document.dart';

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
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
        } else if (currentUser!.isDashboardsOperation) {
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
        } else if (currentUser!.isDashboardsFinancial) {
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
        } else if (currentUser!.isDashboardsBank) {
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
        } else if (currentUser!.isDashboardsCareRep) {
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
        } else if (currentUser!.isDashboardsInstaller) {
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
        } else if (currentUser!.isDashboardsSupervisor) {
          return const DashboardsRtatelPage(
              title: "OpCo Suscriber Targets",
              source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
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
                        ? const DashboardsRtatelPage(
                            title: "OpCo Suscriber Targets",
                            source:
                                "https://cblsrvr1.rtatel.com/dash/#/business_plan")
                        : currentUser!.isDashboardsOperation
                            ? const DashboardsRtatelPage(
                                title: "OpCo Suscriber Targets",
                                source:
                                    "https://cblsrvr1.rtatel.com/dash/#/business_plan")
                            : currentUser!.isDashboardsFinancial
                                ? const DashboardsRtatelPage(
                                    title: "OpCo Suscriber Targets",
                                    source:
                                        "https://cblsrvr1.rtatel.com/dash/#/business_plan")
                                : currentUser!.isDashboardsBank
                                    ? const DashboardsRtatelPage(
                                        title: "OpCo Suscriber Targets",
                                        source:
                                            "https://cblsrvr1.rtatel.com/dash/#/business_plan")
                                    : currentUser!.isDashboardsCareRep
                                        ? const DashboardsRtatelPage(
                                            title: "OpCo Suscriber Targets",
                                            source:
                                                "https://cblsrvr1.rtatel.com/dash/#/business_plan")
                                        : currentUser!.isDashboardsInstaller
                                            ? const DashboardsRtatelPage(
                                                title: "OpCo Suscriber Targets",
                                                source:
                                                    "https://cblsrvr1.rtatel.com/dash/#/business_plan")
                                            : currentUser!
                                                    .isDashboardsSupervisor
                                                ? const DashboardsRtatelPage(
                                                    title:
                                                        "OpCo Suscriber Targets",
                                                    source:
                                                        "https://cblsrvr1.rtatel.com/dash/#/business_plan")
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
        return const DashboardsRtatelPage(
            title: "OpCo Suscriber Targets",
            source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: newSalesTrackingDashboard,
      name: 'New Sales Tracking Dashboards',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "New Sales Tracking Dashboards",
            source: "https://cblsrvr1.rtatel.com/dash/#/sales_tracking");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyChurn,
      name: 'Monthly Churn %',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Monthly Churn %",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/sales_tracking/MonthlyChurnPercent");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: configuratorStats,
      name: 'Configurator Stats',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Configurator Stats",
            source: "https://cblsrvr1.rtatel.com/dash/#/configurator_stats");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: noCoverageLeads,
      name: 'No Coverage Leads',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "No Coverage Leads",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/configurator/nocoverageleads");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: newConfiguratorStats,
      name: 'New Configurator Stats',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "New Configurator Stats",
            source:
                "https://cblsrvr1.rtatel.com/dashstats/configuratorStats.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: referralsTracking,
      name: 'Referrals Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Referrals Tracking",
            source:
                "https://cblsrvr1.rtatel.com/dashstats/referralsTracking.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: residentialAndBusinessCustomer,
      name: 'Residentials and Business Customers',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Residentials and Business Customers",
            source: "https://cblsrvr1.rtatel.com/dash/#/customers_tracking");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: wirelessAndFiberCustomer,
      name: 'Wireless and Fiber Customers',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Wireless and Fiber Customers",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking/network");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: voIPTracking,
      name: 'VoIP Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "VoIP Tracking",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking/voip");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: ipTVTracking,
      name: 'IPTV Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "IPTV Tracking",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking_iptv");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: arpuTrackingResidential,
      name: 'ARPU Tracking Residential',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "ARPU Tracking Residential",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking_arpuCustom");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: arpuTrackingWholesale,
      name: 'ARPU Tracking Wholesale',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "ARPU Tracking Wholesale",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking_arpu_wholesale");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyARPUTrackingWholesale,
      name: 'Monthly ARPU Tracking Wholesale',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Monthly ARPU Tracking Wholesale",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking_arpuCustom_wholesale");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyARPUTrackingResidential,
      name: 'Monthly ARPU Tracking Residential',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Monthly ARPU Tracking Residential",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/customers_tracking_arpuCustom");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: engageOption,
      name: 'Engage Option',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Engage Option",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/engage_option_tracking");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: conversionRate,
      name: 'Conversion rate',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Conversion rate",
            source:
                "https://cblsrvr1.rtatel.com/dashstats/conversionRate.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: deactContactLog,
      name: 'Deact Contact Log',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Deact Contact Log",
            source: "https://cblsrvr1.rtatel.com/dashstats/contactLogV2.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Surveys EMPIEZO
    GoRoute(
      path: wispapalooza2021Survey,
      name: 'WISPAPALOOZA 2021 Survey',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "WISPAPALOOZA 2021 Survey",
            source:
                "https://survey.rtatel.com/survey/dashboard_wispapalooza2021.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteIncentives,
      name: 'Job Complete Incentives',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Incentives",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/financial");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompletedServiceOverall,
      name: 'Job Completed Service Overall',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Completed Service Overall",
            source: "https://techsurvey.rtatel.com/survey/dash/jobcomplete");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteCRY,
      name: 'Job Complete CRY',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete CRY",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/bm?comp=CRY");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteEAS,
      name: 'Job Complete EAS',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete EAS",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/bm?comp=EAS");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteODE,
      name: 'Job Complete ODE',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete ODE",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/bm?comp=ODE");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteSMI,
      name: 'Job Complete SMI',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete SMI",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/bm?comp=SMI");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJosephAycock,
      name: 'Job Complete Joseph Aycock',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Joseph Aycock",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=joseph.aycock@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteAdamBilliot,
      name: 'Job Complete Adam Billiot',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Adam Billiot",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=adam.billiot@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTerryIsreal,
      name: 'Job Complete Terry Isreal',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Terry Isreal",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=terry.isreal@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteCharlieMilich,
      name: 'Job Complete Charlie Milich',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Charlie Milich",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=charlie.milich@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteKamrinLilley,
      name: 'Job Complete Kamrin Lilley',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Kamrin Lilley",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=kamrin.lilley@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteAlexanderOgle,
      name: 'Job Complete Alexander Ogle',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Alexander Ogle",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=alexander.ogle@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTimothyMcClaine,
      name: 'Job Complete Timothy McClaine',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Timothy McClaine",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=timothy.mcclaine@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteDylanNowell,
      name: 'Job Complete Dylan Nowell',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Dylan Nowell",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=dylan.nowell@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJosephThomson,
      name: 'Job Complete Joseph Thomson',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Joseph Thomson",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=joseph.thomson@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteScottNowell,
      name: 'Job Complete Scott Nowell',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Scott Nowell",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=scott.nowell@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteLarryPhilips,
      name: 'Job Complete Larry Philips',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Larry Philips",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=larry.phillips@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteZacharyLawson,
      name: 'Job Complete Zachary Lawson',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Zachary Lawson",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=zachary.lawson@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBrandonMurdock,
      name: 'Job Complete Brandon Murdock',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Brandon Murdock",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=brandon.murdock@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteLynnMcDaniel,
      name: 'Job Complete Lynn McDaniel',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Lynn McDaniel",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=lynn.mcdaniel@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteStephenMcKinney,
      name: 'Job Complete Stephen McKinney',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Stephen McKinney",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=stephen.mckinney@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteThomasHenry,
      name: 'Job Complete Thomas Henry',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Thomas Henry",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=thomas.henry@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJosephBartek,
      name: 'Job Complete Joseph Bartek',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Joseph Bartek",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=joseph.bartek@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteJohnnieThomas,
      name: 'Job Complete Johnnie Thomas',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Johnnie Thomas",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=johnnie.thomas@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBrandonSims,
      name: 'Job Complete Brandon Sims',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Brandon Sims",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=brandon.sims@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteEricBranton,
      name: 'Job Complete Eric Branton',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Eric Branton",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=eric.branton@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTristanBilbo,
      name: 'Job Complete Tristan Bilbo',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Tristan Bilbo'",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=tristan.bilbo@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteGarrettstephens,
      name: 'Job Complete Garrett Stephens',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Garrett Stephens",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=garrett.stephens@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteMasonCoon,
      name: 'Job Complete Mason Coon',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Mason Coon",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=mason.coon@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBriceDrisdale,
      name: 'Job Complete Brice Drisdale',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Brice Drisdale",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=brice.drisdale@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteAdamKosel,
      name: 'Job Complete Adam Kosel',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Adam Kosel",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=adam.kosel@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteRossHenry,
      name: 'Job Complete Ross Henry',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Ross Henry",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=ross.henry@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteEricHarmon,
      name: 'Job Complete Eric Harmon',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Eric Harmons",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=eric.harmon@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompletePaulHill,
      name: 'Job Complete Paul Hill',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Paul Hill",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=paul.hill@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteBrysonSmith,
      name: 'Job Complete Brynson Smith',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Job Complete Brynson Smith",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=bryson.smith@rtatel.com");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: itSurveyOctober2021,
      name: 'IT Survey October 2021',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "IT Survey October 2021",
            source: "https://survey.rtatel.com/survey/dashboard_IT1.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Manager
    GoRoute(
      path: bolivarPeninsulaFibertotheHome,
      name: 'Bolivar Peninsula Fiber to the home',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Bolivar Peninsula Fiber to the home",
            source:
                "https://lookerstudio.google.com/embed/reporting/f07ca1f5-f6af-41d5-9574-3de27a67978b/page/UO1aC");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: operationReport,
      name: 'Operation Report',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Operation Report",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/weekly_operation_report  ");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: techJobTimeTracking,
      name: 'Tech Job Time Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Tech Job Time Tracking",
            source: "https://cblsrvr1.rtatel.com/dash/#/job_minutes");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobsTracking,
      name: 'Jobs Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Jobs Tracking",
            source: "https://cblsrvr1.rtatel.com/dashstats/jobTracking.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobsUtilizationTracking,
      name: 'Jobs Utilization Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Jobs Utilization Tracking",
            source:
                "https://cblsrvr1.rtatel.com/dashstats/jobTimeUtilization.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: ivrStats,
      name: 'IVR Stats',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "IVR Stats",
            source:
                "https://lookerstudio.google.com/embed/reporting/a5800463-5962-4ce2-8bf0-6265bc18ecc7/page/p_xiybj20oad");
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////GigFast Network
    GoRoute(
      path: monitoringDashboard,
      name: 'Monitoring Dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Monitoring Dashboard",
            source:
                "https://datastudio.google.com/embed/reporting/7a7ad430-e653-4b1f-ac1b-f7fe6934a805/page/zM2eC");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: mapCoverage,
      name: 'Map Coverage',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsRtatelPage(
            title: "Map Coverage", source: "https://dashboards.rtatel.com/");
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////Call Center
    GoRoute(
      path: ecommerceRTA,
      name: 'EcommerceRTA',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
            title: "EcommerceRTA",
            source:
                "https://ecom.rtatel.com/#/rep/?rep=${prefs.getString('email')}");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: homeownerFTTHDocument,
      name: 'homeownerFTTHDocument',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeOwnerFTTHDocument();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: homeownerFTTHDocumentList,
      name: 'homeownerFTTHDocumentList',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeOwnerFTTHDocumentList();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: homeownerFTTHDocumentClient,
      name: 'homeownerFTTHDocumentClient',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeOwnerFTTHDocumentClient();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////FMT
    GoRoute(
      path: fmt,
      name: 'FMT',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsCTRLVPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    ////////WOP
    GoRoute(
      path: wop,
      name: 'WOP',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsCRMPage();
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
