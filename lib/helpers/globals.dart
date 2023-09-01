import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rta_crm_cv/helpers/supabase/queries.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import 'package:rta_crm_cv/models/models.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage();

late SupabaseClient supabaseCRM;
late SupabaseClient supabaseCtrlV;
late SupabaseClient supabaseAuth;
late SupabaseClient supabasePublic;

String key =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAic2VydmljZV9yb2xlIiwKICAgICJpc3MiOiAic3VwYWJhc2UiLAogICAgImlhdCI6IDE2ODQ4MjUyMDAsCiAgICAiZXhwIjogMTg0MjY3ODAwMAp9.gAA9u40KP0uFMjACjoUF1zMPpnxbrkUYCGP_ovgl9Io';

final supabase = Supabase.instance.client;
late SupabaseClient supabaseCRMJuan;

late final SharedPreferences prefs;

late final Assets assets;

User? currentUser;

Future<void> initGlobals() async {
  prefs = await SharedPreferences.getInstance();

  assets = await SupabaseQueries.getAssets();

  currentUser = await SupabaseQueries.getCurrentUserData();
  if (currentUser == null) return;
  Configuration? config = await SupabaseQueries.getUserTheme();
  if (config == null) return;
  assets.logoBlanco = config.logos.logoBlanco;
  assets.logoColor = config.logos.logoColor;
  assets.background = config.carrusel.background;
  assets.background2 = config.carrusel.background2;
  assets.background3 = config.carrusel.background3;
  assets.background4 = config.carrusel.background4;
  AppTheme.initConfiguration(config);
}
