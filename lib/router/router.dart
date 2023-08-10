import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rta_crm_cv/pages/crm/campaigns/campaigns_page.dart';
import 'package:rta_crm_cv/pages/crm/reports_page.dart';
import 'package:rta_crm_cv/pages/crm/schedulings_page.dart';
import 'package:rta_crm_cv/pages/crm/tickets_page.dart';
import 'package:rta_crm_cv/pages/ctrlv/dashboard/dashboards_page_ctrlv.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/inventory_page_desktop.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/service_pop_up.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/monitory_page.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/monitory_page_desktop.dart';
import 'package:rta_crm_cv/pages/pages.dart';

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/quotes/create_quote.dart';
import 'package:rta_crm_cv/pages/crm/quotes/detail_quote.dart';
import 'package:rta_crm_cv/pages/crm/quotes/quotes_page.dart';
import 'package:rta_crm_cv/pages/crm/quotes/validate_quote.dart';
import 'package:rta_crm_cv/services/navigation_service.dart';

import '../models/vehicle.dart';
import '../pages/ctrlv/inventory_page/inventory_page.dart';
import '../pages/ctrlv/inventory_page/pop_up/details_pop_up.dart';
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
        } else if (currentUser!.isCV) {
          return const MonitoryPageDesktop();
        } else {
          return const PageNotFoundPage();
        }
      },
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: currentUser!.isCRM
            ? const QuotesPage()
            : currentUser!.isCV
                ? const MonitoryPageDesktop()
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
        return ReportedIssues();
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
