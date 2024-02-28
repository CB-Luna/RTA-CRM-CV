import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/jsa/jsa_document_list/widgets/custom_card.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
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
            Column(
              children: [
                Flexible(
                  child: Container(
                    // width: 300,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                        children: [Icon(Icons.abc), Text("JSA Document List")]),
                  ),
                ),
                CustomCardJSADocument()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
