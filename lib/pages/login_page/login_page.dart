import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/bottom_svg.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/login_form.dart';
import 'package:rta_crm_cv/providers/providers.dart';
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
        child: const Stack(
          children: [
            Positioned(
              left: 32,
              top: 98,
              child: LoginForm(),
            ),
            Positioned(
              bottom: 0,
              child: BottomSVG(),
            )
          ],
        ),
      ),
    );
  }
}
