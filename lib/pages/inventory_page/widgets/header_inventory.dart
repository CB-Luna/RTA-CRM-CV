import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';

import '../../../theme/theme.dart';
import '../../../widgets/custom_text_icon_button.dart';
import 'add_vehicle_pop_up.dart';

class InventoryPageHeader extends StatefulWidget {
  InventoryPageHeader({
    Key? key,
  }) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<InventoryPageHeader> createState() => _InventoryPageHeaderState();
}

class _InventoryPageHeaderState extends State<InventoryPageHeader> {
  @override
  Widget build(BuildContext context) {
    final InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            enabled: true,
            controller: provider.searchController,
            icon: Icons.search,
            label: 'Search',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: CustomTextIconButton(
              icon: Icon(Icons.add_box_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Add Vehicle',
              onTap: () async {
                provider.clearControllers();
                await provider.getCompanies(notify: false);
                await provider.getStatus(notify: false);

                // ignore: use_build_context_synchronously
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const AddVehiclePopUp();
                      });
                    });
                await provider.updateState();
              },
            ),
          ),

          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.1,
          //   child: CustomTextIconButton(
          //     icon: Icon(Icons.mode_edit_outlined, color: AppTheme.of(context).primaryBackground),
          //     text: 'Edit Vehicle',
          //     onTap: () {
          //       // showDialog(
          //       //     context: context,
          //       //     builder: (BuildContext context) {
          //       //       return StatefulBuilder(builder: (context, setState) {
          //       //         return const AddUserPopUp();
          //       //       });
          //       //     });
          //     },
          //   ),
          // ),
          // const SizedBox(
          //   width: 20,
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.1,
          //   child: CustomTextIconButton(
          //     color: const Color(0xffBF2135),
          //     icon: Icon(Icons.delete_outline_outlined, color: AppTheme.of(context).primaryBackground),
          //     text: 'Delete Vehicle',
          //     onTap: () {
          //       // showDialog(
          //       //     context: context,
          //       //     builder: (BuildContext context) {
          //       //       return StatefulBuilder(builder: (context, setState) {
          //       //         return const AddUserPopUp();
          //       //       });
          //       //     });
          //     },
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            padding: const EdgeInsets.all(10),
            child: CustomTextIconButton(
              icon: Icon(Icons.download_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Export Data',
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return StatefulBuilder(builder: (context, setState) {
                //         return const AddUserPopUp();
                //       });
                //     });
              },
            ),
          ),
          CustomTextIconButton(
            icon: Icon(Icons.filter_alt_outlined,
                color: AppTheme.of(context).primaryBackground),
            text: 'Filter',
            onTap: () => provider.stateManager!
                .setShowColumnFilter(!provider.stateManager!.showColumnFilter),
          ),
          //Buscar(empleadoProvider: empleadoProvider),
          /*
          // Add Vehicle
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff2E5596),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                children: const [
                  Text(
                    "Add Vehicle",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.inventory_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          // Edit Vehicle
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff2E5596),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Edit Vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Delete Vehicle
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xffBF2135),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Delete Vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Export Data
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff2E5596),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Export Data",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          */
        ],
      ),
    );
  }
}
