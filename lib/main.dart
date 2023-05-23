import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/providers/users_providers/add_users_provider.dart';
import 'package:rta_crm_cv/providers/users_providers/users_provider.dart';
import 'package:rta_crm_cv/providers/visual_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/router/router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
  );

  await initGlobals();

  // Configuration? conf = await SupabaseQueries.getUserTheme();

  //obtener tema
  // AppTheme.initConfiguration(conf);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (context) => SideMenuProvider(context),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddUsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VisualStateProvider(context),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('es');
  ThemeMode _themeMode = AppTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        AppTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp.router(
        title: 'RTA CRM',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: const [Locale('en', 'US')],
        theme: ThemeData(
          brightness: Brightness.light,
          dividerColor: Colors.grey,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: AppTheme.of(context).primaryColor),
            hintStyle: TextStyle(color: AppTheme.of(context).primaryColor),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          dividerColor: Colors.grey,
        ),
        themeMode: _themeMode,
        routerConfig: router,
      ),
    );
  }
}