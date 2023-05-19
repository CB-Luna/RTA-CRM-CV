import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rta_crm_cv/pages/404.dart';
import 'package:rta_crm_cv/pages/dashboards_page.dart';
import 'package:rta_crm_cv/pages/accounts_page.dart';
import 'package:rta_crm_cv/pages/inventory_page.dart';
import 'package:rta_crm_cv/pages/network_page.dart';
import 'package:rta_crm_cv/pages/reports_page.dart';
import 'package:rta_crm_cv/pages/schedulings_page.dart';
import 'package:rta_crm_cv/pages/tickets_page.dart';
import 'package:rta_crm_cv/pages/users_page.dart';
import 'package:rta_crm_cv/router/navigation_service.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/dashboards',
  redirect: (BuildContext context, GoRouterState state) {
    /*  final bool loggedIn = currentUser != null;
    final bool isLoggingIn = state.location == '/login';

    if (state.location.contains('AD')) return null;

    if (state.location == '/seleccion-rol-pais') return null;

    if (state.location == '/cambio-contrasena') return null;

    //If user is not logged in and not in the login page
    if (!loggedIn && !isLoggingIn) return '/login';

    //if user is logged in and in the login page
    if (loggedIn && isLoggingIn) return '/';*/

    return null;
  },
  errorBuilder: (context, state) => const PageNotFound(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'root',
      builder: (BuildContext context, GoRouterState state) {
        /* if (!currentUser!.cambioContrasena) {
          return const CambioContrasenaPage();
        } */
        //caso proveedor
        /* if (currentUser!.esProveedor) {
          final SeguimientoProveedoresProvider provider = Provider.of<SeguimientoProveedoresProvider>(
            context,
            listen: false,
          );
          provider.initProveedor();
          return const SeguimientoProveedoresPage();
        } else if (currentUser!.esValidador) {
          return const ValidacionNCPage();
        } else if (currentUser!.esTesorero) {
          return const GestorPartidasPull();
        } else if (currentUser!.esRegistroCentralizado) {
          return const NotificacionesPage();
        } else if (currentUser!.esOnboarding) {
          final SeguimientoProveedoresProvider provider = Provider.of<SeguimientoProveedoresProvider>(
            context,
            listen: false,
          );
          provider.initProveedor();
          return const OnboardingCosulta();
        }
        if (currentUser!.currentRol.permisos.home == null) {
          return const PageNotFoundPage();
        } */
        return const DashboardsPage();
      },
    ),
    GoRoute(
      path: '/dashboards',
      name: 'Dashboards',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardsPage();
      },
    ),
    GoRoute(
      path: '/accounts',
      name: 'Accounts',
      builder: (BuildContext context, GoRouterState state) {
        return const AccountsPage();
      },
    ),
    GoRoute(
      path: '/schedulings',
      name: 'Schedulings',
      builder: (BuildContext context, GoRouterState state) {
        return const SchedulingsPage();
      },
    ),
    GoRoute(
      path: '/network',
      name: 'Network',
      builder: (BuildContext context, GoRouterState state) {
        return const NetworkPage();
      },
    ),
    GoRoute(
      path: '/tickets',
      name: 'Tickets',
      builder: (BuildContext context, GoRouterState state) {
        return const TicketsPage();
      },
    ),
    GoRoute(
      path: '/inventory',
      name: 'Inventory',
      builder: (BuildContext context, GoRouterState state) {
        return const InventoryPage();
      },
    ),
    GoRoute(
      path: '/reports',
      name: 'Reports',
      builder: (BuildContext context, GoRouterState state) {
        return const ReportsPage();
      },
    ),
    GoRoute(
      path: '/users',
      name: 'Users',
      builder: (BuildContext context, GoRouterState state) {
        return const UsersPage();
      },
    ),
  ],
);
