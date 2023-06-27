import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

import '../../../../models/vehicle.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class DeletePopUp extends StatefulWidget {
  final Vehicle vehicle;
  const DeletePopUp({super.key, required this.vehicle});

  @override
  State<DeletePopUp> createState() => _DeletePopUpState();
}

class _DeletePopUpState extends State<DeletePopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            gradient: whiteGradient,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      " ¿Are you sure you want to Delete?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          " Vehicle ID: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" ${widget.vehicle.idVehicle} "),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          " License Plates: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" ${widget.vehicle.licesensePlates}"),
                      ),
                    ],
                  ),
                  CustomTextIconButton(
                    width: 101,
                    isLoading: false,
                    icon: Icon(Icons.archive_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Archive',
                    color: AppTheme.of(context).primaryColor,
                    onTap: () async {
                      // provider.deleteVehicle(widget.vehicle);

                      // provider.updateState();
                    },
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              CustomTextIconButton(
                width: 96,
                isLoading: false,
                icon: Icon(Icons.dangerous_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: 'Delete',
                color: AppTheme.of(context).secondaryColor,
                onTap: () async {
                  provider.deleteVehicle(widget.vehicle);

                  provider.updateState();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomTextIconButton(
                  width: 96,
                  isLoading: false,
                  icon: Icon(Icons.cancel_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Cancel',
                  color: AppTheme.of(context).primaryColor,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
