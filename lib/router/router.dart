import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/tokens.dart';
import 'package:rta_crm_cv/models/token.dart';

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
import 'package:rta_crm_cv/pages/jsa/jsa_document_list.dart';
import 'package:rta_crm_cv/pages/login_page/login_page.dart';
import 'package:rta_crm_cv/pages/pages.dart';

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/quotes/create_quote.dart';
import 'package:rta_crm_cv/pages/crm/quotes/detail_quote.dart';
import 'package:rta_crm_cv/pages/crm/quotes/quotes_page.dart';
import 'package:rta_crm_cv/pages/crm/quotes/validate_quote.dart';
import 'package:rta_crm_cv/providers/users_provider.dart';
import 'package:rta_crm_cv/services/navigation_service.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/homeowner_ftth_document/homeowner_ftth_document_client.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/homeowner_ftth_document/homeowner_ftth_document_list.dart';

import '../pages/ctrlv/inventory_page/pop_up/reported_issues_pop_up.dart';
import '../pages/dashboards_rtatel/config_page_dashboard.dart';
import '../pages/dashboards_rtatel/migrations/bolivar_peninsula_page_desktop.dart';
import '../pages/dashboards_rtatel/migrations/job_complete_technicians_page_desktop.dart';
import '../pages/dashboards_rtatel/migrations/monitoring_dashboards/monitoring_dashboard_page_desktop.dart';
import '../pages/jsa/jsa_dashboards.dart';
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

    if (state.location.contains(homeownerFTTHDocumentClient)) return null;

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
          if (currentUser!.isDashboardsRTATEL) {
            if (currentUser!.isDashboardsFinancial1 ||
                currentUser!.isDashboardsFinancial2 ||
                currentUser!.isDashboardsFinancial3 ||
                currentUser!.isDashboardsOperation1 ||
                currentUser!.isDashboardsSupervisor1 ||
                currentUser!.isDashboardsSupervisor2 ||
                currentUser!.isDashboardsBank1) {
              return DashboardsRtatelPage(
                  title: "Bolivar Peninsula Fiber to the home",
                  source:
                      "https://lookerstudio.google.com/embed/u/0/reporting/8661d186-8edb-45ee-b2ab-0fd8acc1d0e5/page/UO1aC");
            } else if (currentUser!.isDashboardsOperation2 ||
                currentUser!.isDashboardsBank2) {
              return DashboardsRtatelPage(
                  title: "Monitoring Dashboard",
                  source:
                      "https://lookerstudio.google.com/embed/reporting/7a7ad430-e653-4b1f-ac1b-f7fe6934a805/page/zM2eC");
            } else if (currentUser!.isDashboardsBank3) {
              return DashboardsRtatelPage(
                  title: "Wizpapalooza 2021 Survey",
                  source:
                      "https://survey.rtatel.com/survey/dashboard_wispapalooza2021.html");
            } else if (currentUser!.isDashboardsCareRep) {
              return DashboardsRtatelPage(
                  title: "EcommerceRTA",
                  source:
                      "https://ecom.rtatel.com/#/rep/?rep=rtanumbers@gmail.com");
            } else if (currentUser!.isDashboardsInstaller) {
              return DashboardsRtatelPage(
                  title: currentUser!.name + currentUser!.lastName,
                  source:
                      "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=${currentUser!.email}");
            } else {
              return DashboardsRtatelPage(
                  title: "OpCo Suscriber Targets",
                  source: "https://cblsrvr1.rtatel.com/dash/#/business_plan");
            }
          } else if (currentUser!.isCRM) {
            return const QuotesPage();
          } else if (currentUser!.isAdminCv || currentUser!.isManager) {
            return const MonitoryPageDesktop();
          } else if (currentUser!.isEmployee) {
            return const DownloadAPKPage();
          } else if (currentUser!.isAdminJSA) {
            return const JSADashboards();
          } else if (currentUser!.isEmployeeJSA) {
            return const JSADashboards();
          } else {
            return const PageNotFoundPage();
          }
        },
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: currentUser!.isAdminDashboards
                ? DashboardsRtatelPage(
                    title: "Bolivar Peninsula Fiber to the home",
                    source:
                        "https://lookerstudio.google.com/embed/u/0/reporting/8661d186-8edb-45ee-b2ab-0fd8acc1d0e5/page/UO1aC")
                : currentUser!.isDashboardsFinancial1 ||
                        currentUser!.isDashboardsFinancial2 ||
                        currentUser!.isDashboardsFinancial3 ||
                        currentUser!.isDashboardsOperation1 ||
                        currentUser!.isDashboardsSupervisor1 ||
                        currentUser!.isDashboardsSupervisor2 ||
                        currentUser!.isDashboardsBank1
                    ? DashboardsRtatelPage(
                        title: "Bolivar Peninsula Fiber to the home",
                        source:
                            "https://lookerstudio.google.com/embed/u/0/reporting/8661d186-8edb-45ee-b2ab-0fd8acc1d0e5/page/UO1aC")
                    : currentUser!.isDashboardsOperation2 ||
                            currentUser!.isDashboardsBank2
                        ? DashboardsRtatelPage(
                            title: "Monitoring Dashboard",
                            source:
                                "https://lookerstudio.google.com/embed/reporting/7a7ad430-e653-4b1f-ac1b-f7fe6934a805/page/zM2eC")
                        : currentUser!.isDashboardsBank3
                            ? DashboardsRtatelPage(
                                title: "Wizpapalooza 2021 Survey",
                                source:
                                    "https://survey.rtatel.com/survey/dashboard_wispapalooza2021.html")
                            : currentUser!.isDashboardsCareRep
                                ? DashboardsRtatelPage(
                                    title: "EcommerceRTA",
                                    source:
                                        "https://ecom.rtatel.com/#/rep/?rep=rtanumbers@gmail.com")
                                : currentUser!.isDashboardsInstaller
                                    ? DashboardsRtatelPage(
                                        title: currentUser!.name +
                                            currentUser!.lastName,
                                        source:
                                            "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=${currentUser!.email}")
                                    : currentUser!.isCRM
                                        ? const QuotesPage()
                                        : currentUser!.isAdminCv ||
                                                currentUser!.isManager ||
                                                currentUser!.isTechSupervisor
                                            // Aqui toma el techsupervisor cuando se supone que no
                                            ? const MonitoryPageDesktop()
                                            : currentUser!.isEmployee
                                                ? const DownloadAPKPage()
                                                : currentUser!.isAdminJSA
                                                    ? const JSADashboards()
                                                    : currentUser!.isEmployeeJSA
                                                        ? const JSADashboards()
                                                        : const PageNotFoundPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        }),
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
    GoRoute(
      path: routeJobCompleteTechni,
      name: 'Job complete Technicianss',
      builder: (BuildContext context, GoRouterState state) {
        return const JobCompleteTechniciansPage();
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: routemaintenanceDashboard,
      name: 'Maintenance Dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const ConfigPageDashboard();
      },
      // (context, state, const DetailsPopUp()),
    ),

    //////// JSA
    GoRoute(
      path: routeJSADochument,
      name: 'JSA Document',
      builder: (BuildContext context, GoRouterState state) {
        return const JSADocumentList();
      },
      // (context, state, const DetailsPopUp()),
    ),

    GoRoute(
      path: routeJSADashboard,
      name: 'JSA Dashboards',
      builder: (BuildContext context, GoRouterState state) {
        return const JSADashboards();
      },
      // (context, state, const DetailsPopUp()),
    ),

    ////////Sales
    GoRoute(
      path: opcoSuscriberTarget,
      name: 'OpCo Suscriber Targets',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
            title: "OpCo Suscriber Targets",
            source: "https://cblsrvr1.rtatel.com/dash/#/business_plan",
            isjobcompletetech: false);
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: newSalesTrackingDashboard,
      name: 'New Sales Tracking Dashboards',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
            title: "New Sales Tracking Dashboards",
            source: "https://cblsrvr1.rtatel.com/dash/#/sales_tracking");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: monthlyChurn,
      name: 'Monthly Churn %',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
            title: "Configurator Stats",
            source: "https://cblsrvr1.rtatel.com/dash/#/configurator_stats");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: noCoverageLeads,
      name: 'No Coverage Leads',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
            title: "No Coverage Leads",
            source:
                "https://cblsrvr1.rtatel.com/dash/#/configurator/nocoverageleads");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: '/dashboard-page',
      name: 'dashboard_page',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser!.isDashboardsBank3) return const PageNotFoundPage();
        final String? source = state.queryParameters['source'];
        if (source == null) return const PageNotFoundPage();
        final String? title = state.queryParameters['title'];
        if (title == null) return const PageNotFoundPage();
        return DashboardsRtatelPage(
          title: title,
          source: "https://cblsrvr1.rtatel.com/dash/#$source",
        );
      },
    ),
    GoRoute(
      path: newConfiguratorStats,
      name: 'New Configurator Stats',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
            title: "Residentials and Business Customers",
            source: "https://cblsrvr1.rtatel.com/dash/#/customers_tracking");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: wirelessAndFiberCustomer,
      name: 'Wireless and Fiber Customers',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
            title: "Job Completed Service Overall",
            source: "https://techsurvey.rtatel.com/survey/dash/jobcomplete");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteCRY,
      name: 'Job Complete CRY',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
            title: "Job Complete SMI",
            source:
                "https://survey.rtatel.com/survey/dash/jobcomplete/bm?comp=SMI");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobCompleteTechnicians,
      name: 'Job Complete Technicians',
      builder: (BuildContext context, GoRouterState state) {
        late String email = currentUser!.email;
        UsersProvider provider = Provider.of<UsersProvider>(context);

        if (provider.userSelected?.email == null) {
          email = currentUser!.email;
        } else {
          email = provider.userSelected!.email;
        }
        return DashboardsRtatelPage(
          title: "Job Complete Technicians",
          // source: "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=",
          source:
              "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=${email}",
          searchVisibility: true,
          isjobcompletetech: true,
        );
      },
      // (context, state, const DetailsPopUp()),
    ),
    // GoRoute(
    //   path: jobCompleteTech,
    //   name: 'Job Complete Techni',
    //   builder: (BuildContext context, GoRouterState state) {
    //     String email = currentUser!.email;
    //     UsersProvider provider = Provider.of<UsersProvider>(context);

    //     if (provider.userSelected?.email == null) {
    //       email = currentUser!.email;
    //     } else {
    //       email = provider.userSelected!.email;
    //     }

    //     return DashboardsRtatelPage(
    //       title: "Job Complete Technicians",
    //       // source: "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=",
    //       source:
    //           "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=${email}",
    //       searchVisibility: true,
    //       isjobcompletetech: true,
    //     );
    //   },
    //   // (context, state, const DetailsPopUp()),
    // ),

    GoRoute(
      path: itSurveyOctober2021,
      name: 'IT Survey October 2021',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        // return const BolivarPeninsulaPageDeskop();
        return DashboardsRtatelPage(
            title: "Bolivar Peninsula Fiber to the home",
            source:
                "https://lookerstudio.google.com/embed/u/0/reporting/8661d186-8edb-45ee-b2ab-0fd8acc1d0e5/page/UO1aC");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: operationReport,
      name: 'Operation Report',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
            title: "Tech Job Time Tracking",
            source: "https://cblsrvr1.rtatel.com/dash/#/job_minutes");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobsTracking,
      name: 'Jobs Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
            title: "Jobs Tracking",
            source: "https://cblsrvr1.rtatel.com/dashstats/jobTracking.html");
      },
      // (context, state, const DetailsPopUp()),
    ),
    GoRoute(
      path: jobsUtilizationTracking,
      name: 'Jobs Utilization Tracking',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        // return MonitoringDashboardPageDesktop();
        return DashboardsRtatelPage(
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
        return DashboardsRtatelPage(
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
        final String? tokenString = state.queryParameters['token'];
        if (tokenString == null) return const PageNotFoundPage();
        final Token? token = parseToken(tokenString);
        if (token == null) return const PageNotFoundPage();
        return HomeOwnerFTTHDocumentClient(token: token);
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
