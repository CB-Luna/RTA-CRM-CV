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

    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth >= 1000) {
        return const LoginPageDesktop();
      } else if (constraints.maxWidth < 1000 && constraints.maxWidth > 200) {
        return const LoginPageMobile();
      } else{
        return Container(
          color: Colors.green,
        );
      }
    }));
    
  }
}
