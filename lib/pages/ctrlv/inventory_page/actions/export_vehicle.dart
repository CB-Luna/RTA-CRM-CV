import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown_inventory.dart';
import 'package:rta_crm_cv/widgets/custom_text_fieldForm.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class ExportVehicleFilter extends StatefulWidget {
  const ExportVehicleFilter({super.key});

  @override
  State<ExportVehicleFilter> createState() => _ExportVehicleFilterState();
}

class _ExportVehicleFilterState extends State<ExportVehicleFilter> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    final formKey = GlobalKey<FormState>();

    List<String> companies = ["All", "ODE", "SMI", "CRY"];

    provider.getLicenses();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Export Vehicle Data',
        height: 634,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose a Company',
                        label: 'Company*',
                        width: 350,
                        list: companies,
                        dropdownValue: provider.companySel,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.getCompanyFilter(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose a Vehicle',
                        label: 'Vehicle*',
                        width: 350,
                        list: provider.plates,
                        dropdownValue: provider.vehicleSel,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.getVehicleExport(val);
                          provider.getLicenses();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: 'Initial Date*',
                          controller:
                              provider.dateExportVehicleDataFirstController,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newfirstDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));
                            if (newfirstDate != null) {
                              provider.dateExportVehicleDataFirstController
                                      .text =
                                  DateFormat("MM/dd/yyyy").format(newfirstDate);
                              provider.getFirstDate(newfirstDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: 'Final Date*',
                          controller:
                              provider.dateExportVehicleDataLastController,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));
                            if (newDate != null) {
                              provider.dateExportVehicleDataLastController
                                      .text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                              provider.getLastDate(newDate);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.save_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Export',
                    onTap: () async {
                      await provider.excelActivityReports(
                          provider.newDate, provider.companySel);
                      if (context.canPop()) context.pop();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
