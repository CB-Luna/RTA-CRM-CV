import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class HomeOwnerFTTHDocument extends StatefulWidget {
  const HomeOwnerFTTHDocument({super.key});

  @override
  State<HomeOwnerFTTHDocument> createState() => _HomeOwnerFTTHDocumentState();
}

class _HomeOwnerFTTHDocumentState extends State<HomeOwnerFTTHDocument> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final userPermissions = currentUser!;
    return Row(
      children: [
        SideMenu(),
        Container(color: Colors.red),
      ],
    );
  }
}
