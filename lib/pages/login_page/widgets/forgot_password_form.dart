import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/pages/login_page/widgets/login_input_field.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password?',
          style: GoogleFonts.poppins(
            color: AppTheme.of(context).primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Please enter your email below, to send a password recovery link directly to you.',
          style: GoogleFonts.poppins(
            color: const Color(0xFF9E9E9E),
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 20),
        LoginInputField(
          key: const Key('email'),
          label: 'Email',
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
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 40, left: 5),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => userState.changeView(FormView.loginForm),
              child: Text(
                'Back to login',
                style: GoogleFonts.poppins(
                  color: AppTheme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        ContinueButton(
          buttonColor: AppTheme.of(context).primaryColor,
          formKey: formKey,
        ),
      ],
    );
  }
}

class ContinueButton extends StatefulWidget {
  const ContinueButton({
    Key? key,
    required this.buttonColor,
    required this.formKey,
  }) : super(key: key);

  final Color buttonColor;
  final GlobalKey<FormState> formKey;

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
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
              'Continue',
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
