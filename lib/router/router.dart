import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/accounts_page.dart';
import 'package:rta_crm_cv/pages/config_page/config_page.dart';
import 'package:rta_crm_cv/pages/dashboards_page.dart';
import 'package:rta_crm_cv/pages/monitory_page/monitory_page.dart';
//import 'package:rta_crm_cv/pages/network_page.dart';
import 'package:rta_crm_cv/pages/pages.dart';
import 'package:rta_crm_cv/pages/reports_page.dart';
import 'package:rta_crm_cv/pages/schedulings_page.dart';
import 'package:rta_crm_cv/pages/tickets_page.dart';
import 'package:rta_crm_cv/pages/users/users_page.dart';
import 'package:rta_crm_cv/services/navigation_service.dart';

import '../pages/employees_page/employees_page.dart';
import '../pages/inventory_page/inventory_page.dart';

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
        return const DashboardsPage();
      },
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: const DashboardsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
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
        return const EmployeesPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const EmployeesPage()),
    ),
    GoRoute(
      path: '/accounts',
      name: 'Accounts',
      builder: (BuildContext context, GoRouterState state) {
        return MonitoryPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, MonitoryPage()),
    ),
    GoRoute(
      path: '/schedulings',
      name: 'Schedulings',
      builder: (BuildContext context, GoRouterState state) {
        return InventoryPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, InventoryPage()),
    ),
    GoRoute(
      path: '/network',
      name: 'Network',
      builder: (BuildContext context, GoRouterState state) {
        return DashboardsPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, DashboardsPage()),
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
      path: '/inventory',
      name: 'Inventory',
      builder: (BuildContext context, GoRouterState state) {
        return InventoryPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, InventoryPage()),
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
      path: '/employees',
      name: 'Employees',
      builder: (BuildContext context, GoRouterState state) {
        return const EmployeesPage();
      },
      pageBuilder: (context, state) =>
          pageTransition(context, state, const EmployeesPage()),
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
