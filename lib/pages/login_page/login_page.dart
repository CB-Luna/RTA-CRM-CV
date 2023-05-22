import 'package:flutter/material.dart';

import 'package:rta_crm_cv/pages/login_page/widgets/bottom_bar.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/custom_shape.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/login_form.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned(
              left: 32,
              top: 98,
              child: Row(
                children: [
                  const LoginForm(),
                  Transform.translate(
                    offset: const Offset(-17, 0),
                    child: CustomPaint(
                      size: const Size(143, 642),
                      painter: CustomShape(),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              child: BottomBar(),
            )
          ],
        ),
      ),
    );
  }
}
