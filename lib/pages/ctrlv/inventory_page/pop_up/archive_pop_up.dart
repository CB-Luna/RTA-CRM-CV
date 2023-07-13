import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

class ArchivePopUp extends StatefulWidget {
  const ArchivePopUp({super.key});

  @override
  State<ArchivePopUp> createState() => _ArchivePopUpState();
}

class _ArchivePopUpState extends State<ArchivePopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    provider.getArchiveVehicle();
    return const AlertDialog(backgroundColor: Colors.transparent, content: CustomCard(title: 'List of Archive Vehicle', child: Text("")));
  }
}
