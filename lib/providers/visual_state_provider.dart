import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/helpers/supabase/queries.dart';
import 'package:rta_crm_cv/models/configuration.dart';
import 'package:rta_crm_cv/models/modelo_pantalla/tema_descargado.dart';
import 'package:rta_crm_cv/models/user.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class VisualStateProvider extends ChangeNotifier {
  //THEME
  late Color primaryColorLight;
  late Color secondaryColorLight;
  late Color tertiaryColorLight;
  late Color primaryTextColorLight;
  late Color primaryBackgroundColorLight;

  late Color primaryColorDark;
  late Color secondaryColorDark;
  late Color tertiaryColorDark;
  late Color primaryTextColorDark;
  late Color primaryBackgroundColorDark;

  late TextEditingController primaryColorLightController;
  late TextEditingController secondaryColorLightController;
  late TextEditingController tertiaryColorLightController;
  late TextEditingController primaryTextLightController;
  late TextEditingController primaryBackgroundLightController;

  late TextEditingController primaryColorDarkController;
  late TextEditingController secondaryColorDarkController;
  late TextEditingController tertiaryColorDarkController;
  late TextEditingController primaryTextDarkController;
  late TextEditingController primaryBackgroundDarkController;

  //nombreTema
  TextEditingController nombreTema = TextEditingController();
  List<TemaDescargado> temas = [];
  TemaDescargado? temaSeleccionado;
  PlutoGridStateManager? stateManager;

  //IMAGENES
  Uint8List? logoColor;
  Uint8List? logoBlanco;
  Uint8List? bg1;
  Uint8List? bgLogin;
  Uint8List? background;
  Uint8List? background2;
  Uint8List? background3;
  Uint8List? background4;

  late int idtema;
  late String assetsname;

  Future<void> updateState() async {
   // await SupabaseQueries.getUserTheme();
    await descargarTemas();
    //await getUserTheme();
    //getCurrentConfiguration();
    // setColors();
    notifyListeners();
  }

  VisualStateProvider(BuildContext context) {
    final lightTheme = AppTheme.lightTheme;
    final darkTheme = AppTheme.darkTheme;

    primaryColorLight = lightTheme.primaryColor;
    secondaryColorLight = lightTheme.secondaryColor;
    tertiaryColorLight = lightTheme.tertiaryColor;
    primaryTextColorLight = lightTheme.primaryText;
    primaryBackgroundColorLight = lightTheme.primaryBackground;

    primaryColorDark = darkTheme.primaryColor;
    secondaryColorDark = darkTheme.secondaryColor;
    tertiaryColorDark = darkTheme.tertiaryColor;
    primaryTextColorDark = darkTheme.primaryText;
    primaryBackgroundColorDark = darkTheme.primaryBackground;

    primaryColorLightController = TextEditingController(
        text: primaryColorLight.value.toRadixString(16).toUpperCase());
    secondaryColorLightController = TextEditingController(
        text: secondaryColorLight.value.toRadixString(16).toUpperCase());
    tertiaryColorLightController = TextEditingController(
        text: tertiaryColorLight.value.toRadixString(16).toUpperCase());
    primaryTextLightController = TextEditingController(
        text: primaryTextColorLight.value.toRadixString(16).toUpperCase());
    primaryBackgroundLightController = TextEditingController(
        text:
            primaryBackgroundColorLight.value.toRadixString(16).toUpperCase());

    primaryColorDarkController = TextEditingController(
        text: primaryColorDark.value.toRadixString(16).toUpperCase());
    secondaryColorDarkController = TextEditingController(
        text: secondaryColorDark.value.toRadixString(16).toUpperCase());
    tertiaryColorDarkController = TextEditingController(
        text: tertiaryColorDark.value.toRadixString(16).toUpperCase());
    primaryTextDarkController = TextEditingController(
        text: primaryTextColorDark.value.toRadixString(16).toUpperCase());
    primaryBackgroundDarkController = TextEditingController(
        text: primaryBackgroundColorDark.value.toRadixString(16).toUpperCase());
  }

  /*  void setColors() {
    print(primaryColorLight);
    setPrimaryColorLight(primaryColorLight);
    setSecondaryColorLight(secondaryColorLight);
    setTerciaryColorLight(tertiaryColorLight);
    setPrimaryTextColorLight(primaryTextColorLight);
    setPrimaryBackgroundColorLight(primaryBackgroundColorLight);
    setPrimaryColorDark(primaryColorDark);
    setSecondaryColorDark(secondaryColorDark);
    setTerciaryColorDark(tertiaryColorDark);
    setPrimaryTextColorDark(primaryTextColorDark);
    setPrimaryBackgroundColorDark(primaryBackgroundColorDark);
  } */

  void setPrimaryColorLight(Color color) {
    primaryColorLight = color;
    primaryColorLightController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setSecondaryColorLight(Color color) {
    secondaryColorLight = color;
    secondaryColorLightController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setTerciaryColorLight(Color color) {
    tertiaryColorLight = color;
    tertiaryColorLightController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setPrimaryTextColorLight(Color color) {
    primaryTextColorLight = color;
    primaryTextLightController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setPrimaryBackgroundColorLight(Color color) {
    primaryBackgroundColorLight = color;
    primaryBackgroundLightController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setPrimaryColorDark(Color color) {
    primaryColorDark = color;
    primaryColorDarkController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setSecondaryColorDark(Color color) {
    secondaryColorDark = color;
    secondaryColorDarkController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setTerciaryColorDark(Color color) {
    tertiaryColorDark = color;
    tertiaryColorDarkController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setPrimaryTextColorDark(Color color) {
    primaryTextColorDark = color;
    primaryTextDarkController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  void setPrimaryBackgroundColorDark(Color color) {
    primaryBackgroundColorDark = color;
    primaryBackgroundDarkController.text =
        color.value.toRadixString(16).toUpperCase();
    notifyListeners();
  }

  Configuration getCurrentConfiguration() {
    final Mode light = Mode(
      primaryColor: int.parse(primaryColorLightController.text, radix: 16),
      secondaryColor: int.parse(secondaryColorLightController.text, radix: 16),
      tertiaryColor: int.parse(tertiaryColorLightController.text, radix: 16),
      primaryText: int.parse(primaryTextLightController.text, radix: 16),
      primaryBackground:
          int.parse(primaryBackgroundLightController.text, radix: 16),
    );

    final Mode dark = Mode(
      primaryColor: int.parse(primaryColorDarkController.text, radix: 16),
      secondaryColor: int.parse(secondaryColorDarkController.text, radix: 16),
      tertiaryColor: int.parse(tertiaryColorDarkController.text, radix: 16),
      primaryText: int.parse(primaryTextDarkController.text, radix: 16),
      primaryBackground:
          int.parse(primaryBackgroundDarkController.text, radix: 16),
    );
    final Logos logo = Logos(
        logoColor: logoColor.toString(),
        logoBlanco: logoBlanco.toString(),
        backgroundImage: bg1.toString(),
        animationBackground: bgLogin.toString());
    final Carrusel carrusel = Carrusel(
        background: background.toString(),
        background2: background2.toString(),
        background3: background3.toString(),
        background4: background4.toString());

    return Configuration(
        light: light, dark: dark, logos: logo, carrusel: carrusel);
  }

//Actualizar tema por usuario
  Future<bool> actualizarTema({Configuration? tema}) async {
    /* late final Configuration conf;

    if (tema != null) {
      conf = tema;
    } else {
      conf = getCurrentConfiguration();
    } */

    final res = await supabase
        .from('user_profile')
        .update({
          'id_tema_fk': idtema,
        })
        .eq('user_profile_id', currentUser!.id)
        .select();

    if (res == null) {
      log('Error en actualizarTemas()');
      return false;
    }
/* 
    primaryColorLightController.text = temas
        .first.configuracion.light.primaryColor
        .toRadixString(16)
        .toUpperCase();
    secondaryColorLightController.text = temas
        .first.configuracion.light.secondaryColor
        .toRadixString(16)
        .toUpperCase();
    tertiaryColorLightController.text = temas
        .first.configuracion.light.primaryColor
        .toRadixString(16)
        .toUpperCase();
    primaryTextLightController.text = temas
        .first.configuracion.light.primaryText
        .toRadixString(16)
        .toUpperCase();
    primaryBackgroundLightController.text = temas
        .first.configuracion.light.primaryBackground
        .toRadixString(16)
        .toUpperCase();

    primaryColorDarkController.text = temas
        .first.configuracion.dark.primaryColor
        .toRadixString(16)
        .toUpperCase();
    secondaryColorDarkController.text = temas
        .first.configuracion.dark.secondaryColor
        .toRadixString(16)
        .toUpperCase();
    tertiaryColorDarkController.text = temas
        .first.configuracion.dark.primaryColor
        .toRadixString(16)
        .toUpperCase();
    primaryTextDarkController.text = temas.first.configuracion.dark.primaryText
        .toRadixString(16)
        .toUpperCase();
    primaryBackgroundDarkController.text = temas
        .first.configuracion.dark.primaryBackground
        .toRadixString(16)
        .toUpperCase();

    AppTheme.initConfiguration(conf);
    updateState();
 */
    var config = await SupabaseQueries.getUserTheme();
    AppTheme.initConfiguration(config);
    notifyListeners();
    return true;
  }

  //crear nuevo tema en la base de datos
  Future<bool> creatTema() async {
    try {
      final conf = getCurrentConfiguration();

      final res = await supabase.from('temas').insert({
        'nombre_tema': nombreTema.text,
        'configuracion': conf.toMap(),
      }).select();

      if (res == null) {
        log('Error en Crear()');
        return false;
      }

      return true;
    } catch (e) {
      log('Error en Crear() - $e');
      return false;
    }
  }

//seleccionar el tema de la base de datos
  Future<void> descargarTemas() async {
    try {
      final res = await supabase.from('temas').select();

      if (res == null) {
        log('Error en descargarTemas()');
        return;
      }

      temas = (res as List<dynamic>)
          .map((usuario) => TemaDescargado.fromJson(jsonEncode(usuario)))
          .toList();
      notifyListeners();
      return;
    } catch (e) {
      log('Error en descargarTemas() - $e');
      return;
    }
  }

  void setTemaSeleccionado(TemaDescargado tema) {
    temaSeleccionado = tema;
    notifyListeners();
  }

  Future<void> selectImage(String assetName) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    final String fileExtension = p.extension(pickedImage.name).toLowerCase();
    if (fileExtension != '.png') {
      ApiErrorHandler.callToast('Solo se pueden subir imágenes en formato PNG');
      return;
    }

    switch (assetName) {
      case 'logoColor':
        logoColor = await pickedImage.readAsBytes();
        break;
      case 'logoBlanco':
        logoBlanco = await pickedImage.readAsBytes();
        break;
      case 'bg1':
        bg1 = await pickedImage.readAsBytes();
        break;
      case 'bgLogin':
        bgLogin = await pickedImage.readAsBytes();
        break;
      case 'background':
        background = await pickedImage.readAsBytes();
        break;
      case 'background2':
        background2 = await pickedImage.readAsBytes();
        break;
      case 'background3':
        background3 = await pickedImage.readAsBytes();
        break;
      case 'background4':
        background4 = await pickedImage.readAsBytes();
        break;
      default:
        return;
    }

    notifyListeners();
  }

  Uint8List? getImageData(String assetName) {
    switch (assetName) {
      case 'logoColor':
        return logoColor;
      case 'logoBlanco':
        return logoBlanco;
      case 'bg1':
        return bg1;
      case 'bgLogin':
        return bgLogin;
      case 'background':
        return background;
      case 'background2':
        return background2;
      case 'background3':
        return background3;
      case 'background4':
        return background4;
      default:
        return null;
    }
  }

  Future<bool> actualizarImagenes(int tema) async {
    switch (tema) {
      case 1:
        assetsname = 'RTA_tema/';
        break;
      case 2:
        assetsname = 'cbluna_tema/';
    }
    if (logoColor != null) {
      await supabase.storage.from('assets').updateBinary(
            '${assetsname}LogoColor.png',
            logoColor!,
          );
    }
    if (logoBlanco != null) {
      await supabase.storage.from('assets').updateBinary(
            '${assetsname}LogoBlanco.png',
            logoColor!,
          );
    }
    notifyListeners();
    return true;
  }

  Future<bool> actualizarImagenesLogIn(int tema) async {
    switch (tema) {
      case 1:
        assetsname = 'RTA_tema/';
        break;
      case 2:
        assetsname = 'cbluna_tema/';
    }
    if (background != null) {
      await supabase.storage.from('assets').updateBinary(
            '${assetsname}background.png',
            background!,
          );
    }
    if (background2 != null) {
      await supabase.storage.from('assets').updateBinary(
            '${assetsname}background2.png',
            background2!,
          );
    }
    if (background3 != null) {
      await supabase.storage.from('assets').updateBinary(
            '${assetsname}background3.png',
            background3!,
          );
    }
    if (background4 != null) {
      await supabase.storage.from('assets').updateBinary(
            '${assetsname}background4.png',
            background4!,
          );
    }
    notifyListeners();
    return true;
  }

  /* static Future<User?> getCurrentUserData() async {
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
  } */

  Future<Configuration?> getUserTheme() async {
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
      primaryColorLightController.text =
          config.light.primaryColor.toRadixString(16).toUpperCase();
      secondaryColorLightController.text =
          config.light.secondaryColor.toRadixString(16).toUpperCase();
      tertiaryColorLightController.text =
          config.light.primaryColor.toRadixString(16).toUpperCase();
      primaryTextLightController.text =
          config.light.primaryText.toRadixString(16).toUpperCase();
      primaryBackgroundLightController.text =
          config.light.primaryBackground.toRadixString(16).toUpperCase();

      primaryColorDarkController.text =
          config.dark.primaryColor.toRadixString(16).toUpperCase();
      secondaryColorDarkController.text =
          config.dark.secondaryColor.toRadixString(16).toUpperCase();
      tertiaryColorDarkController.text =
          config.dark.primaryColor.toRadixString(16).toUpperCase();
      primaryTextDarkController.text =
          config.dark.primaryText.toRadixString(16).toUpperCase();
      primaryBackgroundDarkController.text =
          config.dark.primaryBackground.toRadixString(16).toUpperCase();

      return config;
    } catch (e) {
      log('Error en getUserTheme() - $e');
      return null;
    }
  }

  @override
  void dispose() {
    primaryColorLightController.dispose();
    secondaryColorLightController.dispose();
    tertiaryColorLightController.dispose();
    primaryTextLightController.dispose();
    primaryBackgroundLightController.dispose();
    primaryColorDarkController.dispose();
    secondaryColorDarkController.dispose();
    tertiaryColorDarkController.dispose();
    primaryTextDarkController.dispose();
    primaryBackgroundDarkController.dispose();
    super.dispose();
  }
}
