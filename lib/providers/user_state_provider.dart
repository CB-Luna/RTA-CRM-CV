import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

enum FormView { loginForm, selectAppForm, forgotPasswordForm, resetPasswordForm }

class UserState extends ChangeNotifier {
  //EMAIL
  String _email = '';

  String get email => _email;
  Future<void> setEmail() async {
    _email = emailController.text;
    await prefs.setString('email', emailController.text);
  }

  //Controlador para LoginScreen
  TextEditingController emailController = TextEditingController();

  //PASSWORD
  String _password = '';

  String get password => _password;
  Future<void> setPassword() async {
    _password = passwordController.text;
    await prefs.setString('password', passwordController.text);
  }

  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  //Variables para editar perfil
  TextEditingController nombrePerfil = TextEditingController();
  TextEditingController apellidosPerfil = TextEditingController();
  TextEditingController telefonoPerfil = TextEditingController();
  TextEditingController extensionPerfil = TextEditingController();
  TextEditingController emailPerfil = TextEditingController();
  TextEditingController contrasenaAnteriorPerfil = TextEditingController();
  TextEditingController confirmarContrasenaPerfil = TextEditingController();
  TextEditingController contrasenaPerfil = TextEditingController();

  String? imageName;
  Uint8List? webImage;

  FormView view = FormView.loginForm;

  //Constructor de provider
  UserState() {
    rememberMe = prefs.getBool('recuerdame') ?? false;

    if (rememberMe == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;
  }

  Future<bool> actualizarContrasena() async {
    try {
      final res = await supabase.rpc('change_user_password', params: {
        'current_plain_password': contrasenaAnteriorPerfil.text,
        'new_plain_password': contrasenaPerfil.text,
      });
      if (res == null) {
        log('Error en actualizarContrasena()');
        return false;
      }
      return true;
    } catch (e) {
      log('Error en actualizarContrasena() - $e');
      return false;
    }
  }

  void changeView(FormView view) {
    this.view = view;
    notifyListeners();
  }

  Future<void> sendResetPasswordEmail() async {
    try {
      await supabase.auth.resetPasswordForEmail(emailController.text);
    } catch (e) {
      log('Error in sendResetPasswordEmail() - $e');
    }
  }

  // void initPerfilUsuario() {
  //   if (currentUser == null) return;
  //   nombrePerfil.text = currentUser!.nombre;
  //   apellidosPerfil.text = currentUser!.apellidos;
  //   telefonoPerfil.text = currentUser!.telefono;
  //   extensionPerfil.text = currentUser!.ext ?? '';
  //   emailPerfil.text = currentUser!.email;
  //   imageName = currentUser!.imagen;
  //   webImage = null;
  //   contrasenaPerfil.clear();
  //   contrasenaAnteriorPerfil.clear();
  //   confirmarContrasenaPerfil.clear();
  // }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    final String fileExtension = p.extension(pickedImage.name);
    const uuid = Uuid();
    final String fileName = uuid.v1();
    imageName = 'avatar-$fileName$fileExtension';

    webImage = await pickedImage.readAsBytes();

    notifyListeners();
  }

  void clearImage() {
    webImage = null;
    imageName = null;
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (webImage != null && imageName != null) {
      await supabase.storage.from('avatars').uploadBinary(
            imageName!,
            webImage!,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
            ),
          );

      return imageName;
    }
    return null;
  }

  Future<bool> editarPerfilDeUsuario() async {
    try {
      await supabase.from('user_profile').update(
        {
          'nombre': nombrePerfil.text,
          'apellidos': apellidosPerfil.text,
          'telefono': telefonoPerfil.text,
          'imagen': imageName,
        },
      ).eq('user_profile_id', currentUser!.id);
      return true;
    } catch (e) {
      log('Error en editarPerfilDeUsuario() - $e');
      return false;
    }
  }

  Future<void> updateRememberMe() async {
    rememberMe = !rememberMe;
    await prefs.setBool('recuerdame', rememberMe);
    notifyListeners();
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    currentUser = null;
    await prefs.remove('currentPais');
    await prefs.remove('currentRol');
    router.pushReplacement('/login');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    nombrePerfil.dispose();
    emailPerfil.dispose();
    contrasenaPerfil.dispose();
    super.dispose();
  }
}
