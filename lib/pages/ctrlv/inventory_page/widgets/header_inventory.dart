import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../actions/add_vehicle_pop_up.dart';

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
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: CustomTextField(
              width: 200,
              enabled: true,
              controller: provider.searchController,
              icon: Icons.search,
              label: 'Search',
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              width: 131,
              isLoading: false,
              icon: Icon(Icons.add_box_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Add Vehicle',
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.clearControllers();
                await provider.getCompanies(notify: false);
                await provider.getStatus(notify: false);
                // ignore: use_build_context_synchronously
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AddVehiclePopUp();
                    });
                await provider.updateState();
              },
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.1,
          //   padding: const EdgeInsets.only(left: 10, right: 10, top: 13),
          //   child: CustomTextIconButton(
          //     isLoading: false,
          //     icon: Icon(Icons.add_box_outlined,
          //         color: AppTheme.of(context).primaryBackground),
          //     text: 'Add Vehicle',
          //     onTap: () async {
          //       provider.clearControllers();
          //       await provider.getCompanies(notify: false);
          //       await provider.getStatus(notify: false);
          //       // ignore: use_build_context_synchronously
          //       await showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return const AddVehiclePopUp();
          //           });
          //       await provider.updateState();
          //     },
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              width: 131,
              isLoading: false,
              icon: Icon(Icons.add_box_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Filter',
              color: AppTheme.of(context).primaryColor,
              onTap: () => provider.stateManager!.setShowColumnFilter(
                  !provider.stateManager!.showColumnFilter),
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.1,
          //   padding: const EdgeInsets.only(left: 10, right: 10, top: 13),
          //   child: CustomTextIconButton(
          //     isLoading: false,
          //     icon: Icon(Icons.filter_alt_outlined,
          //         color: AppTheme.of(context).primaryBackground),
          //     text: 'Filter',
          //     onTap: () => provider.stateManager!.setShowColumnFilter(
          //         !provider.stateManager!.showColumnFilter),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.11,
          //   padding: const EdgeInsets.only(left: 10, right: 10, top: 14),
          //   child: CustomTextIconButton(
          //     isLoading: false,
          //     icon: Icon(Icons.filter_alt_outlined,
          //         color: AppTheme.of(context).primaryBackground),
          //     text: 'Filter per month',
          //     onTap: () => provider.stateManager!.setShowColumnFilter(
          //         !provider.stateManager!.showColumnFilter),
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              width: 131,
              isLoading: false,
              icon: Icon(Icons.add_box_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Export Data',
              color: AppTheme.of(context).primaryColor,
              onTap: () {
                provider.excelActivityReports();
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 11.0),
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width * 0.1,
          //     child: CustomTextIconButton(
          //       isLoading: false,
          //       icon: Icon(Icons.download_outlined,
          //           color: AppTheme.of(context).primaryBackground),
          //       text: 'Export Data',
          //       onTap: () {
          //         provider.excelActivityReports();
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
