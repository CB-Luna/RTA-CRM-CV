import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../../public/colors.dart';

class InformationContainer extends StatefulWidget {
  const InformationContainer(
      {required this.text, required this.valor, super.key});
  final String text;
  final double valor;

  @override
  State<InformationContainer> createState() => _InformationContainerState();
}

class _InformationContainerState extends State<InformationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.13,
      height: MediaQuery.of(context).size.height * 0.13,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          gradient: whiteGradient,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue)),
      child: Column(children: [
        Text(widget.text, style: AppTheme.of(context).bodyText2),
        const Spacer(),
        Text("${widget.valor}", style: AppTheme.of(context).bodyText2),
      ]),
    );
  }
}
