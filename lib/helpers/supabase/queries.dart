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

      final PostgrestFilterBuilder query =
          supabase.from('users').select().eq('user_profile_id', user.id);

      final res = await query;

      final userProfile = res[0];
      userProfile['id'] = user.id;
      userProfile['email'] = user.email!;

      final usuario = User.fromJson(jsonEncode(userProfile));

      return usuario;
    } catch (e) {
      log('Error en getCurrentUserData() - $e');
      return null;
    }
  }

  static Future<Configuration?> getDefaultTheme(int themeId) async {
    try {
      final res =
          await supabase.from('theme').select('light, dark').eq('id', themeId);

      return Configuration.fromJson(jsonEncode(res[0]));
    } catch (e) {
      log('Error en getDefaultTheme() - $e');
      return null;
    }
  }

  static Future<Configuration?> getUserTheme() async {
    try {
      if (currentUser == null) return null;
      final res = await supabase
          .from('users')
          .select('configuracion')
          .eq('id', currentUser!.id)
          .select();
      //print(res.toString());
      Configuration config =
          Configuration.fromJson(jsonEncode(res[0]['configuracion']));
      /* assets = await getLogos(config.logos.logoColor, config.logos.logoBlanco,
          config.logos.backgroundImage, config.logos.animationBackground); */
      return config;
    } catch (e) {
      log('Error en getUserTheme() - $e');
      return null;
    }
  }

  static Future<Assets> getLogos(
      logoColor, logoBlanco, backgroundImage, animationBackground) async {
    Map<String, String> assetMap = {
      'logoColor': 'assets/images/LogoColor.png',
      'logoBlanco': 'assets/images/LogoColor.png',
      'backgroundImage': 'assets/images/bg1.png',
      'animationBackground': 'assets/images/bg1.png',
    };
    try {
      //Logo Color
      if (logoColor != null) assetMap['logoColor'] = logoColor;
      //Logo Blanco
      if (logoBlanco != null) assetMap['logoBlanco'] = logoBlanco;
      //BG 1
      if (backgroundImage != null)
        assetMap['backgroundImage'] = backgroundImage;
      //BG Login
      if (animationBackground != null)
        assetMap['animationBackground'] = animationBackground;
      return Assets.fromMap(assetMap);
    } catch (e) {
      return Assets.fromMap(assetMap);
    }
  }

  static Future<Assets> getAssets() async {
    Map<String, String> assetMap = {
      'logoColor': 'assets/images/LogoColor.png',
      'logoBlanco': 'assets/images/LogoBlanco.png',
      'bg1': 'assets/images/bg1.png',
      'bgLogin': 'assets/images/bgLogin.png',
    };
    try {
      //Logo Color
      var res = supabase.storage.from('assets').getPublicUrl('LogoColor.png');
      if (res != null) assetMap['logoColor'] = res;
      //Logo Blanco
      res = supabase.storage.from('assets').getPublicUrl('LogoColor.png');
      if (res != null) assetMap['logoBlanco'] = res;
      //BG 1
      res = supabase.storage.from('assets').getPublicUrl('bg1.png');
      if (res != null) assetMap['bg1'] = res;
      //BG Login
      res = supabase.storage.from('assets').getPublicUrl('bgLogin.png');
      if (res != null) assetMap['bgLogin'] = res;

      return Assets.fromMap(assetMap);
    } catch (e) {
      return Assets.fromMap(assetMap);
    }
  }
}
