import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rta_crm_cv/pages/login_page/login_page_desktop.dart';
import 'package:rta_crm_cv/pages/login_page/login_page_mobile.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => LoginPageMobile(
              key: UniqueKey()),
          tablet: (BuildContext context) => LoginPageDesktop(
              key: UniqueKey()),
          desktop: (BuildContext context) => LoginPageDesktop(
              key: UniqueKey()),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
