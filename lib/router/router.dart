import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/pages.dart';
import 'package:rta_crm_cv/services/navigation_service.dart';

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
        if (currentUser == null) {
          return const PageNotFoundPage();
        }
        return const HomePage();
      },
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
  ],
);
