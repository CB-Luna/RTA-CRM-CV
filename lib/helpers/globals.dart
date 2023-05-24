import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rta_crm_cv/helpers/supabase/queries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import 'package:rta_crm_cv/models/models.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage();

final supabase = Supabase.instance.client;

late final SharedPreferences prefs;

late final Assets assets;

User? currentUser;

Future<void> initGlobals() async {
  prefs = await SharedPreferences.getInstance();

  assets = await SupabaseQueries.getAssets();

  currentUser = await SupabaseQueries.getCurrentUserData();

  if (currentUser == null) return;
}
