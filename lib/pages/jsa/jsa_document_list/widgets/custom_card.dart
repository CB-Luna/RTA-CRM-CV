import 'package:flutter/material.dart';

import '../../../../widgets/custom_card.dart';

class CustomCardJSADocument extends StatefulWidget {
  const CustomCardJSADocument({super.key});

  @override
  State<CustomCardJSADocument> createState() => _CustomCardJSADocumentState();
}

class _CustomCardJSADocumentState extends State<CustomCardJSADocument> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(title: "JSA Document List", child: Container());
  }
}
