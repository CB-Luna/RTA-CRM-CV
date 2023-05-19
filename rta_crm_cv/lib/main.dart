import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/internationalization/internationalization.dart';
import 'package:rta_crm_cv/router/router.dart';
import 'package:rta_crm_cv/side_menu_provider.dart';
import 'package:rta_crm_cv/widgets/horizontalscroll.dart';

void main() {
  runApp(
    Material(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SideMenuProvider(context),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('es');
  /* ThemeMode _themeMode = AppTheme.themeMode; */

  void setLocale(Locale value) => setState(() => _locale = value);
  /*  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        AppTheme.saveThemeMode(mode);
      }); */

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp.router(
        title: 'Arux',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
        theme: ThemeData(
          brightness: Brightness.light,
          dividerColor: Colors.grey,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          dividerColor: Colors.grey,
        ),
        //themeMode: _themeMode,
        routerConfig: router,
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}
