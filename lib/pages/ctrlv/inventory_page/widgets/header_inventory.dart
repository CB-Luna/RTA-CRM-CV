import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../actions/add_vehicle_pop_up.dart';
import '../actions/export_data.dart';
import '../actions/export_vehicle.dart';

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
  List<String> company = ["All", "Ode", "Smi", "Cry"];

  @override
  Widget build(BuildContext context) {
    final InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              mainAxisAlignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width * 0.10,
              isLoading: false,
              icon: Icon(Icons.add_box_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Add Vehicle',
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.clearControllers(notify: false);
                await provider.getCompanies(notify: false);
                await provider.getStatus(notify: false);
                await provider.getOwnerShip(notify: false);
                provider.visibilty = false;

                if (!mounted) return;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AddVehiclePopUp();
                    });
                await provider.updateState();
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              width: MediaQuery.of(context).size.width * 0.06,
              mainAxisAlignment: MainAxisAlignment.center,
              isLoading: false,
              icon: Icon(Icons.filter_alt_outlined,
                  color: AppTheme.of(context).primaryBackground),
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
              text: 'Filter',
              color: AppTheme.of(context).primaryColor,
              onTap: () => provider.stateManager!.setShowColumnFilter(
                  !provider.stateManager!.showColumnFilter),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              mainAxisAlignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width * 0.10,
              isLoading: false,
              icon: Icon(Icons.download_for_offline_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Export Data',
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.clearControllerExportData(notify: false);
                if (!mounted) return;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ExportDataFilter();
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              mainAxisAlignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width * 0.14,
              isLoading: false,
              icon: Icon(Icons.download_for_offline_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Export Vehicle Data',
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.clearControllersExportVehicleData(notify: false);
                if (!mounted) return;
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ExportVehicleFilter();
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              mainAxisAlignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width * 0.10,
              isLoading: false,
              icon: Icon(Icons.archive_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Not Active',
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.archivardesarchivar = false;
                await provider.updateStatusVehicle();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: CustomTextIconButton(
              mainAxisAlignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width * 0.10,
              isLoading: false,
              icon: Icon(Icons.open_in_browser_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Active',
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.archivardesarchivar = true;
                await provider.updateState();
              },
            ),
          ),
        ],
      ),
    );
  }
}
