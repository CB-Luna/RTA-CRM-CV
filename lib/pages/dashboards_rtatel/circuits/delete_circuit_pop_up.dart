// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/circuits_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class DeleteCIrcuitPopUp extends StatefulWidget {
  const DeleteCIrcuitPopUp({super.key});

  @override
  State<DeleteCIrcuitPopUp> createState() => _DeleteCIrcuitPopUpState();
}

class _DeleteCIrcuitPopUpState extends State<DeleteCIrcuitPopUp> {
  @override
  Widget build(BuildContext context) {
    CircuitsProvider provider = Provider.of<CircuitsProvider>(context);

    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        // width: MediaQuery.of(context).size.width * 0.2,
        // height: MediaQuery.of(context).size.height * 0.5,
        width: width * 300,
        height: height * 425, //500
        title: "Delete Circuit",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.arrow_back_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: '',
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.05,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          height: height * 25,
                          width: width * 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Circuit ID: ",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: height * 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              provider.circuitSelected?.cktid ?? "-",
                              style: TextStyle(
                                color: AppTheme.of(context).cryPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.05,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          height: height * 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "RTA Customers: ",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: height * 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              provider.circuitSelected?.rtaCustomer ?? "-",
                              style: TextStyle(
                                color: AppTheme.of(context).cryPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.05,
                          // height: MediaQuery.of(context).size.height * 0.03,
                          height: height * 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Street: ",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          height: height * 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              provider.circuitSelected?.street ?? "-",
                              style: TextStyle(
                                color: AppTheme.of(context).cryPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 80,
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
                  print(
                      "Length antes del deleteCircuit: ${provider.listCircuits.length}");
                  provider.deleteCircuit(provider.circuitSelected!.id!);
                  await provider.updateState();
                  print(
                      "Length Despues del deleteCircuit: ${provider.listCircuits.length}");
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
                  // if (provider.archivardesarchivar == true) {
                  //   await provider.changeStatusInventory(widget.vehicle);
                  //   await provider.updateState();
                  //   if (!mounted) return;
                  //   Navigator.pop(context);
                  // } else {
                  //   await provider
                  //       .changeStatusInventoryBackToActive(widget.vehicle);
                  //   await provider.updateStateNotActive();
                  //   if (!mounted) return;
                  //   Navigator.pop(context);
                  // }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
