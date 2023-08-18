import 'package:flutter/material.dart';

import 'package:rta_crm_cv/pages/login_page/widgets/bottom_bar.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/login_form.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({Key? key}) : super(key: key);

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                   Padding(
                     padding: 
                      EdgeInsetsDirectional.fromSTEB(0, 25, 0, 25),
                     child: LoginForm(
                      height: 500, 
                      width: 500,
                      ),
                   ),
                  Padding(
                    padding: 
                      EdgeInsetsDirectional.fromSTEB(0, 25, 0, 25),
                    child: BottomBar(),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
