import 'dart:convert';
import 'dart:developer';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class SupabaseQueries {
  static Future<User?> getCurrentUserData() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final PostgrestFilterBuilder query = supabase.from('users').select().eq('user_profile_id', user.id);

      final res = await query;

      final userProfile = res[0];
      userProfile['id'] = user.id;
      userProfile['email'] = user.email!;

      final usuario = User.fromMap(userProfile);

      return usuario;
    } catch (e) {
      log('Error aqui');
      log('Error en getCurrentUserData() - $e');
      return null;
    }
  }

  static Future<Configuration?> getDefaultTheme(int themeId) async {
    try {
      final res = await supabase.from('theme').select('light, dark').eq('id', themeId);

      return Configuration.fromJson(jsonEncode(res[0]));
    } catch (e) {
      log('Error en getDefaultTheme() - $e');
      return null;
    }
  }

  static Future<Configuration?> getUserTheme() async {
    try {
      if (currentUser == null) return null;
      final res = await supabase.from('users').select('configuracion').eq('id', currentUser!.id).select();
      //print(res.toString());
      Configuration config = Configuration.fromJson(jsonEncode(res[0]['configuracion']));

      return config;
    } catch (e) {
      log('Error en getUserTheme() - $e');
      return null;
    }
  }

  static Future<Assets> getAssets() async {
    Map<String, String> assetMap = {
      'logoColor': 'assets/images/LogoColor.png',
      'logoBlanco': 'assets/images/LogoBlanco.png',
      'bg1': 'assets/images/bg1.png',
      'bgLogin': 'assets/images/bgLogin.png',
      'avatar': 'assets/images/avatar.png',
      'background': 'assets/images/background.png',
      'background2': 'assets/images/background2.png',
      'background3': 'assets/images/background3.png',
      'background4': 'assets/images/background4.png',
    };
    try {
      //Logo Color
      var res = supabase.storage.from('assets').getPublicUrl('LogoColor.png');
      assetMap['logoColor'] = res;
      //Logo Blanco
      res = supabase.storage.from('assets').getPublicUrl('LogoColor.png');
      assetMap['logoBlanco'] = res;
      //BG 1
      res = supabase.storage.from('assets').getPublicUrl('bg1.png');
      assetMap['bg1'] = res;
      //BG Login
      res = supabase.storage.from('assets').getPublicUrl('bgLogin.png');
      assetMap['bgLogin'] = res;
      //avatar
      res = supabase.storage.from('assets').getPublicUrl('avatar.png');
      assetMap['avatar'] = res;
      //background
      res = supabase.storage.from('assets').getPublicUrl('background.png');
      assetMap['background'] = res;
      //background2
      res = supabase.storage.from('assets').getPublicUrl('background2.png');
      assetMap['background2'] = res;
      //background3
      res = supabase.storage.from('assets').getPublicUrl('background3.png');
      assetMap['background3'] = res;
      //background4
      res = supabase.storage.from('assets').getPublicUrl('background4.png');
      assetMap['background4'] = res;

      return Assets.fromMap(assetMap);
    } catch (e) {
      return Assets.fromMap(assetMap);
    }
  }
}
