import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisibility = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryColor,
      body: Container(),
    );
  }
}
