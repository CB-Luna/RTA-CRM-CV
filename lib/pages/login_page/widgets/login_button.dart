import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/helpers/supabase/queries.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key? key,
    required this.buttonColor,
    required this.formKey,
  }) : super(key: key);

  final Color buttonColor;
  final GlobalKey<FormState> formKey;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late Color buttonColor;

  @override
  void initState() {
    buttonColor = widget.buttonColor;
    super.initState();
  }

  Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return MouseRegion(
      onEnter: (event) {
        buttonColor = lighten(buttonColor, 10);
        setState(() {});
      },
      onExit: (event) {
        buttonColor = AppTheme.of(context).primaryColor;
        setState(() {});
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (!widget.formKey.currentState!.validate()) {
            return;
          }

          //Login
          try {
            await supabase.auth.signInWithPassword(
              email: userState.emailController.text,
              password: userState.passwordController.text,
            );

            if (userState.rememberMe == true) {
              await userState.setEmail();
              await userState.setPassword();
            } else {
              userState.emailController.text = '';
              userState.passwordController.text = '';
              await prefs.remove('email');
              await prefs.remove('password');
            }

            if (supabase.auth.currentUser == null) {
              await ApiErrorHandler.callToast();
              return;
            }

            currentUser = await SupabaseQueries.getCurrentUserData();

            if (currentUser == null) {
              await ApiErrorHandler.callToast();
              return;
            }

            print(currentUser!.name);

            //   if (!mounted) return;

            //   // AppTheme.initConfiguration(
            //   //   await SupabaseQueries.getUserTheme(),
            //   // );

            //   // if (!mounted) return;

            if (!mounted) return;
            context.pushReplacement('/dashboards');
          } catch (e) {
            if (e is AuthException) {
              await ApiErrorHandler.callToast('Credenciales inválidas');
              return;
            }
            log('Error al iniciar sesion - $e');
          }
        },
        child: Container(
          height: 41,
          width: double.infinity,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(7.75),
          ),
          child: Center(
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.6,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
