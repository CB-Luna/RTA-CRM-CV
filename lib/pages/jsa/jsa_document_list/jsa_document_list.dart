import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class JSADocumentList extends StatefulWidget {
  const JSADocumentList({super.key});

  @override
  State<JSADocumentList> createState() => _JSADocumentListState();
}

class _JSADocumentListState extends State<JSADocumentList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(
          children: [
            const SideMenu(),
            Container(),
          ],
        ),
      ),
    );
  }
}
