import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

import '../../../../models/vehicle.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_card.dart';
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
      content: CustomCard(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.5,
        title: "Delete Vehicle",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.05,
              alignment: Alignment.centerLeft,
              child: CustomTextIconButton(
                isLoading: false,
                icon: Icon(Icons.arrow_back_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: '',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      " ¿Are you sure you want to Delete or Archive?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.height * 0.03,
                          decoration: BoxDecoration(
                            color: statusColorCompany(
                                widget.vehicle.company.company, context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              widget.vehicle.company.company,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        color: statusColor(
                            widget.vehicle.company.company, context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          widget.vehicle.licesensePlates,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                  context.pop();
                },
              ),
              CustomTextIconButton(
                width: 101,
                isLoading: false,
                icon: Icon(Icons.archive_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: 'Archive',
                color: AppTheme.of(context).primaryColor,
                onTap: () async {
                  if (provider.archivardesarchivar == true) {
                    await provider.changeStatusInventory(widget.vehicle);
                    await provider.updateState();
                    if (!mounted) return;
                    Navigator.pop(context);
                  } else {
                    await provider
                        .changeStatusInventoryBackToActive(widget.vehicle);
                    await provider.updateStateNotActive();
                    if (!mounted) return;
                    Navigator.pop(context);
                  }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}

Color statusColorCompany(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
