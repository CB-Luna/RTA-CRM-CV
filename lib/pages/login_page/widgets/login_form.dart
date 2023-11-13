import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/pages/login_page/widgets/login_button.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/login_input_field.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/select_app_form.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';

class LoginForm extends StatefulWidget {
  final double height;
  final double width;
  const LoginForm({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final UserState userState = Provider.of<UserState>(context);

    final Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: GoogleFonts.poppins(
            color: AppTheme.of(context).primaryColor,
            fontSize: 33,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        LoginInputField(
          key: const Key('username'),
          label: 'Username',
          controller: userState.emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'The email is required';
            } else if (!EmailValidator.validate(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        LoginInputField(
          key: const Key('password'),
          label: 'Password',
          controller: userState.passwordController,
          isPasswordField: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'The password is required';
            }
            return null;
          },
        ),
        SizedBox(
          width: 170,
          child: CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Remember Me',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF4D4D4D),
                fontWeight: FontWeight.normal,
              ),
            ),
            value: userState.rememberMe,
            onChanged: (value) async {
              await userState.updateRecuerdame();
            },
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppTheme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 40, left: 5),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                //TODO: go to forgot password
              },
              child: Text(
                'Forgot password?',
                style: GoogleFonts.poppins(
                  color: AppTheme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        LoginButton(
          buttonColor: AppTheme.of(context).primaryColor,
          formKey: formKey,
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: size.height > 790
            ? const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )
            : BorderRadius.circular(10),
      ),
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: CustomScrollBar(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/images/rta_logo.png'),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              userState.view == FormView.loginForm ? child : const SelectAppForm(),
            ],
          ),
        ),
      ),
    );
  }
}
