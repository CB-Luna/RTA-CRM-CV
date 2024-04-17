import 'package:flutter/material.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

class AddMoreInfo extends StatefulWidget {
  const AddMoreInfo({super.key});

  @override
  State<AddMoreInfo> createState() => _AddMoreInfoState();
}

class _AddMoreInfoState extends State<AddMoreInfo> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "Add More Info",
      height: 500,
      width: 500,
      child: Column(),
    );
  }
}
